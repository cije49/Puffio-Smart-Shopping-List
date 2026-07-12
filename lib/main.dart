import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_list_pro/l10n/app_localizations_en.dart';
import 'package:shop_list_pro/l10n/app_localizations_hr.dart';
import 'app/app.dart';
import 'core/database.dart';
import 'data/repositories/category_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'providers/app_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Open Isar database
  final isar = await openIsar();

  // 2. Seed default categories on first launch
  await CategoryRepository(isar).seedDefaults();

  // 3. Load persisted settings
  final settingsRepo = SettingsRepository();
  final themeMode = themeModeFromString(await settingsRepo.getThemeMode());
  final localeCode = await settingsRepo.getLocaleCode();
  final initialLocale = localeCode != null ? Locale(localeCode) : null;
  final swipeLearned = await settingsRepo.getSwipeLearnedListIds();

  // 4. Build the provider container with overrides
  final container = ProviderContainer(
    overrides: [
      isarProvider.overrideWithValue(isar),
      initialThemeModeProvider.overrideWithValue(themeMode),
      initialLocaleProvider.overrideWithValue(initialLocale),
      initialSwipeDeleteLearnedProvider.overrideWithValue(swipeLearned),
    ],
  );

  // 5. Ensure an active list exists (localized default name)
  final lang =
      (initialLocale ?? ui.PlatformDispatcher.instance.locale).languageCode;
  final defaultListName = lang == 'hr'
      ? AppLocalizationsHr().homeDefaultListName
      : AppLocalizationsEn().homeDefaultListName;
  await container
      .read(activeListIdProvider.notifier)
      .load(defaultName: defaultListName);

  // 6. Initialize local notifications and rebuild the reminder schedule
  //    from the database. The plugin's boot receiver already restores
  //    reminders after a reboot; this start-up resync is a second safety
  //    net (and cleans up any orphaned notifications).
  final notifications = container.read(notificationServiceProvider);
  await notifications.init();
  // Fire-and-forget: don't delay first frame on the schedule rebuild.
  // ignore: unawaited_futures
  notifications.resyncAll();

  // 7. Run the app
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const ShopListProApp(),
    ),
  );
}
