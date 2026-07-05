# Puffio — Smart Shopping List

Flutter Android app with intelligent suggestions, multiple lists, category grouping, favorites, pattern-based predictions, typing autocomplete, and English/Croatian UI. Fully offline, no account required.

Privacy: Puffio stores everything locally and transmits nothing. See the [privacy policy](docs/privacy-policy.html).

## Tech Stack

| Layer | Library |
|---|---|
| UI | Flutter (Material 3, dark mode) |
| State | Riverpod 2.x |
| Database | Isar 3.x (reactive, embedded) |
| Settings | SharedPreferences |
| i18n | flutter_localizations + ARB files |

## Setup

### 1. Install Flutter
Flutter 3.10+ with Dart 3.0+ required.

### 2. Get dependencies
```bash
cd shop_list_pro
flutter pub get
```

This also auto-generates the localization classes from `lib/l10n/app_en.arb` and `app_hr.arb`.

### 3. Generate Isar schema files
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
Re-run after changing any Isar model.

### 4. Run
```bash
flutter run
```

### 5. Android Gradle patch (required once)
If you hit a namespace error from `isar_flutter_libs`, add this to the **bottom** of `android/build.gradle.kts` (before `evaluationDependsOn`):

```kotlin
subprojects {
    afterEvaluate {
        if (hasProperty("android")) {
            extensions.findByName("android")?.let { ext ->
                val androidExt = ext as com.android.build.gradle.BaseExtension
                if (androidExt.namespace == null) {
                    androidExt.namespace = group.toString()
                }
            }
        }
    }
}
```

## Project Structure

```
lib/
├── main.dart                              # Entry point
├── app/
│   ├── app.dart                           # MaterialApp + routing + i18n
│   └── theme.dart                         # Light & dark themes
├── l10n/
│   ├── app_en.arb                         # English translations
│   └── app_hr.arb                         # Croatian translations
├── core/
│   ├── constants.dart                     # App-wide constants
│   ├── database.dart                      # Isar initialisation
│   ├── category_localizer.dart            # Translate default category names
│   └── services/
│       ├── item_normalization_service.dart
│       ├── category_assignment_service.dart
│       └── suggestion_service.dart
├── data/
│   ├── models/
│   │   ├── shopping_list.dart
│   │   ├── shopping_list_item.dart
│   │   ├── item_history.dart
│   │   └── category.dart
│   └── repositories/
│       ├── shopping_list_repository.dart
│       ├── shopping_item_repository.dart
│       ├── item_history_repository.dart   # + searchByPrefix for autocomplete
│       ├── category_repository.dart
│       └── settings_repository.dart       # dark mode + locale persistence
├── providers/
│   └── app_providers.dart                 # All Riverpod providers (incl. locale)
└── features/
    ├── home/                              # Smart Start screen
    ├── shopping_list/                     # Active list + item edit modal
    ├── list_management/
    ├── settings/                          # Dark mode, language, clear data
    └── shared/widgets/
        ├── suggestion_chips.dart
        └── item_autocomplete_field.dart   # Typing autocomplete widget
```

## Features

### Core
- **Multiple lists** — create, rename, duplicate, delete. One list is always "active".
- **Smart suggestions** — 4 sections: pattern-based ("You might need"), frequent, recent, favorites.
- **Pattern detection** — tracks average purchase interval; suggests items that are "due".
- **Category auto-grouping** — items grouped by category, auto-assigned from history.
- **Favorites** — pin items from the list screen; always visible on Home.
- **Quantity & units** — optional quantity (+ / −) and unit per item.
- **Multi-add** — comma or newline-separated input adds multiple items at once.
- **Duplicate handling** — adding an existing item increments its quantity.
- **Swipe to delete** — no confirmation dialog (speed priority).
- **Inline editing** — bottom-sheet modal with name, quantity, unit, category.
- **Dark mode** — toggle in Settings; persisted across sessions.
- **Fully offline, no account required.**

### New in this version
- **🌍 Multi-language UI** — English + Croatian, with "System default" option. Language switcher in Settings; choice is persisted. Category names are translated at display time (not in the database), so switching language updates all existing items.
- **⚡ Typing autocomplete** — as you type in the quick-add input on Home or in the Add-Item modal on the list screen, matching items from your history appear in a dropdown. One tap completes. Works correctly with multi-item input (only the last token after a comma/newline drives suggestions).

### Adding more languages
1. Create `lib/l10n/app_XX.arb` (e.g. `app_de.arb` for German).
2. Copy all keys from `app_en.arb` and translate the values.
3. Add the locale option to the language picker in `settings_screen.dart`.
4. Add any new category translations to `category_localizer.dart` if you change the seeded names.

## Screens

| Screen | Route | Purpose |
|---|---|---|
| Home (Smart Start) | `/` | Suggestion chips, quick-add with autocomplete, list summary |
| Active List | `/list` | In-store shopping — check, edit, delete, grouped by category |
| List Management | `/lists` | Create, rename, duplicate, delete, set active |
| Settings | `/settings` | Language picker, dark mode, clear all data |
