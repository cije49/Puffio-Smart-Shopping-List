import 'dart:ui' as ui;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';
import 'package:shop_list_pro/l10n/app_localizations_en.dart';
import 'package:shop_list_pro/l10n/app_localizations_hr.dart';

import '../../providers/app_providers.dart';
import 'widget_service.dart';

/// Reads the current active list straight from the database and pushes a
/// fresh snapshot to the home-screen widget. Used on app startup, on every
/// list mutation, and immediately when the widget toggle is switched on —
/// so widget storage never sits empty or stale while the toggle is enabled.
class WidgetSyncService {
  final Ref _ref;
  const WidgetSyncService(this._ref);

  Future<void> sync() async {
    if (!_ref.read(widgetEnabledProvider)) return;

    final listId = _ref.read(activeListIdProvider);
    if (listId == null) return;

    final list = await _ref.read(shoppingListRepoProvider).getById(listId);
    final items =
        await _ref.read(shoppingItemRepoProvider).getByList(listId);

    // Same visual order as the list screen: position, then creation time.
    final unchecked = items.where((i) => !i.isChecked).toList()
      ..sort((a, b) {
        final pa = a.position ?? 999999;
        final pb = b.position ?? 999999;
        if (pa != pb) return pa.compareTo(pb);
        return a.createdAt.compareTo(b.createdAt);
      });

    // This runs outside the widget tree, so resolve localizations directly
    // from the chosen (or system) locale.
    final lang = (_ref.read(localeProvider) ??
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
  }
}
