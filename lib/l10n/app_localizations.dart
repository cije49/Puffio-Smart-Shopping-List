// Manually-written equivalent of `flutter gen-l10n` output.
// Edit the `.arb` files and regenerate with `flutter gen-l10n` if you prefer —
// but these hand-written files work identically and avoid Windows/OneDrive
// path issues with Flutter's code generator.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations_en.dart';
import 'app_localizations_hr.dart';

abstract class AppLocalizations {
  AppLocalizations(this.localeName);

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hr'),
  ];

  // ---------------------------------------------------------------------------
  // Simple string getters
  // ---------------------------------------------------------------------------
  String get appTitle;

  String get homeMenuLists;
  String get homeMenuSettings;
  String get homeDefaultListName;
  String get homeInputHint;
  String get homeAddButton;
  String get homeSectionPattern;
  String get homeSectionFrequent;
  String get homeSectionFavorites;
  String get homeEmptyHint;
  String get homeOpenListFab;
  String get homeListEmptyCard;
  String get homeListCardHint;

  String get listTitleDefault;
  String get listTitleAllDone;
  String get listMenuRename;
  String get listMenuDuplicate;
  String get listMenuDelete;
  String get listEmpty;
  String get listEmptyHint;
  String get listGoBack;
  String get listCheckedSection;
  String get listRenameDialogTitle;
  String get listRenameHint;
  String get listDeleteDialogTitle;
  String get listDeleteMessage;
  String get listDuplicatedSnackBar;
  String get listDeletedSnackBar;
  String get listQuickAddHint;
  String get listSwipeDeleteHint;

  String get listsTitle;
  String get listsNone;
  String get listsActive;
  String get listsSetActive;
  String get listsMenuActivate;
  String get listsFabNewList;
  String get listsNewListDialogTitle;
  String get listsNewListHint;
  String get listsCreateButton;
  String get listsDeleteMessage;

  String get settingsTitle;
  String get settingsTheme;
  String get settingsThemeSystem;
  String get settingsThemeLight;
  String get settingsThemeDark;
  String get settingsLanguage;
  String get settingsLanguageSystem;
  String get settingsLanguageEnglish;
  String get settingsLanguageCroatian;
  String get settingsClearData;
  String get settingsClearDataSubtitle;
  String get settingsClearDialogTitle;
  String get settingsClearDialogMessage;
  String get settingsClearedSnackBar;

  String get settingsWidget;
  String get settingsWidgetSubtitle;

  String get editItemTitle;
  String get editItemName;
  String get editItemQuantity;
  String get editItemUnit;
  String get editItemUnitNone;
  String get editItemCategory;
  String get editItemSave;

  String get commonCancel;
  String get commonDelete;
  String get commonRename;
  String get commonSave;
  String get commonClearAll;
  String get commonUndo;
  String get commonImport;
  String get commonRemove;
  String get itemDeletedSnackBar;
  String get itemPinnedSnackBar;
  String get itemUnpinnedSnackBar;
  String get listMenuClearCompleted;
  String get settingsBackupExport;
  String get settingsBackupExportSubtitle;
  String get settingsBackupImport;
  String get settingsBackupImportSubtitle;
  String get settingsImportDialogTitle;
  String get settingsImportDialogMessage;
  String get settingsExportedSnackBar;
  String get settingsImportedSnackBar;
  String get settingsImportFailedSnackBar;

  String get historyUnpin;
  String get historyRemove;
  String get historyRemoveDialogTitle;
  String get historyRemoveDialogMessage;
  String get historyRenameDialogTitle;

  String get settingsHelp;
  String get helpIntro;
  String get helpSuggestionsTitle;
  String get helpSuggestionsBody;
  String get helpPinnedTitle;
  String get helpPinnedBody;
  String get helpSwipeTitle;
  String get helpSwipeBody;
  String get helpUnitsTitle;
  String get helpUnitsBody;
  String get helpCategoriesTitle;
  String get helpCategoriesBody;
  String get helpListsTitle;
  String get helpListsBody;
  String get helpQuickListTitle;
  String get helpQuickListBody;
  String get helpBackupTitle;
  String get helpBackupBody;
  String get helpOfflineNote;

  String get widgetAllDone;
  String get widgetEmptyHint;
  String get widgetMoreTemplate;

  String get catDairy;
  String get catBakery;
  String get catMeatFish;
  String get catVegetables;
  String get catFruits;
  String get catPantry;
  String get catBeverages;
  String get catFrozen;
  String get catSnacks;
  String get catHousehold;
  String get catOther;

  // ---------------------------------------------------------------------------
  // Parameterised messages
  // ---------------------------------------------------------------------------
  String homeItemsCheckedSummary(int checked, int total);
  String widgetLeftCount(int count);
  String listsDuplicatedSnackBar(String name);
  String listsDeleteDialogTitle(String name);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(_lookup(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations _lookup(Locale locale) {
  switch (locale.languageCode) {
    case 'hr':
      return AppLocalizationsHr();
    case 'en':
    default:
      return AppLocalizationsEn();
  }
}
