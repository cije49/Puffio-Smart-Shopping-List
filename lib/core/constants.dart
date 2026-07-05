// App-wide constants.

const String kDefaultListName = 'My List';

/// Number of suggestion chips to show per section.
const int kSuggestionLimit = 12;

/// Minimum number of completed purchases before pattern suggestions activate.
const int kPatternMinChecks = 3;

/// Days of leeway around the average interval for pattern suggestions.
const int kPatternWindowDays = 3;

/// Supported unit values for quantity.
const List<String> kUnits = ['pcs', 'kg', 'g', 'L', 'mL', 'oz', 'lb'];

/// Default categories seeded on first launch.
const List<Map<String, dynamic>> kDefaultCategories = [
  {'name': 'Dairy', 'sortOrder': 0},
  {'name': 'Bakery', 'sortOrder': 1},
  {'name': 'Meat & Fish', 'sortOrder': 2},
  {'name': 'Vegetables', 'sortOrder': 3},
  {'name': 'Fruits', 'sortOrder': 4},
  {'name': 'Pantry', 'sortOrder': 5},
  {'name': 'Beverages', 'sortOrder': 6},
  {'name': 'Frozen', 'sortOrder': 7},
  {'name': 'Snacks', 'sortOrder': 8},
  {'name': 'Household', 'sortOrder': 9},
  {'name': 'Other', 'sortOrder': 99},
];
