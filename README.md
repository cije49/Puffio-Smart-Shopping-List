# Puffio — Smart Shopping List

Flutter Android app that learns what you buy. Intelligent suggestions, multiple lists, category grouping, item dates with repeatable reminders, a calendar overview, remembered prices and locations, and an English/Croatian UI. Fully offline, no account required.

**Privacy:** Puffio stores everything locally and transmits nothing. See [PRIVACY_POLICY.md](PRIVACY_POLICY.md) or the [HTML version](docs/privacy-policy.html).

## Tech Stack

| Layer | Library |
|---|---|
| UI | Flutter (Material 3, light/dark) |
| State | Riverpod 2.x |
| Database | isar_community 3.x (reactive, embedded, 16 KB page-size compliant) |
| Notifications | flutter_local_notifications + timezone / flutter_timezone |
| Settings | SharedPreferences |
| i18n | flutter_localizations + hand-written localization classes (EN, HR) |

## Setup

### 1. Install Flutter
Flutter 3.10+ with Dart 3.0+ required.

### 2. Get dependencies
```bash
flutter pub get
```

### 3. Generate Isar schema files
```bash
dart run build_runner build --delete-conflicting-outputs
```
Re-run after changing any Isar model (`lib/data/models/`).

### 4. Run
```bash
flutter run
```

Debug builds install as **Puffio Dev** (`com.nexforgelabs.puffio.debug`) with their own data, so they coexist with the Play Store version (`com.nexforgelabs.puffio`) on the same device. Release builds are signed via `android/key.properties` (not committed).

### Localization note
Translations live in hand-written Dart classes (`lib/l10n/app_localizations*.dart`), not generated ARB output. To change a string, edit the abstract getter in `app_localizations.dart` and both the `_en` and `_hr` implementations. To add a language, create `app_localizations_XX.dart`, register it in `app_localizations.dart`, and add it to the language picker in `settings_screen.dart`.

## Project Structure

```
lib/
├── main.dart                              # Entry point, DB + notification init
├── app/
│   ├── app.dart                           # MaterialApp, routing, notification-tap navigation
│   └── theme.dart                         # Light & dark themes
├── l10n/
│   ├── app_localizations.dart             # Abstract strings + delegate
│   ├── app_localizations_en.dart          # English
│   └── app_localizations_hr.dart          # Croatian
├── core/
│   ├── constants.dart                     # Units, reminder offsets/repeats, categories
│   ├── database.dart                      # Isar initialisation
│   ├── category_localizer.dart            # Translate default category names
│   ├── services/
│   │   ├── notification_service.dart      # Schedule/cancel/resync item reminders
│   │   ├── backup_service.dart            # JSON export/import (replace-all)
│   │   ├── suggestion_service.dart        # Suggestion scoring & sections
│   │   ├── category_assignment_service.dart
│   │   ├── category_keywords.dart         # EN/HR keyword → category mapping
│   │   ├── item_normalization_service.dart
│   │   ├── history_merge.dart
│   │   └── suggestion_scoring.dart
│   └── utils/
│       ├── item_display.dart              # Locale-aware date/price formatting, overdue
│       ├── quantity_rules.dart            # Unit-aware quantity steps
│       └── name_generator.dart            # Unique list names
├── data/
│   ├── models/                            # ShoppingList, ShoppingListItem, ItemHistory, Category
│   └── repositories/                      # CRUD + notification lifecycle hooks
├── providers/
│   └── app_providers.dart                 # All app-level Riverpod providers
└── features/
    ├── home/                              # Smart Start screen
    ├── shopping_list/                     # Active list, item edit modal, highlight-on-tap
    ├── calendar/                          # Month overview of dated items
    ├── list_management/
    ├── settings/                          # Language, theme, backup, what's new
    ├── help/                              # Offline help & tips (EN/HR)
    └── shared/widgets/                    # Suggestion chips, autocomplete field
```

## Features

### Lists & items
- **Multiple lists** — create, rename, duplicate, delete; swipe or edge-tap the Home card to switch.
- **Smart suggestions** — pinned, pattern-based ("You might need these"), and frequency-based sections that adapt to your habits.
- **Typing autocomplete** — matching items from history appear as you type; works with multi-item input.
- **Multi-add** — comma or newline-separated input adds several items at once.
- **Category auto-grouping** — items grouped for a smoother trip through the store; manual changes are remembered.
- **Quantity & units** — unit-aware steppers (pcs 1 · g/mL 100 · kg/L 0.5); units are remembered per item, never guessed.
- **Swipe to delete** with Undo; long-press drag to reorder.

### Dates, reminders & calendar
- **Item dates** — optional date and time per item, shown under the item, localized.
- **Reminders** — local notifications with offsets from "at the selected time" up to "1 week before", and repeats (daily/weekly/monthly/yearly). Survive app and device restarts; exact alarms when permitted, graceful inexact fallback.
- **Tap a reminder** → the right list opens and the item is scrolled to and briefly highlighted.
- **Calendar overview** — month grid with dot markers; tap a day to see its items across all lists.

### Price & location memory
- Note an item's price (shown in €) and where you found it ("Lidl", "Aisle 4"). Puffio remembers both per item and prefills them the next time you add it — a lightweight "where was this cheapest" memory, fully user-entered.

### General
- **Backup & restore** — full JSON export/import, nothing uploaded anywhere.
- **English + Croatian** UI with "System default" option; light/dark theme.
- **Accessibility** — layouts adapt to enlarged system text (rows wrap, dialogs scroll, actions stay reachable).
- **Offline help** — Help & tips screen documenting every feature, plus a "What's new" dialog in Settings.

## Screens

| Screen | Route | Purpose |
|---|---|---|
| Home (Smart Start) | `/` | Suggestion chips, quick-add with autocomplete, list pager |
| Active List | `/list` | In-store shopping — check, edit, reorder, grouped by category |
| Calendar | `/calendar` | Month overview of all dated items |
| List Management | `/lists` | Create, rename, duplicate, delete, set active |
| Settings | `/settings` | Language, theme, backup, what's new, clear data |
| Help & Tips | `/help` | Offline feature guide (EN/HR) |

## Testing

```bash
flutter test
```
Pure-logic test suites cover normalization, suggestion scoring, history merging, quantity rules, category keywords, and list-name generation.

## Android notes

- `POST_NOTIFICATIONS` is requested in-context the first time a reminder is enabled (Android 13+); `SCHEDULE_EXACT_ALARM` is optional — without it reminders fall back to inexact scheduling.
- A boot receiver re-registers scheduled reminders after restart; the app additionally resyncs the full schedule from the database on every launch.
- Core-library desugaring is enabled (required by flutter_local_notifications).

See [CHANGELOG.md](CHANGELOG.md) for release history.
