/// Local, offline keyword → category mapping used ONLY as a first-time
/// default when an item has no remembered category. The user's own
/// assignment (stored in ItemHistory) always takes precedence and is
/// never overwritten by this dictionary.
///
/// Keys are lowercase item words in English and Croatian; values are the
/// canonical seeded category names from [kDefaultCategories].
library;

const Map<String, String> kCategoryKeywords = {
  // ---- Dairy ----
  'milk': 'Dairy', 'mlijeko': 'Dairy',
  // Common Croatian ije/je spelling variants (matching only — the user's
  // typed text is never altered):
  'mljeko': 'Dairy', 'mliko': 'Dairy',
  'cheese': 'Dairy', 'sir': 'Dairy',
  'yogurt': 'Dairy', 'yoghurt': 'Dairy', 'jogurt': 'Dairy',
  'butter': 'Dairy', 'maslac': 'Dairy',
  'cream': 'Dairy', 'vrhnje': 'Dairy',
  'eggs': 'Dairy', 'egg': 'Dairy', 'jaja': 'Dairy', 'jaje': 'Dairy',
  'kefir': 'Dairy', 'mozzarella': 'Dairy', 'feta': 'Dairy',
  // ---- Bakery ----
  'bread': 'Bakery', 'kruh': 'Bakery',
  'rolls': 'Bakery', 'roll': 'Bakery', 'pecivo': 'Bakery', 'peciva': 'Bakery',
  'baguette': 'Bakery', 'baget': 'Bakery',
  'croissant': 'Bakery', 'kroasan': 'Bakery',
  'toast': 'Bakery', 'tost': 'Bakery',
  'bagel': 'Bakery', 'tortilla': 'Bakery', 'burek': 'Bakery',
  // ---- Meat & Fish ----
  'chicken': 'Meat & Fish', 'piletina': 'Meat & Fish',
  'beef': 'Meat & Fish', 'govedina': 'Meat & Fish',
  'pork': 'Meat & Fish', 'svinjetina': 'Meat & Fish',
  'ham': 'Meat & Fish', 'šunka': 'Meat & Fish', 'sunka': 'Meat & Fish',
  'bacon': 'Meat & Fish', 'slanina': 'Meat & Fish',
  'sausage': 'Meat & Fish', 'kobasica': 'Meat & Fish', 'kobasice': 'Meat & Fish',
  'salami': 'Meat & Fish', 'salama': 'Meat & Fish',
  'fish': 'Meat & Fish', 'riba': 'Meat & Fish',
  'tuna': 'Meat & Fish', 'tunjevina': 'Meat & Fish',
  'salmon': 'Meat & Fish', 'losos': 'Meat & Fish',
  'turkey': 'Meat & Fish', 'puretina': 'Meat & Fish',
  'mince': 'Meat & Fish', 'meat': 'Meat & Fish', 'meso': 'Meat & Fish',
  // ---- Vegetables ----
  'potato': 'Vegetables', 'potatoes': 'Vegetables', 'krumpir': 'Vegetables',
  'onion': 'Vegetables', 'onions': 'Vegetables', 'luk': 'Vegetables',
  'garlic': 'Vegetables', 'češnjak': 'Vegetables', 'cesnjak': 'Vegetables',
  'tomato': 'Vegetables', 'tomatoes': 'Vegetables', 'rajčica': 'Vegetables',
  'rajčice': 'Vegetables', 'rajcica': 'Vegetables', 'rajcice': 'Vegetables',
  'cucumber': 'Vegetables', 'krastavac': 'Vegetables', 'krastavci': 'Vegetables',
  'carrot': 'Vegetables', 'carrots': 'Vegetables', 'mrkva': 'Vegetables',
  'pepper': 'Vegetables', 'peppers': 'Vegetables', 'paprika': 'Vegetables',
  'lettuce': 'Vegetables', 'salata': 'Vegetables',
  'spinach': 'Vegetables', 'špinat': 'Vegetables', 'spinat': 'Vegetables',
  'cabbage': 'Vegetables', 'kupus': 'Vegetables',
  'broccoli': 'Vegetables', 'brokula': 'Vegetables',
  'zucchini': 'Vegetables', 'tikvica': 'Vegetables', 'tikvice': 'Vegetables',
  'mushrooms': 'Vegetables', 'mushroom': 'Vegetables', 'gljive': 'Vegetables',
  // ---- Fruits ----
  'banana': 'Fruits', 'bananas': 'Fruits', 'banane': 'Fruits',
  'apple': 'Fruits', 'apples': 'Fruits', 'jabuka': 'Fruits', 'jabuke': 'Fruits',
  'orange': 'Fruits', 'oranges': 'Fruits', 'naranča': 'Fruits',
  'naranče': 'Fruits', 'naranca': 'Fruits', 'narance': 'Fruits',
  'lemon': 'Fruits', 'limun': 'Fruits',
  'grapes': 'Fruits', 'grožđe': 'Fruits', 'grozdje': 'Fruits',
  'strawberries': 'Fruits', 'jagode': 'Fruits',
  'blueberries': 'Fruits', 'borovnice': 'Fruits',
  'peach': 'Fruits', 'breskva': 'Fruits', 'breskve': 'Fruits',
  'pear': 'Fruits', 'kruška': 'Fruits', 'kruške': 'Fruits', 'kruska': 'Fruits',
  'watermelon': 'Fruits', 'lubenica': 'Fruits',
  'avocado': 'Fruits', 'avokado': 'Fruits',
  // ---- Pantry ----
  'rice': 'Pantry', 'riža': 'Pantry', 'riza': 'Pantry',
  'pasta': 'Pantry', 'tjestenina': 'Pantry',
  'flour': 'Pantry', 'brašno': 'Pantry', 'brasno': 'Pantry',
  'sugar': 'Pantry', 'šećer': 'Pantry', 'secer': 'Pantry',
  'salt': 'Pantry', 'sol': 'Pantry',
  'oil': 'Pantry', 'ulje': 'Pantry',
  'vinegar': 'Pantry', 'ocat': 'Pantry',
  'cereal': 'Pantry', 'žitarice': 'Pantry', 'zitarice': 'Pantry',
  'oats': 'Pantry', 'zobene': 'Pantry',
  'honey': 'Pantry', 'med': 'Pantry',
  'beans': 'Pantry', 'grah': 'Pantry',
  'lentils': 'Pantry', 'leća': 'Pantry',
  'ketchup': 'Pantry', 'kečap': 'Pantry', 'kecap': 'Pantry',
  'mayonnaise': 'Pantry', 'majoneza': 'Pantry',
  'spaghetti': 'Pantry', 'špageti': 'Pantry', 'spageti': 'Pantry',
  // ---- Beverages ----
  'water': 'Beverages', 'voda': 'Beverages',
  'juice': 'Beverages', 'sok': 'Beverages',
  'coffee': 'Beverages', 'kava': 'Beverages',
  'tea': 'Beverages', 'čaj': 'Beverages', 'caj': 'Beverages',
  'beer': 'Beverages', 'pivo': 'Beverages',
  'wine': 'Beverages', 'vino': 'Beverages',
  'cola': 'Beverages', 'soda': 'Beverages', 'lemonade': 'Beverages',
  // ---- Frozen ----
  'frozen': 'Frozen', 'smrznuto': 'Frozen', 'smrznuta': 'Frozen',
  'icecream': 'Frozen', 'sladoled': 'Frozen',
  'pizza': 'Frozen',
  // ---- Snacks ----
  'chips': 'Snacks', 'čips': 'Snacks', 'cips': 'Snacks',
  'chocolate': 'Snacks', 'čokolada': 'Snacks', 'cokolada': 'Snacks',
  'cookies': 'Snacks', 'keksi': 'Snacks',
  'crackers': 'Snacks', 'krekeri': 'Snacks',
  'candy': 'Snacks', 'bomboni': 'Snacks',
  'nuts': 'Snacks', 'orašasti': 'Snacks',
  'popcorn': 'Snacks', 'kokice': 'Snacks',
  // ---- Household ----
  'detergent': 'Household', 'deterdžent': 'Household', 'deterdzent': 'Household',
  'soap': 'Household', 'sapun': 'Household',
  'shampoo': 'Household', 'šampon': 'Household', 'sampon': 'Household',
  'toothpaste': 'Household', 'pasta za zube': 'Household',
  'sponge': 'Household', 'spužva': 'Household', 'spuzva': 'Household',
  'napkins': 'Household', 'salvete': 'Household',
  'batteries': 'Household', 'baterije': 'Household',
  'toilet': 'Household', 'wc': 'Household',
  'papir': 'Household',
};

/// Folds Croatian diacritics for matching only (č/ć→c, š→s, ž→z, đ→d).
String _foldDiacritics(String s) => s
    .replaceAll('č', 'c')
    .replaceAll('ć', 'c')
    .replaceAll('š', 's')
    .replaceAll('ž', 'z')
    .replaceAll('đ', 'd');

/// Returns the canonical category name for [normalizedName], or null.
/// Tries the full name first, then individual words — so "oat milk"
/// still maps to Dairy. Diacritics are folded before lookup so
/// "spužva" and "spuzva" behave identically. Deterministic lookup
/// against explicit keys only; no fuzzy matching.
String? categoryNameForItem(String normalizedName) {
  String? lookup(String key) =>
      kCategoryKeywords[key] ?? kCategoryKeywords[_foldDiacritics(key)];

  final full = lookup(normalizedName);
  if (full != null) return full;
  for (final word in normalizedName.split(RegExp(r'\s+'))) {
    final hit = lookup(word);
    if (hit != null) return hit;
  }
  return null;
}
