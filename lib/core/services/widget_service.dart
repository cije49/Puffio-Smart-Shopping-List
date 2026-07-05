import 'package:home_widget/home_widget.dart';

/// Manages the Android home-screen widget data via the `home_widget` package.
/// All strings are localized on the Dart side; the native widget only renders.
class WidgetService {
  WidgetService._();

  static const _androidName = 'ShoppingListWidgetProvider';

  /// Number of item slots in the native layout.
  static const maxItems = 15;

  /// Push the current active-list state to the home-screen widget.
  static Future<void> update({
    required String listName,
    required int remainingCount,
    required List<String> items,
    required String countText,
    required String emptyTitle,
    required String emptySubtitle,
    required String moreTemplate,
  }) async {
    await HomeWidget.saveWidgetData<String>('title', listName);
    await HomeWidget.saveWidgetData<int>('count', remainingCount);
    await HomeWidget.saveWidgetData<String>('count_text', countText);
    await HomeWidget.saveWidgetData<String>('empty_title', emptyTitle);
    await HomeWidget.saveWidgetData<String>('empty_subtitle', emptySubtitle);
    await HomeWidget.saveWidgetData<String>('more_template', moreTemplate);

    for (int i = 0; i < maxItems; i++) {
      final text = i < items.length ? items[i] : '';
      await HomeWidget.saveWidgetData<String>('item_$i', text);
    }

    await HomeWidget.updateWidget(androidName: _androidName);
  }

  /// Clear widget data (e.g. when user disables the widget toggle).
  static Future<void> clear() async {
    await HomeWidget.saveWidgetData<String>('title', '');
    await HomeWidget.saveWidgetData<int>('count', 0);
    await HomeWidget.saveWidgetData<String>('count_text', '');
    await HomeWidget.saveWidgetData<String>('empty_title', '');
    await HomeWidget.saveWidgetData<String>('empty_subtitle', '');
    for (int i = 0; i < maxItems; i++) {
      await HomeWidget.saveWidgetData<String>('item_$i', '');
    }
    await HomeWidget.updateWidget(androidName: _androidName);
  }
}
