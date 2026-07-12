import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import '../data/repositories/shopping_list_repository.dart';
import '../data/repositories/shopping_item_repository.dart';
import '../data/repositories/item_history_repository.dart';
import '../data/repositories/category_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../core/services/item_normalization_service.dart';
import '../core/services/category_assignment_service.dart';
import '../core/services/suggestion_service.dart';
import '../core/services/backup_service.dart';
import '../core/services/notification_service.dart';

// =============================================================================
// Database — must be overridden in main.dart
// =============================================================================
final isarProvider = Provider<Isar>(
  (_) => throw UnimplementedError('Override isarProvider in main()'),
);

// =============================================================================
// Repositories
// =============================================================================
final shoppingListRepoProvider = Provider<ShoppingListRepository>(
  (ref) => ShoppingListRepository(
    ref.watch(isarProvider),
    ref.watch(notificationServiceProvider),
  ),
);

final shoppingItemRepoProvider = Provider<ShoppingItemRepository>(
  (ref) => ShoppingItemRepository(
    ref.watch(isarProvider),
    ref.watch(notificationServiceProvider),
  ),
);

final itemHistoryRepoProvider = Provider<ItemHistoryRepository>(
  (ref) => ItemHistoryRepository(ref.watch(isarProvider)),
);

final categoryRepoProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(ref.watch(isarProvider)),
);

final settingsRepoProvider = Provider<SettingsRepository>(
  (_) => SettingsRepository(),
);

// =============================================================================
// Services
// =============================================================================
final normalizationServiceProvider = Provider<ItemNormalizationService>(
  (_) => const ItemNormalizationService(),
);

final categoryAssignmentProvider = Provider<CategoryAssignmentService>(
  (ref) => CategoryAssignmentService(
    ref.watch(itemHistoryRepoProvider),
    ref.watch(categoryRepoProvider),
  ),
);

final suggestionServiceProvider = Provider<SuggestionService>(
  (ref) => SuggestionService(ref.watch(itemHistoryRepoProvider)),
);

final backupServiceProvider = Provider<BackupService>(
  (ref) => BackupService(ref.watch(isarProvider)),
);

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => NotificationService(ref),
);

/// Item id the shopping-list screen should scroll to and briefly highlight
/// (set when the user taps a reminder notification). The highlight clears
/// itself after the animation finishes.
final notificationHighlightProvider = StateProvider<int?>((_) => null);

/// Normalized names of favorited items (drives star icons in the list).
final favoriteNamesProvider = StreamProvider<Set<String>>((ref) {
  return ref.watch(itemHistoryRepoProvider).watchFavoriteNames();
});

// =============================================================================
// Active list state
// =============================================================================
class ActiveListNotifier extends StateNotifier<int?> {
  final ShoppingListRepository _repo;

  ActiveListNotifier(this._repo) : super(null);

  Future<void> load({String? defaultName}) async {
    state = await _repo.ensureActiveList(defaultName: defaultName);
  }

  Future<void> setActive(int listId) async {
    await _repo.setActive(listId);
    state = listId;
  }

  Future<void> onListDeleted(int deletedId) async {
    if (state == deletedId) {
      state = await _repo.ensureActiveList();
    }
  }

  Future<void> onListCreated(int newId) async {
    await _repo.setActive(newId);
    state = newId;
  }
}

final activeListIdProvider =
    StateNotifierProvider<ActiveListNotifier, int?>((ref) {
  return ActiveListNotifier(ref.watch(shoppingListRepoProvider));
});

// =============================================================================
// Theme mode (system / light / dark)
// =============================================================================
final initialThemeModeProvider = Provider<ThemeMode>((_) => ThemeMode.system);

ThemeMode themeModeFromString(String s) => switch (s) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

String themeModeToString(ThemeMode m) => switch (m) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final SettingsRepository _repo;
  ThemeModeNotifier(this._repo, ThemeMode initial) : super(initial);

  Future<void> set(ThemeMode mode) async {
    state = mode;
    await _repo.setThemeMode(themeModeToString(mode));
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier(
    ref.watch(settingsRepoProvider),
    ref.watch(initialThemeModeProvider),
  );
});

// =============================================================================
// Locale
//
// state == null means "follow system locale".
// =============================================================================
final initialLocaleProvider = Provider<Locale?>((_) => null);

class LocaleNotifier extends StateNotifier<Locale?> {
  final SettingsRepository _repo;
  LocaleNotifier(this._repo, Locale? initial) : super(initial);

  Future<void> set(Locale? locale) async {
    state = locale;
    await _repo.setLocaleCode(locale?.languageCode);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  return LocaleNotifier(
    ref.watch(settingsRepoProvider),
    ref.watch(initialLocaleProvider),
  );
});

// =============================================================================
// Swipe-to-delete hint state
// =============================================================================
final initialSwipeDeleteLearnedProvider =
    Provider<Set<int>>((_) => const {});

class SwipeDeleteLearnedNotifier extends StateNotifier<Set<int>> {
  final SettingsRepository _repo;
  SwipeDeleteLearnedNotifier(this._repo, Set<int> initial) : super(initial);

  Future<void> markLearned(int listId) async {
    if (state.contains(listId)) return;
    state = {...state, listId};
    await _repo.addSwipeLearnedListId(listId);
  }
}

final swipeDeleteLearnedProvider =
    StateNotifierProvider<SwipeDeleteLearnedNotifier, Set<int>>((ref) {
  return SwipeDeleteLearnedNotifier(
    ref.watch(settingsRepoProvider),
    ref.watch(initialSwipeDeleteLearnedProvider),
  );
});

