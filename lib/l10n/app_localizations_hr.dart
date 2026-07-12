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
  String get homeSectionFrequent => 'Prijedlozi za vas';
  @override
  String get homeSectionFavorites => 'Prikvačeno';
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
  String get listSwipeDeleteHint =>
      'Savjet: povucite stavku ulijevo za brisanje';

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
  String get listsNewListHint => 'Naziv liste (neobavezno)';
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
  String get editItemSave => 'Spremi artikl';
  @override
  String get editItemPrice => 'Cijena (neobavezno)';
  @override
  String get editItemLocation => 'Lokacija (neobavezno)';
  @override
  String get editItemLocationHint => 'npr. Lidl, polica 4, ljekarna';
  @override
  String get editItemSectionSchedule => 'Datum i podsjetnik';
  @override
  String get editItemAddDate => 'Dodaj datum';
  @override
  String get editItemAddTime => 'Dodaj vrijeme';
  @override
  String get editItemRemoveDate => 'Ukloni datum';
  @override
  String get editItemRemoveTime => 'Ukloni vrijeme';
  @override
  String get editItemReminderToggle => 'Podsjeti me';
  @override
  String get editItemReminderWhen => 'Vrijeme podsjetnika';
  @override
  String get editItemRepeat => 'Ponavljanje';

  @override
  String get repeatNever => 'Nikad';
  @override
  String get repeatDaily => 'Svaki dan';
  @override
  String get repeatWeekly => 'Svaki tjedan';
  @override
  String get repeatMonthly => 'Svaki mjesec';
  @override
  String get repeatYearly => 'Svake godine';

  @override
  String get reminderAtTime => 'U odabrano vrijeme';
  @override
  String get reminder30MinBefore => '30 minuta prije';
  @override
  String get reminder1HourBefore => '1 sat prije';
  @override
  String get reminder3HoursBefore => '3 sata prije';
  @override
  String get reminder1DayBefore => '1 dan prije';
  @override
  String get reminder2DaysBefore => '2 dana prije';
  @override
  String get reminder1WeekBefore => '1 tjedan prije';
  @override
  String get reminderPermissionDenied =>
      'Obavijesti su isključene za Puffio. Dopustite ih u postavkama sustava kako biste primali podsjetnike.';

  @override
  String get notificationChannelName => 'Podsjetnici za artikle';
  @override
  String get notificationChannelDescription =>
      'Podsjetnici za artikle s datumom';
  @override
  String get notificationReminderBodyNoList => 'Podsjetnik za kupovinu';
  @override
  String get notificationItemGone =>
      'Taj artikl više nije na vašim listama.';

  @override
  String get calendarTitle => 'Kalendar';
  @override
  String get calendarEmptyTitle => 'Nema zakazanih artikala';
  @override
  String get calendarEmptyHint =>
      'Dodajte datum artiklu — uredite artikl i odaberite datum. Pojavit će se ovdje.';
  @override
  String get calendarNoItemsForDay => 'Za ovaj dan nema ništa zakazano.';
  @override
  String get calendarOpenListTooltip => 'Otvori listu';

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
  String get itemPinnedSnackBar => 'Dodano u prikvačene artikle';

  @override
  String get itemUnpinnedSnackBar => 'Uklonjeno iz prikvačenih artikala';

  @override
  String get commonImport => 'Uvezi';

  @override
  String get commonRemove => 'Ukloni';

  @override
  String get listMenuClearCompleted => 'Ukloni kupljeno';

  @override
  String get listMenuClearAll => 'Obriši cijelu listu';

  @override
  String get listClearAllDialogTitle => 'Obrisati cijelu listu?';

  @override
  String get listClearAllDialogMessage =>
      'Ovo će ukloniti sve stavke s liste. Ovu radnju nije moguće poništiti.';

  @override
  String get listClearAllConfirm => 'Obriši listu';

  @override
  String get listClearCompletedDialogTitle => 'Ukloniti kupljene stavke?';

  @override
  String get listClearCompletedDialogMessage =>
      'Ovo će ukloniti sve kupljene stavke s liste. Ovu radnju nije moguće poništiti.';

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
  String get historyUnpin => 'Ukloni iz prikvačenih';

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
  String get settingsHelp => 'Pomoć i savjeti';

  @override
  String get settingsWhatsNew => 'Što je novo';

  @override
  String get settingsWhatsNewSubtitle =>
      'Pogledajte što je novo u ovoj verziji';

  @override
  String get whatsNewBody =>
      '• Datumi i podsjetnici — odaberite datum i vrijeme, primite obavijest, a podsjetnik se može ponavljati dnevno, tjedno, mjesečno ili godišnje.\n\n'
      '• Pregled kalendara — dodirnite ikonu kalendara na početnom zaslonu i vidite sve zakazane artikle na jednom mjestu.\n\n'
      '• Cijena i lokacija — zabilježite gdje je artikl bio najjeftiniji; Puffio ih pamti za sljedeće dodavanje.\n\n'
      '• Dodirom obavijesti podsjetnika otvara se lista s označenim artiklom.\n\n'
      '• Bolja podrška za povećani tekst sustava u cijeloj aplikaciji.\n\n'
      '• Widget početnog zaslona je uklonjen.';

  @override
  String get helpIntro =>
      'Puffio postaje pametniji što ga više koristite. Evo kako rade njegove glavne značajke.';

  @override
  String get helpSuggestionsTitle => 'Pametni prijedlozi';

  @override
  String get helpSuggestionsBody =>
      'Puffio uči iz artikala koje dodajete i označavate kao kupljene. S vremenom na početnom zaslonu predlaže proizvode koji će vam vjerojatno ponovno trebati. Dovoljno je dodirnuti prijedlog kako biste ga odmah dodali na listu.\n\nArtikli koji su već na trenutnoj listi neće se ponovno predlagati, a prijedlozi se prilagođavaju vašim navikama kupnje.';

  @override
  String get helpPinnedTitle => 'Prikvačeni artikli';

  @override
  String get helpPinnedBody =>
      'Dodirnite zvjezdicu na artiklu da ga prikvačite. Prikvačeni artikli pojavljuju se na vrhu početnog zaslona kad god nisu već na vašoj listi — korisno za stvari koje želite zapamtiti čak i ako ih rijetko kupujete. Ponovnim dodirom zvjezdice uklanjate prikvačenost.';

  @override
  String get helpSwipeTitle => 'Povuci za brisanje';

  @override
  String get helpSwipeBody =>
      'Povucite artikl na listi ulijevo da ga izbrišete. Nakratko se pojavi gumb za poništavanje u slučaju pogreške.';

  @override
  String get helpUnitsTitle => 'Mjerne jedinice i količine';

  @override
  String get helpUnitsBody =>
      'Jedinice su neobavezne i uvijek ih birate sami — Puffio ih nikad ne pogađa. Kad artiklu dodijelite jedinicu (npr. kg ili mL), Puffio je pamti za sljedeći put. Koraci količine prilagođavaju se jedinici: komadi idu 1, 2, 3…, grami i mililitri po 100, a kilogrami i litre po 0,5.';

  @override
  String get helpCategoriesTitle => 'Kategorije';

  @override
  String get helpCategoriesBody =>
      'Puffio automatski razvrstava mnoge uobičajene artikle u kategorije poput Mliječni proizvodi ili Pekara, pa je lista grupirana za lakšu kupovinu. Ako promijenite kategoriju artikla, Puffio pamti vaš izbor. Ono što ne prepozna jednostavno završi u Ostalo.';

  @override
  String get helpListsTitle => 'Više lista';

  @override
  String get helpListsBody =>
      'Možete imati više lista za kupovinu. Na početnom zaslonu povucite veliku karticu liste ulijevo ili udesno — ili dodirnite njezin lijevi ili desni rub — za prebacivanje između lista. Dodirnite sredinu kartice da otvorite listu. Ikona liste u gornjoj traci prikazuje sve vaše liste.';

  @override
  String get helpQuickListTitle => 'Brzo stvaranje liste';

  @override
  String get helpQuickListBody =>
      'Naziv liste je neobavezan. Ostavite ga praznim i dodirnite Stvori — Puffio sam odabire jedinstveni naziv, npr. „Moja lista (2)".';

  @override
  String get helpBackupTitle => 'Sigurnosna kopija i vraćanje';

  @override
  String get helpBackupBody =>
      'Izvoz sigurnosne kopije sprema sve vaše liste, artikle i naučenu povijest kupovine u jednu datoteku, na mjesto koje sami odaberete. Uvoz je vraća i zamjenjuje trenutne podatke. Ništa se nigdje ne prenosi.';

  @override
  String get helpDatesTitle => 'Datumi i podsjetnici';

  @override
  String get helpDatesBody =>
      'Trebate nešto kupiti do određenog dana?\n\nUredite artikl i odaberite datum, a po želji i vrijeme. Datum će se prikazivati ispod artikla na listi.\n\nUključite „Podsjeti me” kako biste primili obavijest te odaberite koliko unaprijed želite podsjetnik — od točno u odabrano vrijeme pa sve do tjedan dana ranije.\n\nAko vrijeme nije postavljeno, Puffio će vas podsjetiti ujutro.\n\nPodsjetnici se mogu i ponavljati — dnevno, tjedno, mjesečno ili godišnje.\n\nDatum i podsjetnik možete promijeniti ili ukloniti u bilo kojem trenutku ponovnim uređivanjem artikla.';

  @override
  String get helpCalendarTitle => 'Pregled kalendara';

  @override
  String get helpCalendarBody =>
      'Dodirnite ikonu {calendar} kalendara na početnom zaslonu kako biste na jednom mjestu vidjeli sve artikle s datumima.\n\nDani koji sadrže artikle označeni su točkom.\n\nDodirnite željeni dan kako biste vidjeli planirane artikle, a zatim dodirnite artikl da ga uredite ili otvorite listu kojoj pripada.';

  @override
  String get helpPriceLocationTitle => 'Cijena i lokacija';

  @override
  String get helpPriceLocationBody =>
      'Prilikom uređivanja artikla možete spremiti cijenu i lokaciju, primjerice naziv trgovine ili police.\n\nOboje se prikazuje ispod naziva artikla kako bi lista ostala pregledna.\n\nPuffio pamti posljednju unesenu cijenu i lokaciju pa će ih automatski ponuditi kada ponovno dodate isti artikl. To je praktičan način da zapamtite gdje ste ga zadnji put kupili ili pronašli najbolju cijenu.\n\nBrisanjem tih podataka s jednog artikla zapamćene vrijednosti ostaju sačuvane. Unos novih podataka ažurira ih za buduće korištenje.';

  @override
  String get helpPrivacyTitle => 'Privatnost i rad bez interneta';

  @override
  String get helpOfflineNote =>
      'Puffio radi potpuno bez interneta.\n\nVaše liste za kupovinu, pametni prijedlozi i prepoznavanje kategorija ostaju na vašem uređaju. Nisu potrebni račun, oblak, AI poslužitelji ni internetska veza.';

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

  @override
  String notificationReminderBody(String listName) =>
      'Na vašoj listi „$listName"';
}
