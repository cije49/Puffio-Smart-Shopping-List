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
  String get homeSectionFrequent => 'Suggested for you';
  @override
  String get homeSectionFavorites => 'Pinned';
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
  String get listSwipeDeleteHint => 'Tip: swipe an item left to delete it';

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
  String get listsNewListHint => 'List name (optional)';
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
  String get editItemSave => 'Save item';
  @override
  String get editItemPrice => 'Price (optional)';
  @override
  String get editItemLocation => 'Location (optional)';
  @override
  String get editItemLocationHint => 'e.g. Lidl, Aisle 4, Pharmacy';
  @override
  String get editItemSectionSchedule => 'Date & reminder';
  @override
  String get editItemAddDate => 'Add date';
  @override
  String get editItemAddTime => 'Add time';
  @override
  String get editItemRemoveDate => 'Remove date';
  @override
  String get editItemRemoveTime => 'Remove time';
  @override
  String get editItemReminderToggle => 'Remind me';
  @override
  String get editItemReminderWhen => 'Reminder time';
  @override
  String get editItemRepeat => 'Repeat';

  @override
  String get repeatNever => 'Never';
  @override
  String get repeatDaily => 'Daily';
  @override
  String get repeatWeekly => 'Weekly';
  @override
  String get repeatMonthly => 'Monthly';
  @override
  String get repeatYearly => 'Yearly';

  @override
  String get reminderAtTime => 'At the selected time';
  @override
  String get reminder30MinBefore => '30 minutes before';
  @override
  String get reminder1HourBefore => '1 hour before';
  @override
  String get reminder3HoursBefore => '3 hours before';
  @override
  String get reminder1DayBefore => '1 day before';
  @override
  String get reminder2DaysBefore => '2 days before';
  @override
  String get reminder1WeekBefore => '1 week before';
  @override
  String get reminderPermissionDenied =>
      'Notifications are turned off for Puffio. Allow them in system settings to get reminders.';

  @override
  String get notificationChannelName => 'Item reminders';
  @override
  String get notificationChannelDescription =>
      'Reminders for shopping items with a date';
  @override
  String get notificationReminderBodyNoList => 'Shopping reminder';
  @override
  String get notificationItemGone =>
      'That item is no longer on your lists.';

  @override
  String get calendarTitle => 'Calendar';
  @override
  String get calendarEmptyTitle => 'No scheduled items';
  @override
  String get calendarEmptyHint =>
      'Add a date to an item — edit the item and pick a date. It will show up here.';
  @override
  String get calendarNoItemsForDay => 'Nothing scheduled for this day.';
  @override
  String get calendarOpenListTooltip => 'Open list';

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
  String get itemPinnedSnackBar => 'Added to pinned items';

  @override
  String get itemUnpinnedSnackBar => 'Removed from pinned items';

  @override
  String get commonImport => 'Import';

  @override
  String get commonRemove => 'Remove';

  @override
  String get listMenuClearCompleted => 'Clear completed';

  @override
  String get listMenuClearAll => 'Clear whole list';

  @override
  String get listClearAllDialogTitle => 'Clear whole list?';

  @override
  String get listClearAllDialogMessage =>
      'This will remove all items from your list. This action cannot be undone.';

  @override
  String get listClearAllConfirm => 'Clear list';

  @override
  String get listClearCompletedDialogTitle => 'Clear completed items?';

  @override
  String get listClearCompletedDialogMessage =>
      'This will remove all completed items from your list. This action cannot be undone.';

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
  String get historyUnpin => 'Remove from pinned';

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
  String get settingsHelp => 'Help & tips';

  @override
  String get settingsWhatsNew => 'What\'s new';

  @override
  String get settingsWhatsNewSubtitle =>
      'See what changed in this version';

  @override
  String get whatsNewBody =>
      '• Item dates and reminders — pick a date and time, get notified, and let reminders repeat daily, weekly, monthly, or yearly.\n\n'
      '• Calendar overview — tap the calendar icon on the Home screen to see every scheduled item in one place.\n\n'
      '• Price and location — note where an item was cheapest; Puffio remembers both for the next time you add it.\n\n'
      '• Tap a reminder notification to jump straight to the item in its list.\n\n'
      '• Better support for enlarged system text across the whole app.\n\n'
      '• The home-screen widget has been removed.';

  @override
  String get helpIntro =>
      'Puffio gets smarter the more you use it. Here\'s how the main features work.';

  @override
  String get helpSuggestionsTitle => 'Smart suggestions';

  @override
  String get helpSuggestionsBody =>
      'Puffio learns from the items you add and complete. Over time, it suggests products you\'re likely to need again, right on the Home screen. Just tap a suggestion to add it instantly.\n\nSuggestions automatically adapt to your shopping habits and timing, and items already on your current list won\'t be suggested again.';

  @override
  String get helpPinnedTitle => 'Pinned items';

  @override
  String get helpPinnedBody =>
      'Tap the {star} on any item to pin it.\n\nPinned items always appear at the top of the Home screen (unless they\'re already on your current shopping list), making them perfect for things you never want to forget — even if you only buy them occasionally.\n\nTap the star again to remove the pin.';

  @override
  String get helpSwipeTitle => 'Swipe to delete';

  @override
  String get helpSwipeBody =>
      'Swipe any item to the left to delete it.\n\nDeleted something by accident? Tap Undo before it disappears.';

  @override
  String get helpUnitsTitle => 'Units and quantities';

  @override
  String get helpUnitsBody =>
      'Units are always optional — Puffio never guesses them.\n\nOnce you assign a unit to an item (like kg, pcs, or mL), Puffio remembers it for next time.\n\nQuantity controls automatically match the unit:\n• pcs: 1, 2, 3…\n• g / mL: steps of 100\n• kg / L: steps of 0.5';

  @override
  String get helpCategoriesTitle => 'Categories';

  @override
  String get helpCategoriesBody =>
      'Puffio automatically organizes many everyday products into categories like Dairy, Bakery, or Fruit & Vegetables, making your shopping list easier to follow in the store.\n\nIf you move an item to a different category, Puffio remembers your choice for future lists.\n\nAnything it doesn\'t recognize simply goes into Other.';

  @override
  String get helpListsTitle => 'Multiple lists';

  @override
  String get helpListsBody =>
      'Create as many shopping lists as you need.\n\nOn the Home screen, swipe the large list card left or right — or tap its left or right edge — to switch between lists.\n\nTap the center of the card to open the current list.\n\nYou can also tap the list icon in the top bar to see all your lists.';

  @override
  String get helpQuickListTitle => 'Quick list creation';

  @override
  String get helpQuickListBody =>
      'List names are optional.\n\nLeave the name empty and tap Create, and Puffio will automatically generate a unique name such as "My List (2)".';

  @override
  String get helpBackupTitle => 'Backup and restore';

  @override
  String get helpBackupBody =>
      'Export backup saves all your lists, items, and Puffio\'s learned shopping history into a single backup file that you store wherever you choose.\n\nImport backup restores everything from that file, replacing your current data.\n\nYour information never leaves your device unless you choose to export it.';

  @override
  String get helpDatesTitle => 'Dates and reminders';

  @override
  String get helpDatesBody =>
      'Need to buy something on a specific day?\n\nEdit the item and choose a date — and a time if needed. The date appears below the item in your shopping list.\n\nEnable Remind me to receive a notification, then choose when you\'d like to be reminded — from exactly on time to up to one week in advance.\n\nIf no time is set, Puffio reminds you in the morning.\n\nReminders can repeat too — daily, weekly, monthly, or yearly.\n\nYou can change or remove the date and reminder anytime by editing the item again.';

  @override
  String get helpCalendarTitle => 'Calendar overview';

  @override
  String get helpCalendarBody =>
      'Tap the {calendar} calendar icon on the Home screen to see every scheduled item in one place.\n\nDays containing shopping items are marked with a dot.\n\nTap a day to see its items, then tap any item to edit it or jump directly to the shopping list it belongs to.';

  @override
  String get helpPriceLocationTitle => 'Price and location';

  @override
  String get helpPriceLocationBody =>
      'While editing an item, you can save a price and a location — such as a store name or aisle.\n\nBoth appear beneath the item name to keep your list clean and easy to read.\n\nPuffio remembers the last price and location you entered, so the next time you add the same item they\'re filled in automatically. It\'s a simple way to remember where you found the best deal.\n\nRemoving them from an item doesn\'t erase the remembered values. Entering new ones updates them for future use.';

  @override
  String get helpPrivacyTitle => 'Privacy & Offline';

  @override
  String get helpOfflineNote =>
      'Puffio works completely offline.\n\nYour shopping lists, smart suggestions, and category matching all stay on your device. No account, no cloud, no AI servers, and no internet connection are required.';

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

  @override
  String notificationReminderBody(String listName) =>
      'On your "$listName" list';
}
