// App-wide constants.

const String kDefaultListName = 'My List';

/// Number of suggestion chips to show per section. Sized so that recently
/// used items surface in "Suggested for you" via the recency component of
/// the score (there is no separate Recent section).
const int kSuggestionLimit = 16;

/// Minimum number of completed purchases before pattern suggestions activate.
const int kPatternMinChecks = 3;

/// Days of leeway around the average interval for pattern suggestions.
const int kPatternWindowDays = 3;

/// Reminder offset choices, in minutes before the item's due date/time.
/// 0 = at the selected time.
const List<int> kReminderOffsetsMinutes = [
  0, // at the selected time
  30, // 30 minutes before
  60, // 1 hour before
  180, // 3 hours before
  1440, // 1 day before
  2880, // 2 days before
  10080, // 1 week before
];

/// Hour of day (local) used as the reminder anchor for items that have a
/// due date but no specific time.
const int kDefaultReminderHour = 9;

/// Reminder repeat choices ('none' = one-shot reminder).
const List<String> kReminderRepeats = [
  'none',
  'daily',
  'weekly',
  'monthly',
  'yearly',
];

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
