import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/item_history.dart';
import '../../providers/app_providers.dart';
import '../shared/widgets/suggestion_chips.dart';
import '../shared/widgets/item_autocomplete_field.dart';
import 'home_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  // -------------------------------------------------------------------------
  // Actions
  // -------------------------------------------------------------------------

  Future<void> _addItems(WidgetRef ref, String rawText) async {
    final listId = ref.read(activeListIdProvider);
    if (listId == null) return;

    final itemRepo = ref.read(shoppingItemRepoProvider);
    final catService = ref.read(categoryAssignmentProvider);

    final parts = rawText.contains(',') || rawText.contains('\n')
        ? rawText.split(RegExp(r'[,\n]'))
        : [rawText];

    for (final part in parts) {
      final t = part.trim();
      if (t.isEmpty) continue;
      final catId = await catService.assignCategory(t.toLowerCase().trim());
      await itemRepo.addItem(
        listId: listId,
        name: t,
        categoryId: catId,
        addedFrom: 'manual',
      );
    }
  }

  Future<void> _addFromChip(
      WidgetRef ref, ItemHistory item, String source) async {
    final listId = ref.read(activeListIdProvider);
    if (listId == null) return;
    HapticFeedback.lightImpact();
    await ref.read(shoppingItemRepoProvider).addItem(
          listId: listId,
          name: item.displayName,
          categoryId: item.categoryId,
          addedFrom: source,
        );
  }

  // -------------------------------------------------------------------------
  // Manage suggestion history (long-press on a chip)
  // -------------------------------------------------------------------------

  void _showHistoryActions(
      BuildContext context, WidgetRef ref, ItemHistory item) {
    final t = AppLocalizations.of(context);
    HapticFeedback.selectionClick();

    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                item.displayName,
                style: Theme.of(ctx)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: Text(t.commonRename),
              onTap: () {
                Navigator.pop(ctx);
                _showRenameHistoryDialog(context, ref, item);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline,
                  color: Theme.of(ctx).colorScheme.error),
              title: Text(
                t.historyRemove,
                style: TextStyle(color: Theme.of(ctx).colorScheme.error),
              ),
              onTap: () {
                Navigator.pop(ctx);
                _confirmRemoveHistory(context, ref, item);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showRenameHistoryDialog(
      BuildContext context, WidgetRef ref, ItemHistory item) {
    final t = AppLocalizations.of(context);
    final ctrl = TextEditingController(text: item.displayName);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.historyRenameDialogTitle),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t.commonCancel),
          ),
          FilledButton(
            onPressed: () async {
              final newName = ctrl.text.trim();
              if (newName.isNotEmpty) {
                await ref
                    .read(itemHistoryRepoProvider)
                    .renameHistory(item.normalizedName, newName);
              }
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: Text(t.commonRename),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmRemoveHistory(
      BuildContext context, WidgetRef ref, ItemHistory item) async {
    final t = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.historyRemoveDialogTitle),
        content: Text(t.historyRemoveDialogMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
              foregroundColor: Theme.of(ctx).colorScheme.onError,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.commonRemove),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref
        .read(itemHistoryRepoProvider)
        .deleteByNormalizedName(item.normalizedName);
  }

  // -------------------------------------------------------------------------
  // Build
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final summaryAsync = ref.watch(activeListSummaryProvider);
    final suggestionsAsync = ref.watch(suggestionsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt_outlined),
            tooltip: t.homeMenuLists,
            onPressed: () => Navigator.pushNamed(context, '/lists'),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: t.homeMenuSettings,
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // List summary card
          summaryAsync.when(
            data: (summary) => _SummaryCard(
              summary: summary,
              onTap: () => Navigator.pushNamed(context, '/list'),
            ),
            loading: () => const Card(
              child: ListTile(title: Text('...')),
            ),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const SizedBox(height: 20),

          // Quick add input with autocomplete
          ItemAutocompleteField(
            hintText: t.homeInputHint,
            submitLabel: t.homeAddButton,
            onSubmit: (text) => _addItems(ref, text),
          ),

          const SizedBox(height: 28),

          // Suggestion chip sections
          suggestionsAsync.when(
            data: (s) {
              if (s.isEmpty) return _EmptyHint(theme: theme, hint: t.homeEmptyHint);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SuggestionChipSection(
                    label: t.homeSectionPattern,
                    onLongPress: (h) => _showHistoryActions(context, ref, h),
                    items: s.pattern,
                    icon: Icons.auto_awesome,
                    onTap: (h) => _addFromChip(ref, h, 'pattern'),
                  ),
                  SuggestionChipSection(
                    label: t.homeSectionFrequent,
                    onLongPress: (h) => _showHistoryActions(context, ref, h),
                    items: s.frequent,
                    icon: Icons.trending_up,
                    onTap: (h) => _addFromChip(ref, h, 'chip'),
                  ),
                  SuggestionChipSection(
                    label: t.homeSectionRecent,
                    onLongPress: (h) => _showHistoryActions(context, ref, h),
                    items: s.recent,
                    onTap: (h) => _addFromChip(ref, h, 'recent'),
                  ),
                  SuggestionChipSection(
                    label: t.homeSectionFavorites,
                    onLongPress: (h) => _showHistoryActions(context, ref, h),
                    items: s.favorites,
                    icon: Icons.star_outline,
                    onTap: (h) => _addFromChip(ref, h, 'favorite'),
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/list'),
        icon: const Icon(Icons.shopping_cart_checkout),
        label: Text(t.homeOpenListFab),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-widgets
// ---------------------------------------------------------------------------

class _SummaryCard extends StatelessWidget {
  final ActiveListSummary? summary;
  final VoidCallback onTap;

  const _SummaryCard({required this.summary, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final total = summary?.totalItems ?? 0;
    final checked = summary?.checkedItems ?? 0;
    final name = summary?.list.name ?? t.homeDefaultListName;

    final subtitle = total == 0
        ? t.homeListCardHint
        : t.homeItemsCheckedSummary(checked, total);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Icon(
          total == 0
              ? Icons.shopping_cart_outlined
              : Icons.shopping_cart_checkout,
          color: theme.colorScheme.primary,
          size: 28,
        ),
        title: Text(name, style: theme.textTheme.titleMedium),
        subtitle: Text(subtitle),
        trailing:
            Icon(Icons.chevron_right, color: theme.colorScheme.primary),
        onTap: onTap,
      ),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  final ThemeData theme;
  final String hint;
  const _EmptyHint({required this.theme, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_basket_outlined,
              size: 72, color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 16),
          Text(
            hint,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.outline),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
