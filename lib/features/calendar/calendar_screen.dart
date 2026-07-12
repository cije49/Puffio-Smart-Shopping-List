import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';

import '../../core/utils/item_display.dart';
import '../../providers/app_providers.dart';
import '../shopping_list/widgets/item_edit_modal.dart';
import 'calendar_providers.dart';

/// Simple month-view overview of all items that have a due date.
/// Days containing items are marked with a dot; selecting a day lists its
/// items (name + owning list). Tapping an item opens the item editor; the
/// trailing button jumps to the item's list.
class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _visibleMonth; // always the 1st of the month
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _visibleMonth = DateTime(now.year, now.month, 1);
    _selectedDay = dayKey(now);
  }

  void _changeMonth(int delta) {
    setState(() {
      _visibleMonth =
          DateTime(_visibleMonth.year, _visibleMonth.month + delta, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final byDayAsync = ref.watch(datedItemsByDayProvider);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      appBar: AppBar(title: Text(t.calendarTitle)),
      body: byDayAsync.when(
        data: (byDay) {
          if (byDay.isEmpty) {
            return _EmptyCalendar(theme: theme, t: t);
          }
          final dayItems = byDay[_selectedDay] ?? const <DatedItem>[];
          return ListView(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 24 + bottomInset),
            children: [
              _MonthHeader(
                month: _visibleMonth,
                onPrevious: () => _changeMonth(-1),
                onNext: () => _changeMonth(1),
              ),
              const SizedBox(height: 4),
              _MonthGrid(
                month: _visibleMonth,
                selectedDay: _selectedDay,
                markedDays: byDay.keys.toSet(),
                onSelect: (day) => setState(() => _selectedDay = day),
              ),
              const SizedBox(height: 12),
              Divider(color: theme.colorScheme.outlineVariant),
              const SizedBox(height: 8),
              Text(
                formatFullDate(context, _selectedDay),
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              if (dayItems.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    t.calendarNoItemsForDay,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.outline),
                  ),
                )
              else
                for (final entry in dayItems)
                  _DayItemTile(entry: entry),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Month header — chevrons + localized month name
// ---------------------------------------------------------------------------

class _MonthHeader extends StatelessWidget {
  final DateTime month;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _MonthHeader({
    required this.month,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final label = toBeginningOfSentenceCase(
      DateFormat.yMMMM(locale).format(month),
      locale,
    );

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: onPrevious,
        ),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: onNext,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Month grid — locale-aware first day of week, dot markers, no fixed
// heights that would clip at enlarged font sizes
// ---------------------------------------------------------------------------

class _MonthGrid extends StatelessWidget {
  final DateTime month;
  final DateTime selectedDay;
  final Set<DateTime> markedDays;
  final void Function(DateTime day) onSelect;

  const _MonthGrid({
    required this.month,
    required this.selectedDay,
    required this.markedDays,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    // 0 = Sunday, 1 = Monday, … (locale convention).
    final firstDayIndex =
        MaterialLocalizations.of(context).firstDayOfWeekIndex;
    final textScaler = MediaQuery.textScalerOf(context);

    // Cell height grows with the system font so day numbers never clip.
    final cellExtent = textScaler.scale(24.0) + 20;

    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    // DateTime.weekday: 1 = Monday … 7 = Sunday → 0 = Sunday … 6 = Saturday.
    final firstWeekday = month.weekday % 7;
    final leadingBlanks = (firstWeekday - firstDayIndex + 7) % 7;
    final today = dayKey(DateTime.now());

    // Weekday labels, starting from the locale's first day of week.
    // 2026-01-04 is a Sunday; offset from it to get each weekday's name.
    final sunday = DateTime(2026, 1, 4);
    final weekdayLabels = List.generate(7, (i) {
      final day = sunday.add(Duration(days: (firstDayIndex + i) % 7));
      return DateFormat.E(locale).format(day);
    });

    return Column(
      children: [
        Row(
          children: weekdayLabels
              .map((label) => Expanded(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.outline,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 4),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisExtent: cellExtent,
          ),
          itemCount: leadingBlanks + daysInMonth,
          itemBuilder: (context, index) {
            if (index < leadingBlanks) return const SizedBox.shrink();
            final dayNum = index - leadingBlanks + 1;
            final day = DateTime(month.year, month.month, dayNum);
            final isSelected = day == selectedDay;
            final isToday = day == today;
            final isMarked = markedDays.contains(day);

            return InkWell(
              onTap: () => onSelect(day),
              customBorder: const CircleBorder(),
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Container(
                  alignment: Alignment.center,
                  decoration: isSelected
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primary,
                        )
                      : isToday
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: theme.colorScheme.primary),
                            )
                          : null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$dayNum',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? theme.colorScheme.onPrimary
                              : null,
                          fontWeight:
                              isToday ? FontWeight.w700 : null,
                        ),
                      ),
                      // Dot marker for days that contain items.
                      Container(
                        width: 5,
                        height: 5,
                        margin: const EdgeInsets.only(top: 1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isMarked
                              ? (isSelected
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.primary)
                              : Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// One scheduled item for the selected day
// ---------------------------------------------------------------------------

class _DayItemTile extends ConsumerWidget {
  final DatedItem entry;
  const _DayItemTile({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final item = entry.item;
    final muted = theme.colorScheme.outline;

    final details = <String>[
      entry.listName,
      if (item.hasDueTime) formatTime(context, item.dueDate!),
    ];

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        item.isChecked
            ? Icons.check_circle_outline
            : (item.reminderEnabled
                ? Icons.notifications_active_outlined
                : Icons.event_outlined),
        color: item.isChecked ? muted : theme.colorScheme.primary,
      ),
      title: Text(
        item.name,
        style: TextStyle(
          decoration: item.isChecked ? TextDecoration.lineThrough : null,
          color: item.isChecked ? muted : null,
        ),
      ),
      subtitle: Text(
        details.join(' · '),
        style: theme.textTheme.bodySmall?.copyWith(color: muted),
      ),
      trailing: IconButton(
        icon: Icon(Icons.arrow_forward, color: theme.colorScheme.primary),
        tooltip: t.calendarOpenListTooltip,
        onPressed: () async {
          await ref
              .read(activeListIdProvider.notifier)
              .setActive(item.listId);
          if (context.mounted) {
            Navigator.pushNamed(context, '/list');
          }
        },
      ),
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => ItemEditModal(item: item),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty state — no item anywhere has a date yet
// ---------------------------------------------------------------------------

class _EmptyCalendar extends StatelessWidget {
  final ThemeData theme;
  final AppLocalizations t;
  const _EmptyCalendar({required this.theme, required this.t});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.event_note_outlined,
                size: 88, color: theme.colorScheme.outlineVariant),
            const SizedBox(height: 20),
            Text(
              t.calendarEmptyTitle,
              style: theme.textTheme.titleLarge
                  ?.copyWith(color: theme.colorScheme.outline),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              t.calendarEmptyHint,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.outline),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
