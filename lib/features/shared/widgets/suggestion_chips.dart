import 'package:flutter/material.dart';
import '../../../data/models/item_history.dart';

/// Reusable chip row used on both the Home screen and Add-Item modal.
class SuggestionChipSection extends StatelessWidget {
  final String label;
  final List<ItemHistory> items;
  final void Function(ItemHistory item) onTap;
  final void Function(ItemHistory item)? onLongPress;
  final IconData? icon;

  const SuggestionChipSection({
    super.key,
    required this.label,
    required this.items,
    required this.onTap,
    this.onLongPress,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            final chip = ActionChip(
              avatar: Icon(icon ?? Icons.add, size: 18),
              label: Text(item.displayName),
              onPressed: () => onTap(item),
            );
            if (onLongPress == null) return chip;
            return GestureDetector(
              onLongPress: () => onLongPress!(item),
              child: chip,
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
