import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const _seed = Color(0xFF4CAF50);

  static ThemeData get lightTheme => _build(Brightness.light);
  static ThemeData get darkTheme => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    );

    return ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 1,
        ),
        chipTheme: ChipThemeData(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          labelStyle: TextStyle(
            fontSize: 15,
            color: colorScheme.onSurface,
          ),
          iconTheme: IconThemeData(
            color: colorScheme.onSurfaceVariant,
            size: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        listTileTheme: const ListTileThemeData(minVerticalPadding: 12),
        dividerTheme: const DividerThemeData(space: 1),
      );
  }
}
