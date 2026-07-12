import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:isar_community/isar.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';
import 'package:shop_list_pro/l10n/app_localizations_en.dart';
import 'package:shop_list_pro/l10n/app_localizations_hr.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../data/models/shopping_list.dart';
import '../../data/models/shopping_list_item.dart';
import '../constants.dart';
import '../../providers/app_providers.dart';

/// Computes the moment a reminder should fire for [item], or null when the
/// item has no date or its reminder is disabled. Items without a specific
/// time anchor at [kDefaultReminderHour] on the due day.
DateTime? reminderTriggerTime(ShoppingListItem item) {
  final due = item.dueDate;
  if (due == null || !item.reminderEnabled) return null;
  final anchor = item.hasDueTime
      ? due
      : DateTime(due.year, due.month, due.day, kDefaultReminderHour);
  return anchor.subtract(Duration(minutes: item.reminderOffsetMinutes));
}

/// The plugin's repeat matcher for a stored repeat value, or null for
/// one-shot reminders.
DateTimeComponents? repeatMatcherFor(String repeat) => switch (repeat) {
      'daily' => DateTimeComponents.time,
      'weekly' => DateTimeComponents.dayOfWeekAndTime,
      'monthly' => DateTimeComponents.dayOfMonthAndTime,
      'yearly' => DateTimeComponents.dateAndTime,
      _ => null,
    };

/// Advances [trigger] to its next future occurrence for a repeating
/// reminder (the plugin requires the first scheduled date to be in the
/// future and to match the repeat components).
DateTime nextRepeatOccurrence(DateTime trigger, String repeat) {
  var next = trigger;
  final now = DateTime.now();
  while (!next.isAfter(now)) {
    next = switch (repeat) {
      'daily' => next.add(const Duration(days: 1)),
      'weekly' => next.add(const Duration(days: 7)),
      'monthly' => _addOneMonth(next),
      'yearly' =>
        DateTime(next.year + 1, next.month, next.day, next.hour, next.minute),
      _ => next.add(const Duration(days: 1)),
    };
  }
  return next;
}

DateTime _addOneMonth(DateTime d) {
  final year = d.month == 12 ? d.year + 1 : d.year;
  final month = d.month == 12 ? 1 : d.month + 1;
  final lastDay = DateTime(year, month + 1, 0).day;
  final day = d.day > lastDay ? lastDay : d.day;
  return DateTime(year, month, day, d.hour, d.minute);
}

/// Schedules, updates, and cancels local reminder notifications.
///
/// One notification per item: the platform notification id is derived from
/// the item's database id, so re-scheduling naturally replaces any previous
/// reminder for the same item.
///
/// Reboot safety: flutter_local_notifications persists its schedule and
/// re-registers it via its boot receiver (declared in AndroidManifest.xml).
/// On top of that, [resyncAll] runs on every app start and after backup
/// imports, rebuilding the entire schedule from the database.
class NotificationService {
  final Ref _ref;
  NotificationService(this._ref);

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  static const String _channelId = 'item_reminders';

  /// Platform notification id for an item (Android ids are 32-bit).
  static int notificationIdFor(int itemId) => itemId & 0x7fffffff;

  final StreamController<String> _tapController =
      StreamController<String>.broadcast();

  /// Payloads of reminders tapped while the app is running (foreground or
  /// background). Cold-start taps arrive via [initialLaunchPayload].
  Stream<String> get onNotificationTap => _tapController.stream;

  /// Payload of the notification that launched the app from a fully closed
  /// state, or null when the app was started normally.
  Future<String?> initialLaunchPayload() async {
    await init();
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp != true) return null;
    return details?.notificationResponse?.payload;
  }

  /// JSON payload identifying the reminder's target.
  static String payloadFor(ShoppingListItem item) =>
      jsonEncode({'listId': item.listId, 'itemId': item.id});

  // ---------------------------------------------------------------------------
  // Initialization & permissions
  // ---------------------------------------------------------------------------

  Future<void> init() async {
    if (_initialized) return;
    tzdata.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (_) {
      // Fall back to the package default; scheduling still works.
    }
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      // Fires when a notification is tapped while the app is alive.
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          _tapController.add(payload);
        }
      },
    );
    _initialized = true;
  }

  /// Ensures the runtime notification permission (Android 13+).
  /// Returns true when notifications may be shown.
  Future<bool> ensurePermission() async {
    await init();
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) return true;
    if (await android.areNotificationsEnabled() ?? false) return true;
    return await android.requestNotificationsPermission() ?? false;
  }

  // ---------------------------------------------------------------------------
  // Scheduling
  // ---------------------------------------------------------------------------

  /// Schedules (or replaces) the reminder for [item].
  /// Cancels instead when the reminder is disabled, the item is checked,
  /// or a one-shot trigger time is already in the past. Repeating
  /// reminders roll forward to their next future occurrence instead.
  Future<void> scheduleForItem(ShoppingListItem item,
      {String? listName}) async {
    var trigger = reminderTriggerTime(item);
    final matcher = repeatMatcherFor(item.reminderRepeat);
    if (trigger == null || item.isChecked) {
      await cancelForItem(item.id);
      return;
    }
    if (!trigger.isAfter(DateTime.now())) {
      if (matcher == null) {
        // One-shot reminder in the past: nothing to schedule.
        await cancelForItem(item.id);
        return;
      }
      trigger = nextRepeatOccurrence(trigger, item.reminderRepeat);
    }

    await init();
    final t = _localizations();

    // Exact alarms need a user-granted special permission on Android 12+
    // (denied by default on 14+). Fall back to inexact scheduling — for
    // shopping reminders a few minutes of drift is acceptable.
    var mode = AndroidScheduleMode.inexactAllowWhileIdle;
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null &&
        (await android.canScheduleExactNotifications() ?? false)) {
      mode = AndroidScheduleMode.exactAllowWhileIdle;
    }

    await _plugin.zonedSchedule(
      id: notificationIdFor(item.id),
      title: item.name,
      body: listName != null && listName.isNotEmpty
          ? t.notificationReminderBody(listName)
          : t.notificationReminderBodyNoList,
      scheduledDate: tz.TZDateTime.from(trigger, tz.local),
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          t.notificationChannelName,
          channelDescription: t.notificationChannelDescription,
          importance: Importance.high,
          priority: Priority.high,
          category: AndroidNotificationCategory.reminder,
        ),
      ),
      androidScheduleMode: mode,
      payload: payloadFor(item),
      // Repeats the notification at each matching date/time component
      // (daily/weekly/monthly/yearly); null = fire once.
      matchDateTimeComponents: matcher,
    );
  }

  Future<void> cancelForItem(int itemId) async {
    await init();
    await _plugin.cancel(id: notificationIdFor(itemId));
  }

  Future<void> cancelMany(Iterable<int> itemIds) async {
    await init();
    for (final id in itemIds) {
      await _plugin.cancel(id: notificationIdFor(id));
    }
  }

  Future<void> cancelAll() async {
    await init();
    await _plugin.cancelAll();
  }

  // ---------------------------------------------------------------------------
  // Full re-sync (app start, backup import, clear-all)
  // ---------------------------------------------------------------------------

  /// Rebuilds the entire notification schedule from the database: cancels
  /// everything pending, then re-schedules each unchecked item with an
  /// enabled reminder in the future. Safe to call repeatedly.
  Future<void> resyncAll() async {
    await init();
    await _plugin.cancelAll();

    final isar = _ref.read(isarProvider);
    final items = await isar.shoppingListItems
        .filter()
        .reminderEnabledEqualTo(true)
        .and()
        .dueDateIsNotNull()
        .and()
        .isCheckedEqualTo(false)
        .findAll();
    if (items.isEmpty) return;

    final lists = await isar.shoppingLists.where().findAll();
    final listNames = {for (final l in lists) l.id: l.name};

    for (final item in items) {
      await scheduleForItem(item, listName: listNames[item.listId]);
    }
  }

  // ---------------------------------------------------------------------------
  // Localization (runs outside the widget tree, so resolve directly)
  // ---------------------------------------------------------------------------

  AppLocalizations _localizations() {
    final lang = (_ref.read(localeProvider) ??
            ui.PlatformDispatcher.instance.locale)
        .languageCode;
    return lang == 'hr' ? AppLocalizationsHr() : AppLocalizationsEn();
  }
}
