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
  // Home screen widget toggle
  // ---------------------------------------------------------------------------
  static const _widgetEnabledKey = 'isWidgetEnabled';

  Future<bool> isWidgetEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_widgetEnabledKey) ?? false;
  }

  Future<void> setWidgetEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_widgetEnabledKey, value);
  }

  // ---------------------------------------------------------------------------
  // Clear
  // ---------------------------------------------------------------------------
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
