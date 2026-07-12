import 'package:shared_preferences/shared_preferences.dart';

/// Persists lightweight app settings using SharedPreferences.
class SettingsRepository {
  static const _darkModeKey = 'isDarkMode'; // legacy, migrated to _themeModeKey
  static const _themeModeKey = 'themeMode';
  static const _localeKey = 'localeCode';

  // ---------------------------------------------------------------------------
  // Theme mode: 'system' | 'light' | 'dark'
  // ---------------------------------------------------------------------------
  Future<String> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_themeModeKey);
    if (stored != null) return stored;
    // Migrate from the old boolean setting.
    final legacyDark = prefs.getBool(_darkModeKey);
    if (legacyDark != null) {
      final mode = legacyDark ? 'dark' : 'light';
      await prefs.setString(_themeModeKey, mode);
      await prefs.remove(_darkModeKey);
      return mode;
    }
    return 'system';
  }

  Future<void> setThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode);
  }

  // ---------------------------------------------------------------------------
  // Locale
  //
  // Stores a language code like "en" or "hr". null means "follow system".
  // ---------------------------------------------------------------------------
  Future<String?> getLocaleCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localeKey);
  }

  Future<void> setLocaleCode(String? code) async {
    final prefs = await SharedPreferences.getInstance();
    if (code == null) {
      await prefs.remove(_localeKey);
    } else {
      await prefs.setString(_localeKey, code);
    }
  }

  // ---------------------------------------------------------------------------
  // Swipe-to-delete hint — learned per list, so each new list can teach
  // the gesture once. Stored as a string list of list ids.
  // ---------------------------------------------------------------------------
  static const _swipeLearnedListsKey = 'swipeDeleteLearnedLists';

  Future<Set<int>> getSwipeLearnedListIds() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_swipeLearnedListsKey) ?? const [];
    return raw.map(int.tryParse).whereType<int>().toSet();
  }

  Future<void> addSwipeLearnedListId(int listId) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = await getSwipeLearnedListIds()
      ..add(listId);
    await prefs.setStringList(
        _swipeLearnedListsKey, ids.map((i) => i.toString()).toList());
  }

  // ---------------------------------------------------------------------------
  // Clear
  // ---------------------------------------------------------------------------
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
