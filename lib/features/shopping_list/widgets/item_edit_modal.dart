import 'package:flutter/material.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/category_localizer.dart';
import '../../../data/models/shopping_list_item.dart';
import '../../../core/constants.dart';
import '../../../core/utils/quantity_rules.dart';
import '../../../providers/app_providers.dart';
import '../shopping_list_providers.dart';

/// Bottom-sheet modal for editing an item's name, quantity, unit, and category.
class ItemEditModal extends ConsumerStatefulWidget {
  final ShoppingListItem item;
  const ItemEditModal({super.key, required this.item});

  @override
  ConsumerState<ItemEditModal> createState() => _ItemEditModalState();
}

class _ItemEditModalState extends ConsumerState<ItemEditModal> {
  late TextEditingController _nameCtrl;
  late double _quantity;
  String? _unit;
  int? _categoryId;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.item.name);
    _unit = widget.item.unit;
    // Normalize quantities that don't fit the unit's step grid
    // (e.g. legacy "1 mL" rows) so the stepper never shows 101, 201, …
    _quantity =
        adjustQuantityForUnitChange(widget.item.quantity, _unit);
    _categoryId = widget.item.categoryId;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

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
        );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final catsAsync = ref.watch(categoriesProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            MediaQuery.of(context).padding.bottom +
            24,
      ),
      child: SingleChildScrollView(
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
              autofocus: true,
              decoration: InputDecoration(labelText: t.editItemName),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),

            // Quantity — steps depend on the selected unit
            // (pcs: 1 · g/mL: 100 · kg/L/lb: 0.5)
            Row(
              children: [
                Text(t.editItemQuantity, style: theme.textTheme.bodyLarge),
                const Spacer(),
                IconButton.outlined(
                  icon: const Icon(Icons.remove),
                  onPressed: _quantity - quantityStepForUnit(_unit) >=
                          minQuantityForUnit(_unit)
                      ? () => setState(
                          () => _quantity -= quantityStepForUnit(_unit))
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(formatQuantity(_quantity),
                      style: theme.textTheme.titleMedium),
                ),
                IconButton.outlined(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(
                      () => _quantity += quantityStepForUnit(_unit)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Unit
            DropdownButtonFormField<String>(
              initialValue: _unit,
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
            const SizedBox(height: 24),

            // Save
            FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(t.editItemSave),
            ),
          ],
        ),
      ),
    );
  }
}
