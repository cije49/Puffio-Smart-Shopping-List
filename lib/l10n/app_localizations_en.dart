import 'app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn() : super('en');

  @override
  String get appTitle => 'Puffio';

  @override
  String get homeMenuLists => 'Manage Lists';
  @override
  String get homeMenuSettings => 'Settings';
  @override
  String get homeDefaultListName => 'My List';
  @override
  String get homeInputHint => 'Add items — separate with comma or newline';
  @override
  String get homeAddButton => 'Add';
  @override
  String get homeSectionPattern => 'You might need these';
  @override
  String get homeSectionFrequent => 'Frequently bought';
  @override
  String get homeSectionRecent => 'Quick Add (Recent)';
  @override
  String get homeSectionFavorites => 'Favorites';
  @override
  String get homeEmptyHint =>
      'Start adding items to see quick-add suggestions here.';
  @override
  String get homeOpenListFab => 'Open List';
  @override
  String get homeListEmptyCard => 'Your list is empty';
  @override
  String get homeListCardHint => 'Tap chips or type to start adding items';

  @override
  String get listTitleDefault => 'Shopping List';
  @override
  String get listTitleAllDone => 'All done!';
  @override
  String get listMenuRename => 'Rename';
  @override
  String get listMenuDuplicate => 'Duplicate';
  @override
  String get listMenuDelete => 'Delete';
  @override
  String get listEmpty => 'Your list is empty';
  @override
  String get listEmptyHint => 'Go back to the home screen to add items.';
  @override
  String get listGoBack => 'Go back';
  @override
  String get listCheckedSection => 'Checked';
  @override
  String get listRenameDialogTitle => 'Rename List';
  @override
  String get listRenameHint => 'New name';
  @override
  String get listDeleteDialogTitle => 'Delete this list?';
  @override
  String get listDeleteMessage =>
      'Items will be removed but history is kept.';
  @override
  String get listDuplicatedSnackBar => 'List duplicated';
  @override
  String get listDeletedSnackBar => 'List deleted';
  @override
  String get listQuickAddHint => 'Add items — comma or newline separated';

  @override
  String get listsTitle => 'My Lists';
  @override
  String get listsNone => 'No lists yet.';
  @override
  String get listsActive => 'Active list';
  @override
  String get listsSetActive => 'Tap to set active';
  @override
  String get listsMenuActivate => 'Set as active';
  @override
  String get listsFabNewList => 'New List';
  @override
  String get listsNewListDialogTitle => 'New List';
  @override
  String get listsNewListHint => 'List name';
  @override
  String get listsCreateButton => 'Create';
  @override
  String get listsDeleteMessage =>
      'Items will be removed; history is preserved.';

  @override
  String get settingsTitle => 'Settings';
  @override
  String get settingsTheme => 'Theme';
  @override
  String get settingsThemeSystem => 'System';
  @override
  String get settingsThemeLight => 'Light';
  @override
  String get settingsThemeDark => 'Dark';
  @override
  String get settingsLanguage => 'Language';
  @override
  String get settingsLanguageSystem => 'System default';
  @override
  String get settingsLanguageEnglish => 'English';
  @override
  String get settingsLanguageCroatian => 'Hrvatski';
  @override
  String get settingsClearData => 'Clear all data';
  @override
  String get settingsClearDataSubtitle =>
      'Remove all lists, items, history, and settings';
  @override
  String get settingsClearDialogTitle => 'Clear all data?';
  @override
  String get settingsClearDialogMessage =>
      'This removes every list, item, usage history, and resets settings. This cannot be undone.';
  @override
  String get settingsClearedSnackBar => 'All data cleared.';

  @override
  String get settingsWidget => 'Home screen widget';
  @override
  String get settingsWidgetSubtitle =>
      'Show shopping list on your home screen';

  @override
  String get editItemTitle => 'Edit Item';
  @override
  String get editItemName => 'Item name';
  @override
  String get editItemQuantity => 'Quantity';
  @override
  String get editItemUnit => 'Unit (optional)';
  @override
  String get editItemUnitNone => 'None';
  @override
  String get editItemCategory => 'Category';
  @override
  String get editItemSave => 'Save';

  @override
  String get commonCancel => 'Cancel';
  @override
  String get commonDelete => 'Delete';
  @override
  String get commonRename => 'Rename';
  @override
  String get commonSave => 'Save';
  @override
  String get commonClearAll => 'Clear all';
  @override
  String get commonUndo => 'Undo';

  @override
  String get itemDeletedSnackBar => 'Item deleted';

  @override
  String get commonImport => 'Import';

  @override
  String get commonRemove => 'Remove';

  @override
  String get listMenuClearCompleted => 'Clear completed';

  @override
  String get settingsBackupExport => 'Export backup';

  @override
  String get settingsBackupExportSubtitle =>
      'Save all lists and history to a file';

  @override
  String get settingsBackupImport => 'Import backup';

  @override
  String get settingsBackupImportSubtitle =>
      'Restore lists and history from a backup file';

  @override
  String get settingsImportDialogTitle => 'Import backup?';

  @override
  String get settingsImportDialogMessage =>
      'This replaces all current lists, items, and history with the backup contents.';

  @override
  String get settingsExportedSnackBar => 'Backup saved';

  @override
  String get settingsImportedSnackBar => 'Backup imported';

  @override
  String get settingsImportFailedSnackBar =>
      'Import failed: not a valid backup file';

  @override
  String get historyRemove => 'Remove from suggestions';

  @override
  String get historyRemoveDialogTitle => 'Remove from suggestions?';

  @override
  String get historyRemoveDialogMessage =>
      'This permanently deletes the usage history for this item. Items already on your lists stay untouched.';

  @override
  String get historyRenameDialogTitle => 'Rename suggestion';

  @override
  String get widgetAllDone => 'All done!';

  @override
  String get widgetEmptyHint => 'Your shopping list is empty.';

  @override
  String get widgetMoreTemplate => '+ %d more';

  @override
  String widgetLeftCount(int count) => '$count left';

  @override
  String get catDairy => 'Dairy';
  @override
  String get catBakery => 'Bakery';
  @override
  String get catMeatFish => 'Meat & Fish';
  @override
  String get catVegetables => 'Vegetables';
  @override
  String get catFruits => 'Fruits';
  @override
  String get catPantry => 'Pantry';
  @override
  String get catBeverages => 'Beverages';
  @override
  String get catFrozen => 'Frozen';
  @override
  String get catSnacks => 'Snacks';
  @override
  String get catHousehold => 'Household';
  @override
  String get catOther => 'Other';

  // ---------------------------------------------------------------------------
  // Parameterised messages
  // ---------------------------------------------------------------------------
  @override
  String homeItemsCheckedSummary(int checked, int total) {
    final itemWord = total == 1 ? '1 item' : '$total items';
    return '$checked of $itemWord checked';
  }

  @override
  String listsDuplicatedSnackBar(String name) => '"$name" duplicated';

  @override
  String listsDeleteDialogTitle(String name) => 'Delete "$name"?';
}
