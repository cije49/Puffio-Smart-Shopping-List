import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';
import 'package:shop_list_pro/l10n/app_localizations_en.dart';
import 'package:shop_list_pro/l10n/app_localizations_hr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/widget_service.dart';
import '../data/models/shopping_list_item.dart';
import '../features/home/home_screen.dart';
import '../features/shopping_list/shopping_list_screen.dart';
import '../features/shopping_list/shopping_list_providers.dart';
import '../features/list_management/list_management_screen.dart';
import '../features/settings/settings_screen.dart';
import '../providers/app_providers.dart';
import 'theme.dart';

class ShopListProApp extends ConsumerWidget {
  const ShopListProApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider); // null = follow system

    // Auto-update the home-screen widget whenever items change.
    ref.listen<AsyncValue<List<ShoppingListItem>>>(
      activeListItemsProvider,
      (_, next) {
        if (!ref.read(widgetEnabledProvider)) return;
        next.whenData((items) async {
          final listId = ref.read(activeListIdProvider);
          if (listId == null) return;
          final list =
              await ref.read(shoppingListRepoProvider).getById(listId);
          final unchecked = items.where((i) => !i.isChecked).toList();

          // This listener lives above MaterialApp, so resolve the
          // localizations directly from the chosen (or system) locale.
          final lang = (ref.read(localeProvider) ??
                  ui.PlatformDispatcher.instance.locale)
              .languageCode;
          final AppLocalizations t =
              lang == 'hr' ? AppLocalizationsHr() : AppLocalizationsEn();

          await WidgetService.update(
            listName: list?.name ?? t.appTitle,
            remainingCount: unchecked.length,
            items: unchecked
                .take(WidgetService.maxItems)
                .map((i) => i.name)
                .toList(),
            countText: t.widgetLeftCount(unchecked.length),
            emptyTitle: t.widgetAllDone,
            emptySubtitle: t.widgetEmptyHint,
            moreTemplate: t.widgetMoreTemplate,
          );
        });
      },
    );

    return MaterialApp(
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
        '/settings': (_) => const SettingsScreen(),
      },
    );
  }
}
