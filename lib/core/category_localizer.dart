import 'package:shop_list_pro/l10n/app_localizations.dart';

/// Translates default (seeded) category names to the current locale.
/// User-created categories are returned unchanged.
///
/// The database always stores the English default name (e.g. "Dairy").
/// This helper maps that stable key to the localized display name at render time.
class CategoryLocalizer {
  CategoryLocalizer._();

  static String translate(String categoryName, AppLocalizations t) {
    switch (categoryName) {
      case 'Dairy':
        return t.catDairy;
      case 'Bakery':
        return t.catBakery;
      case 'Meat & Fish':
        return t.catMeatFish;
      case 'Vegetables':
        return t.catVegetables;
      case 'Fruits':
        return t.catFruits;
      case 'Pantry':
        return t.catPantry;
      case 'Beverages':
        return t.catBeverages;
      case 'Frozen':
        return t.catFrozen;
      case 'Snacks':
        return t.catSnacks;
      case 'Household':
        return t.catHousehold;
      case 'Other':
        return t.catOther;
      default:
        return categoryName; // custom user-created categories
    }
  }
}
