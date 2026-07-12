import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/category_localizer.dart';
import '../../../data/models/shopping_list_item.dart';
import '../../../core/constants.dart';
import '../../../core/utils/item_display.dart';
import '../../../core/utils/quantity_rules.dart';
import '../../../providers/app_providers.dart';
import '../shopping_list_providers.dart';

/// Localized label for a reminder offset (minutes before the due moment).
String reminderOffsetLabel(AppLocalizations t, int minutes) {
  switch (minutes) {
    case 30:
      return t.reminder30MinBefore;
    case 60:
      return t.reminder1HourBefore;
    case 180:
      return t.reminder3HoursBefore;
    case 1440:
      return t.reminder1DayBefore;
    case 2880:
      return t.reminder2DaysBefore;
    case 10080:
      return t.reminder1WeekBefore;
    case 0:
    default:
      return t.reminderAtTime;
  }
}

/// Localized label for a reminder repeat value.
String reminderRepeatLabel(AppLocalizations t, String repeat) {
  switch (repeat) {
    case 'daily':
      return t.repeatDaily;
    case 'weekly':
      return t.repeatWeekly;
    case 'monthly':
      return t.repeatMonthly;
    case 'yearly':
      return t.repeatYearly;
    case 'none':
    default:
      return t.repeatNever;
  }
}

/// Bottom-sheet modal for editing an item's name, quantity, unit, category,
/// price, location, due date, and reminder.
class ItemEditModal extends ConsumerStatefulWidget {
  final ShoppingListItem item;
  const ItemEditModal({super.key, required this.item});

  @override
  ConsumerState<ItemEditModal> createState() => _ItemEditModalState();
}

class _ItemEditModalState extends ConsumerState<ItemEditModal> {
  late TextEditingController _nameCtrl;
  late TextEditingController _priceCtrl;
  late TextEditingController _locationCtrl;
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _locationFocus = FocusNode();
  late double _quantity;
  String? _unit;
  int? _categoryId;

  DateTime? _dueDate;
  bool _hasTime = false;
  bool _reminderEnabled = false;
  int _offsetMinutes = 0;
  String _repeat = 'none';

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _nameCtrl = TextEditingController(text: item.name);
    _priceCtrl = TextEditingController(
      text: item.price != null ? formatQuantity(item.price!) : '',
    );
    _locationCtrl = TextEditingController(text: item.location ?? '');
    _unit = item.unit;
    // Normalize quantities that don't fit the unit's step grid
    // (e.g. legacy "1 mL" rows) so the stepper never shows 101, 201, …
    _quantity = adjustQuantityForUnitChange(item.quantity, _unit);
    _categoryId = item.categoryId;
    _dueDate = item.dueDate;
    _hasTime = item.hasDueTime;
    _reminderEnabled = item.reminderEnabled;
    _offsetMinutes = item.reminderOffsetMinutes;
    _repeat = item.reminderRepeat;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _locationCtrl.dispose();
    _nameFocus.dispose();
    _priceFocus.dispose();
    _locationFocus.dispose();
    super.dispose();
  }

  /// Dismiss the keyboard. Called before opening the date/time pickers so
  /// closing them cannot restore focus (and re-open the keyboard) on a
  /// text field, and by the tap-outside gesture.
  void _dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  // ---------------------------------------------------------------------------
  // Date & reminder actions
  // ---------------------------------------------------------------------------

  Future<void> _pickDate() async {
    _dismissKeyboard();
    final now = DateTime.now();
    final initial = _dueDate ?? now;
    final first = initial.isBefore(now) ? initial : now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(first.year, first.month, first.day),
      lastDate: DateTime(now.year + 5),
    );
    if (picked == null) return;
    setState(() {
      // Preserve a previously chosen time when only the day changes.
      _dueDate = _hasTime && _dueDate != null
          ? DateTime(picked.year, picked.month, picked.day, _dueDate!.hour,
              _dueDate!.minute)
          : DateTime(picked.year, picked.month, picked.day);
    });
  }

  Future<void> _pickTime() async {
    if (_dueDate == null) return;
    _dismissKeyboard();
    final picked = await showTimePicker(
      context: context,
      initialTime: _hasTime
          ? TimeOfDay.fromDateTime(_dueDate!)
          : const TimeOfDay(hour: kDefaultReminderHour, minute: 0),
    );
    if (picked == null) return;
    setState(() {
      _dueDate = DateTime(_dueDate!.year, _dueDate!.month, _dueDate!.day,
          picked.hour, picked.minute);
      _hasTime = true;
    });
  }

  void _clearDate() {
    setState(() {
      _dueDate = null;
      _hasTime = false;
      _reminderEnabled = false;
    });
  }

  void _clearTime() {
    if (_dueDate == null) return;
    setState(() {
      _dueDate = DateTime(_dueDate!.year, _dueDate!.month, _dueDate!.day);
      _hasTime = false;
    });
  }

  Future<void> _toggleReminder(bool enabled) async {
    if (!enabled) {
      setState(() => _reminderEnabled = false);
      return;
    }
    // Android 13+ needs the runtime notification permission. Ask in
    // context, the moment the user first wants a reminder.
    final t = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final granted =
        await ref.read(notificationServiceProvider).ensurePermission();
    if (!mounted) return;
    if (granted) {
      setState(() => _reminderEnabled = true);
    } else {
      setState(() => _reminderEnabled = false);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(content: Text(t.reminderPermissionDenied)),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Save
  // ---------------------------------------------------------------------------

  Future<void> _save() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;

    await ref.read(shoppingItemRepoProvider).updateItem(
          itemId: widget.item.id,
          name: name,
          quantity: _quantity,
          // Empty string means "cleared" (repo maps it to null); null would
          // mean "not provided" and leave the old unit in place.
          unit: _unit ?? '',
          categoryId: _categoryId,
          updateSchedule: true,
          dueDate: _dueDate,
          hasDueTime: _hasTime,
          reminderEnabled: _reminderEnabled,
          reminderOffsetMinutes: _offsetMinutes,
          reminderRepeat: _repeat,
          updateExtras: true,
          price: parsePriceInput(_priceCtrl.text),
          location: _locationCtrl.text,
        );

    if (mounted) Navigator.pop(context);
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final catsAsync = ref.watch(categoriesProvider);
    final theme = Theme.of(context);
    // At strongly enlarged system fonts, horizontal rows run out of space —
    // switch them to stacked layouts. Appearance at normal scale unchanged.
    final bigText = MediaQuery.textScalerOf(context).scale(1.0) >= 1.4;

    // Layout: a scrollable form on top and a PINNED action bar below it.
    // The action bar is outside the scroll view, so growing the form
    // (e.g. enabling the reminder reveals the offset dropdown) can never
    // push Save out of reach — on small screens, large fonts, or with the
    // keyboard open the form scrolls behind the always-visible actions.
    return Padding(
      // Ride above the keyboard; the action bar handles the safe area.
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            // Tapping anywhere that isn't a text field dismisses the
            // keyboard.
            child: GestureDetector(
              onTap: _dismissKeyboard,
              behavior: HitTestBehavior.translucent,
              child: SingleChildScrollView(
        // Bottom padding keeps the last field clear of the action bar.
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(t.editItemTitle,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center),
            const SizedBox(height: 20),

            // Name
            TextField(
              controller: _nameCtrl,
              focusNode: _nameFocus,
              // Only claim focus (and open the keyboard) when there is no
              // name yet. Editing an existing item starts keyboard-closed;
              // date/time/reminder controls never bounce focus back here.
              autofocus: widget.item.name.trim().isEmpty,
              decoration: InputDecoration(labelText: t.editItemName),
              textCapitalization: TextCapitalization.sentences,
              // IME flow: "next" moves through the text fields; only the
              // pinned "Save item" button commits the form.
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _priceFocus.requestFocus(),
            ),
            const SizedBox(height: 16),

            // Quantity — steps depend on the selected unit
            // (pcs: 1 · g/mL: 100 · kg/L/lb: 0.5)
            _QuantityStepper(
              label: t.editItemQuantity,
              value: formatQuantity(_quantity),
              stacked: bigText,
              onDecrement: _quantity - quantityStepForUnit(_unit) >=
                      minQuantityForUnit(_unit)
                  ? () => setState(
                      () => _quantity -= quantityStepForUnit(_unit))
                  : null,
              onIncrement: () => setState(
                  () => _quantity += quantityStepForUnit(_unit)),
            ),
            const SizedBox(height: 16),

            // Unit
            DropdownButtonFormField<String>(
              initialValue: _unit,
              isExpanded: true,
              decoration: InputDecoration(labelText: t.editItemUnit),
              items: [
                DropdownMenuItem(value: null, child: Text(t.editItemUnitNone)),
                ...kUnits.map((u) =>
                    DropdownMenuItem(value: u, child: Text(u))),
              ],
              onChanged: (v) => setState(() {
                _unit = v;
                _quantity = adjustQuantityForUnitChange(_quantity, v);
              }),
            ),
            const SizedBox(height: 16),

            // Category
            catsAsync.when(
              data: (cats) => DropdownButtonFormField<int>(
                initialValue: _categoryId,
                isExpanded: true,
                decoration: InputDecoration(labelText: t.editItemCategory),
                items: cats
                    .map((c) => DropdownMenuItem(
                          value: c.id,
                          child: Text(CategoryLocalizer.translate(c.name, t)),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _categoryId = v),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),

            // Price (optional, plain number — currency is display-only)
            TextField(
              controller: _priceCtrl,
              focusNode: _priceFocus,
              decoration: InputDecoration(labelText: t.editItemPrice),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              // "Next" hops to Location — finishing a field is separate
              // from saving the item.
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _locationFocus.requestFocus(),
            ),
            const SizedBox(height: 16),

            // Location (optional free text)
            TextField(
              controller: _locationCtrl,
              focusNode: _locationFocus,
              decoration: InputDecoration(
                labelText: t.editItemLocation,
                hintText: t.editItemLocationHint,
              ),
              textCapitalization: TextCapitalization.sentences,
              // Last text field: "done" just closes the keyboard. Saving
              // stays an explicit tap on the "Save item" button.
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _dismissKeyboard(),
            ),
            const SizedBox(height: 20),

            // -----------------------------------------------------------------
            // Date & reminder
            // -----------------------------------------------------------------
            Text(
              t.editItemSectionSchedule.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8),

            // Date row
            _PickerRow(
              icon: Icons.event_outlined,
              label: _dueDate != null
                  ? formatFullDate(context, _dueDate!)
                  : t.editItemAddDate,
              isPlaceholder: _dueDate == null,
              onTap: _pickDate,
              onClear: _dueDate != null ? _clearDate : null,
              clearTooltip: t.editItemRemoveDate,
            ),

            // Time row — only meaningful once a date is chosen
            if (_dueDate != null)
              _PickerRow(
                icon: Icons.schedule_outlined,
                label: _hasTime
                    ? formatTime(context, _dueDate!)
                    : t.editItemAddTime,
                isPlaceholder: !_hasTime,
                onTap: _pickTime,
                onClear: _hasTime ? _clearTime : null,
                clearTooltip: t.editItemRemoveTime,
              ),

            // Reminder toggle + offset
            if (_dueDate != null) ...[
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(Icons.notifications_outlined),
                title: Text(t.editItemReminderToggle),
                value: _reminderEnabled,
                onChanged: _toggleReminder,
              ),
              if (_reminderEnabled) ...[
                const SizedBox(height: 4),
                DropdownButtonFormField<int>(
                  initialValue:
                      kReminderOffsetsMinutes.contains(_offsetMinutes)
                          ? _offsetMinutes
                          : 0,
                  isExpanded: true,
                  decoration:
                      InputDecoration(labelText: t.editItemReminderWhen),
                  items: kReminderOffsetsMinutes
                      .map((m) => DropdownMenuItem(
                            value: m,
                            child: Text(reminderOffsetLabel(t, m)),
                          ))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _offsetMinutes = v ?? 0),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue:
                      kReminderRepeats.contains(_repeat) ? _repeat : 'none',
                  isExpanded: true,
                  decoration:
                      InputDecoration(labelText: t.editItemRepeat),
                  items: kReminderRepeats
                      .map((r) => DropdownMenuItem(
                            value: r,
                            child: Text(reminderRepeatLabel(t, r)),
                          ))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _repeat = v ?? 'none'),
                ),
              ],
            ],
          ],
        ),
              ),
            ),
          ),

          // ---------------------------------------------------------------
          // Pinned actions — always visible, never scrolled away
          // ---------------------------------------------------------------
          Container(
            padding: EdgeInsets.fromLTRB(
                24, 12, 24, MediaQuery.of(context).padding.bottom + 12),
            decoration: BoxDecoration(
              // Opaque sheet color so the form scrolls behind, not through.
              color: theme.bottomSheetTheme.backgroundColor ??
                  theme.colorScheme.surfaceContainerLow,
              border: Border(
                top: BorderSide(
                    color: theme.colorScheme.outlineVariant, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(t.commonCancel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: FilledButton(
                    onPressed: _save,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(t.editItemSave),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Quantity stepper — row normally, stacked at large font scales
// ---------------------------------------------------------------------------

class _QuantityStepper extends StatelessWidget {
  final String label;
  final String value;
  final bool stacked;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  const _QuantityStepper({
    required this.label,
    required this.value,
    required this.stacked,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final controls = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.outlined(
          icon: const Icon(Icons.remove),
          onPressed: onDecrement,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(value, style: theme.textTheme.titleMedium),
        ),
        IconButton.outlined(
          icon: const Icon(Icons.add),
          onPressed: onIncrement,
        ),
      ],
    );

    if (stacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 8),
          Center(child: controls),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: Text(label, style: theme.textTheme.bodyLarge)),
        controls,
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tappable picker row with optional clear button (date / time)
// ---------------------------------------------------------------------------

class _PickerRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPlaceholder;
  final VoidCallback onTap;
  final VoidCallback? onClear;
  final String clearTooltip;

  const _PickerRow({
    required this.icon,
    required this.label,
    required this.isPlaceholder,
    required this.onTap,
    required this.onClear,
    required this.clearTooltip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Icon(icon,
                      size: 22,
                      color: isPlaceholder
                          ? theme.colorScheme.onSurfaceVariant
                          : theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isPlaceholder
                            ? theme.colorScheme.onSurfaceVariant
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (onClear != null)
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            tooltip: clearTooltip,
            onPressed: onClear,
          ),
      ],
    );
  }
}
