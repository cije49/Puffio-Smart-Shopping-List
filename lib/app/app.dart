import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';

import '../features/calendar/calendar_screen.dart';
import '../features/home/home_screen.dart';
import '../features/list_management/list_management_screen.dart';
import '../features/help/help_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/shopping_list/shopping_list_screen.dart';
import '../providers/app_providers.dart';
import 'theme.dart';

class ShopListProApp extends ConsumerStatefulWidget {
  const ShopListProApp({super.key});

  @override
  ConsumerState<ShopListProApp> createState() => _ShopListProAppState();
}

class _ShopListProAppState extends ConsumerState<ShopListProApp> {
  final _navKey = GlobalKey<NavigatorState>();
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  StreamSubscription<String>? _notificationTapSub;

  @override
  void initState() {
    super.initState();

    final notifications = ref.read(notificationServiceProvider);

    // Reminder notification tapped while the app was closed (cold start).
    notifications.initialLaunchPayload().then((payload) {
      if (payload != null) _openItemFromNotification(payload);
    });

    // Reminder tapped while the app is running / in background.
    _notificationTapSub =
        notifications.onNotificationTap.listen(_openItemFromNotification);
  }

  @override
  void dispose() {
    _notificationTapSub?.cancel();
    super.dispose();
  }

  /// Navigate to the list containing the item a reminder points at, and
  /// ask the list screen to scroll to and briefly highlight that item.
  /// Fallbacks: item gone but list exists → open the list with a short
  /// message; list gone (or malformed payload) → home screen + message.
  Future<void> _openItemFromNotification(String payload) async {
    int? itemId;
    int? payloadListId;
    try {
      final map = jsonDecode(payload) as Map<String, dynamic>;
      itemId = map['itemId'] as int?;
      payloadListId = map['listId'] as int?;
    } catch (_) {
      // Malformed payload: treated as a fully missing target below.
    }

    // Always re-resolve from the database: the item may have been deleted,
    // edited, or moved to another list since the reminder was scheduled.
    final item = itemId != null
        ? await ref.read(shoppingItemRepoProvider).getById(itemId)
        : null;
    // Prefer the item's current list (handles "moved to another list");
    // fall back to the payload's list when the item itself is gone.
    final listId = item?.listId ?? payloadListId;
    final list = listId != null
        ? await ref.read(shoppingListRepoProvider).getById(listId)
        : null;
    final listExists = list != null && !list.isArchived;

    if (!listExists) {
      _goHome();
      _showItemGoneMessage();
      return;
    }

    if (item == null) {
      // The list survives but the item doesn't: open the list anyway and
      // explain briefly.
      await ref.read(activeListIdProvider.notifier).setActive(list.id);
      _goToList();
      _showItemGoneMessage();
      return;
    }

    // Ask the list screen to reveal + highlight the item once it renders.
    ref.read(notificationHighlightProvider.notifier).state = item.id;
    await ref.read(activeListIdProvider.notifier).setActive(item.listId);
    _goToList();
  }

  /// Reset the stack to Home → List (idempotent, mirrors the previous
  /// widget-tap navigation).
  void _goToList() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nav = _navKey.currentState;
      if (nav == null) return;
      nav.popUntil((route) => route.isFirst);
      nav.pushNamed('/list');
    });
  }

  void _goHome() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navKey.currentState?.popUntil((route) => route.isFirst);
    });
  }

  void _showItemGoneMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _navKey.currentContext;
      if (ctx == null) return;
      _messengerKey.currentState
        ?..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(ctx).notificationItemGone),
        ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider); // null = follow system

    return MaterialApp(
      navigatorKey: _navKey,
      scaffoldMessengerKey: _messengerKey,
      onGenerateTitle: (ctx) => AppLocalizations.of(ctx).appTitle,
      debugShowCheckedModeBanner: false,

      // Localization
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // Routes
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/list': (_) => const ShoppingListScreen(),
        '/lists': (_) => const ListManagementScreen(),
        '/calendar': (_) => const CalendarScreen(),
        '/settings': (_) => const SettingsScreen(),
        '/help': (_) => const HelpScreen(),
      },
    );
  }
}
