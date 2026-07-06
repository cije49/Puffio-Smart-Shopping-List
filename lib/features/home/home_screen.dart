import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/item_history.dart';
import '../../providers/app_providers.dart';
import '../shopping_list/shopping_list_providers.dart';
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
            if (item.isFavorite)
              ListTile(
                leading: const Icon(Icons.push_pin_outlined),
                title: Text(t.historyUnpin),
                onTap: () async {
                  Navigator.pop(ctx);
                  // Unpin only — the item's history and stats are kept, so
                  // it may still surface in Suggested for you later.
                  await ref
                      .read(itemHistoryRepoProvider)
                      .toggleFavoriteByName(item.normalizedName);
                },
              ),
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
          // List summary card with horizontal navigation between lists
          _ListPager(
            summaryAsync: summaryAsync,
            onOpen: () => Navigator.pushNamed(context, '/list'),
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
            // Keep previous chips on screen while the provider rebuilds
            // after a list switch — prevents a full-section spinner flash.
            skipLoadingOnReload: true,
            data: (s) {
              if (s.isEmpty) return _EmptyHint(theme: theme, hint: t.homeEmptyHint);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SuggestionChipSection(
                    label: t.homeSectionFavorites,
                    onLongPress: (h) => _showHistoryActions(context, ref, h),
                    items: s.favorites,
                    icon: Icons.push_pin_outlined,
                    onTap: (h) => _addFromChip(ref, h, 'favorite'),
                  ),
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

/// Horizontal navigation between lists on the Home screen.
/// The card stays full-width and visually identical regardless of list
/// count. With >1 list: swipe left/right for prev/next, tap the left ~22%
/// of the card for previous, right ~22% for next, and the center to open.
/// Non-wrapping: edge taps at the first/last list do nothing.
class _ListPager extends ConsumerWidget {
  final AsyncValue<ActiveListSummary?> summaryAsync;
  final VoidCallback onOpen;

  const _ListPager({required this.summaryAsync, required this.onOpen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final lists = ref.watch(orderedListsProvider).valueOrNull ?? [];
    final activeId = ref.watch(activeListIdProvider);
    final idx = lists.indexWhere((l) => l.id == activeId);
    final hasMany = lists.length > 1;
    final hasPrev = hasMany && idx > 0;
    final hasNext = hasMany && idx >= 0 && idx < lists.length - 1;

    void switchTo(int i) {
      HapticFeedback.selectionClick();
      ref.read(activeListIdProvider.notifier).setActive(lists[i].id);
    }

    // Single list: the whole card simply opens it.
    if (!hasMany) {
      return summaryAsync.when(
        skipLoadingOnReload: true,
        data: (summary) => _SummaryCard(summary: summary, onTap: onOpen),
        loading: () => const Card(child: ListTile(title: Text('...'))),
        error: (_, __) => const SizedBox.shrink(),
      );
    }

    // Multi list: tap zones + swipe. The inner card is non-interactive;
    // the outer detector decides by tap position.
    // skipLoadingOnReload: when the active list changes, the summary
    // provider rebuilds and momentarily reports loading — rendering the
    // previous card for that frame (instead of a '...' placeholder)
    // keeps the swipe transition visually stable.
    final card = summaryAsync.when(
      skipLoadingOnReload: true,
      data: (summary) => _SummaryCard(summary: summary, onTap: null),
      loading: () => const Card(child: ListTile(title: Text('...'))),
      error: (_, __) => const SizedBox.shrink(),
    );

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return Semantics(
              button: true,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapUp: (details) {
                  final dx = details.localPosition.dx;
                  if (dx < width * 0.22) {
                    if (hasPrev) switchTo(idx - 1);
                  } else if (dx > width * 0.78) {
                    if (hasNext) switchTo(idx + 1);
                  } else {
                    onOpen();
                  }
                },
                onHorizontalDragEnd: (details) {
                  final v = details.primaryVelocity;
                  if (v == null) return;
                  if (v < -200 && hasNext) switchTo(idx + 1);
                  if (v > 200 && hasPrev) switchTo(idx - 1);
                },
                child: card,
              ),
            );
          },
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(lists.length, (i) {
            return Container(
              width: 7,
              height: 7,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == idx
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outlineVariant,
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final ActiveListSummary? summary;
  final VoidCallback? onTap;

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
