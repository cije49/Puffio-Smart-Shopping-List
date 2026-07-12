import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/shopping_list_item.dart';

/// Locale-aware display helpers for the optional item metadata
/// (due date, price, location).

/// "12 Jul" / "Jul 12" (+ ", 14:30" when a time is set); adds the year
/// when the date is not in the current year. Follows the app locale.
String formatDueDate(BuildContext context, ShoppingListItem item) {
  final due = item.dueDate;
  if (due == null) return '';
  final locale = Localizations.localeOf(context).toString();
  final now = DateTime.now();
  final dateStr = due.year == now.year
      ? DateFormat.MMMd(locale).format(due)
      : DateFormat.yMMMd(locale).format(due);
  if (!item.hasDueTime) return dateStr;
  return '$dateStr, ${DateFormat.jm(locale).format(due)}';
}

/// Full date for pickers/calendar detail ("Saturday, 12 July 2026").
String formatFullDate(BuildContext context, DateTime date) {
  final locale = Localizations.localeOf(context).toString();
  return DateFormat.yMMMMEEEEd(locale).format(date);
}

/// Time-of-day per locale ("14:30" / "2:30 PM").
String formatTime(BuildContext context, DateTime dateTime) {
  final locale = Localizations.localeOf(context).toString();
  return DateFormat.jm(locale).format(dateTime);
}

/// Price with a fixed euro symbol (display only — the stored value is a
/// plain number). The locale still controls number formatting and symbol
/// placement: "€12.50" in English, "12,50 €" in Croatian.
String formatPrice(BuildContext context, double price) {
  final locale = Localizations.localeOf(context).toString();
  return NumberFormat.currency(locale: locale, symbol: '€').format(price);
}

/// True when the item's due moment (or end of its due day, for date-only
/// items) is in the past and the item is still unchecked.
bool isOverdue(ShoppingListItem item) {
  final due = item.dueDate;
  if (due == null || item.isChecked) return false;
  // A repeating reminder is perpetual — its anchor date being in the past
  // is expected, not "overdue".
  if (item.reminderEnabled && item.reminderRepeat != 'none') return false;
  final deadline = item.hasDueTime
      ? due
      : DateTime(due.year, due.month, due.day, 23, 59, 59);
  return deadline.isBefore(DateTime.now());
}

/// Parses user price input accepting both "," and "." as decimal separator.
double? parsePriceInput(String raw) {
  final cleaned = raw.trim().replaceAll(',', '.');
  if (cleaned.isEmpty) return null;
  final value = double.tryParse(cleaned);
  if (value == null || value < 0) return null;
  return value;
}
