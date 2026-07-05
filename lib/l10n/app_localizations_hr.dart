import 'app_localizations.dart';

class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr() : super('hr');

  @override
  String get appTitle => 'Puffio';

  @override
  String get homeMenuLists => 'Upravljanje listama';
  @override
  String get homeMenuSettings => 'Postavke';
  @override
  String get homeDefaultListName => 'Moja lista';
  @override
  String get homeInputHint =>
      'Dodaj artikle — odvoji zarezom ili novim redom';
  @override
  String get homeAddButton => 'Dodaj';
  @override
  String get homeSectionPattern => 'Možda vam trebaju';
  @override
  String get homeSectionFrequent => 'Često kupovano';
  @override
  String get homeSectionRecent => 'Brzo dodavanje (nedavno)';
  @override
  String get homeSectionFavorites => 'Favoriti';
  @override
  String get homeEmptyHint =>
      'Počnite dodavati artikle kako bi se ovdje pojavili prijedlozi.';
  @override
  String get homeOpenListFab => 'Otvori listu';
  @override
  String get homeListEmptyCard => 'Vaša lista je prazna';
  @override
  String get homeListCardHint =>
      'Dodirnite prijedlog ili tipkajte za početak';

  @override
  String get listTitleDefault => 'Lista za kupovinu';
  @override
  String get listTitleAllDone => 'Sve gotovo!';
  @override
  String get listMenuRename => 'Preimenuj';
  @override
  String get listMenuDuplicate => 'Dupliciraj';
  @override
  String get listMenuDelete => 'Obriši';
  @override
  String get listEmpty => 'Vaša lista je prazna';
  @override
  String get listEmptyHint =>
      'Vratite se na početni zaslon za dodavanje artikala.';
  @override
  String get listGoBack => 'Natrag';
  @override
  String get listCheckedSection => 'Označeno';
  @override
  String get listRenameDialogTitle => 'Preimenuj listu';
  @override
  String get listRenameHint => 'Novi naziv';
  @override
  String get listDeleteDialogTitle => 'Obrisati ovu listu?';
  @override
  String get listDeleteMessage =>
      'Artikli će biti uklonjeni, ali povijest ostaje.';
  @override
  String get listDuplicatedSnackBar => 'Lista duplicirana';
  @override
  String get listDeletedSnackBar => 'Lista obrisana';
  @override
  String get listQuickAddHint =>
      'Dodaj artikle — odvojene zarezom ili novim redom';

  @override
  String get listsTitle => 'Moje liste';
  @override
  String get listsNone => 'Još nema lista.';
  @override
  String get listsActive => 'Aktivna lista';
  @override
  String get listsSetActive => 'Dodirnite za aktivaciju';
  @override
  String get listsMenuActivate => 'Postavi kao aktivnu';
  @override
  String get listsFabNewList => 'Nova lista';
  @override
  String get listsNewListDialogTitle => 'Nova lista';
  @override
  String get listsNewListHint => 'Naziv liste';
  @override
  String get listsCreateButton => 'Kreiraj';
  @override
  String get listsDeleteMessage =>
      'Artikli će biti uklonjeni; povijest se čuva.';

  @override
  String get settingsTitle => 'Postavke';
  @override
  String get settingsTheme => 'Tema';
  @override
  String get settingsThemeSystem => 'Sustav';
  @override
  String get settingsThemeLight => 'Svijetla';
  @override
  String get settingsThemeDark => 'Tamna';
  @override
  String get settingsLanguage => 'Jezik';
  @override
  String get settingsLanguageSystem => 'Sistemski';
  @override
  String get settingsLanguageEnglish => 'English';
  @override
  String get settingsLanguageCroatian => 'Hrvatski';
  @override
  String get settingsClearData => 'Obriši sve podatke';
  @override
  String get settingsClearDataSubtitle =>
      'Ukloni sve liste, artikle, povijest i postavke';
  @override
  String get settingsClearDialogTitle => 'Obrisati sve podatke?';
  @override
  String get settingsClearDialogMessage =>
      'Ovo će ukloniti svaku listu, artikl i povijest te resetirati postavke. Ova radnja se ne može poništiti.';
  @override
  String get settingsClearedSnackBar => 'Svi podaci obrisani.';

  @override
  String get settingsWidget => 'Widget početnog zaslona';
  @override
  String get settingsWidgetSubtitle =>
      'Prikaži listu kupovine na početnom zaslonu';

  @override
  String get editItemTitle => 'Uredi artikl';
  @override
  String get editItemName => 'Naziv artikla';
  @override
  String get editItemQuantity => 'Količina';
  @override
  String get editItemUnit => 'Jedinica (neobavezno)';
  @override
  String get editItemUnitNone => 'Nijedna';
  @override
  String get editItemCategory => 'Kategorija';
  @override
  String get editItemSave => 'Spremi';

  @override
  String get commonCancel => 'Odustani';
  @override
  String get commonDelete => 'Obriši';
  @override
  String get commonRename => 'Preimenuj';
  @override
  String get commonSave => 'Spremi';
  @override
  String get commonClearAll => 'Obriši sve';
  @override
  String get commonUndo => 'Vrati';

  @override
  String get itemDeletedSnackBar => 'Stavka obrisana';

  @override
  String get commonImport => 'Uvezi';

  @override
  String get commonRemove => 'Ukloni';

  @override
  String get listMenuClearCompleted => 'Ukloni kupljeno';

  @override
  String get settingsBackupExport => 'Izvezi sigurnosnu kopiju';

  @override
  String get settingsBackupExportSubtitle =>
      'Spremi sve liste i povijest u datoteku';

  @override
  String get settingsBackupImport => 'Uvezi sigurnosnu kopiju';

  @override
  String get settingsBackupImportSubtitle =>
      'Vrati liste i povijest iz datoteke sigurnosne kopije';

  @override
  String get settingsImportDialogTitle => 'Uvesti sigurnosnu kopiju?';

  @override
  String get settingsImportDialogMessage =>
      'Ovo zamjenjuje sve trenutne liste, stavke i povijest sadržajem sigurnosne kopije.';

  @override
  String get settingsExportedSnackBar => 'Sigurnosna kopija spremljena';

  @override
  String get settingsImportedSnackBar => 'Sigurnosna kopija uvezena';

  @override
  String get settingsImportFailedSnackBar =>
      'Uvoz nije uspio: datoteka nije valjana sigurnosna kopija';

  @override
  String get historyRemove => 'Ukloni iz prijedloga';

  @override
  String get historyRemoveDialogTitle => 'Ukloniti iz prijedloga?';

  @override
  String get historyRemoveDialogMessage =>
      'Ovo trajno briše povijest korištenja ove stavke. Stavke koje su već na listama ostaju netaknute.';

  @override
  String get historyRenameDialogTitle => 'Preimenuj prijedlog';

  @override
  String get widgetAllDone => 'Sve kupljeno!';

  @override
  String get widgetEmptyHint => 'Vaša lista za kupnju je prazna.';

  @override
  String get widgetMoreTemplate => '+ još %d';

  @override
  String widgetLeftCount(int count) => 'Još $count';

  @override
  String get catDairy => 'Mliječni proizvodi';
  @override
  String get catBakery => 'Pekara';
  @override
  String get catMeatFish => 'Meso i riba';
  @override
  String get catVegetables => 'Povrće';
  @override
  String get catFruits => 'Voće';
  @override
  String get catPantry => 'Špajza';
  @override
  String get catBeverages => 'Pića';
  @override
  String get catFrozen => 'Zamrznuto';
  @override
  String get catSnacks => 'Grickalice';
  @override
  String get catHousehold => 'Kućanstvo';
  @override
  String get catOther => 'Ostalo';

  // ---------------------------------------------------------------------------
  // Parameterised messages
  // ---------------------------------------------------------------------------
  @override
  String homeItemsCheckedSummary(int checked, int total) {
    // Croatian plural: 1 → "artikla", 2-4 → "artikla", 5+ → "artikala"
    String itemWord;
    if (total == 1) {
      itemWord = '1 artikla';
    } else if (total >= 2 && total <= 4) {
      itemWord = '$total artikla';
    } else {
      itemWord = '$total artikala';
    }
    return '$checked od $itemWord označeno';
  }

  @override
  String listsDuplicatedSnackBar(String name) => '"$name" duplicirano';

  @override
  String listsDeleteDialogTitle(String name) => 'Obrisati "$name"?';
}
