import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/category_localizer.dart';
import '../../core/utils/item_display.dart';
import '../../core/utils/quantity_rules.dart';
import '../../data/models/shopping_list.dart';
import '../../data/models/shopping_list_item.dart';
import '../../providers/app_providers.dart';
import '../shared/widgets/item_autocomplete_field.dart';
import 'shopping_list_providers.dart';
import 'widgets/item_edit_modal.dart';

class ShoppingListScreen extends ConsumerStatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  ConsumerState<ShoppingListScreen> createState() =>
      _ShoppingListScreenState();
}

class _ShoppingListScreenState extends ConsumerState<ShoppingListScreen> {
  final ScrollController _scrollController = ScrollController();

  /// One stable key per item id so a notification target can be located
  /// after the lazily-built list has rendered, regardless of its index
  /// (grouping, checked state, or sorting may have changed it).
  final Map<int, GlobalKey> _tileKeys = {};

  GlobalKey _tileKeyFor(int itemId) =>
      _tileKeys.putIfAbsent(itemId, GlobalKey.new);

  @override
  void initState() {
    super.initState();
    // The screen may be pushed after the highlight target was set
    // (notification tap): check once the first frame has rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final target = ref.read(notificationHighlightProvider);
      if (target != null) _revealItem(target);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Scrolls until the tile for [itemId] exists and is visible, roughly
  /// centering it. Because the list builds lazily, the loop nudges the
  /// scroll position down until the tile's key gets a context.
  Future<void> _revealItem(int itemId) async {
    for (var attempt = 0; attempt < 40; attempt++) {
      if (!mounted) return;
      final ctx = _tileKeys[itemId]?.currentContext;
      // Guard with the element's own `mounted` (not the State's) so the
      // context is known-valid despite the awaits in this loop.
      if (ctx != null && ctx.mounted) {
        await Scrollable.ensureVisible(
          ctx,
          alignment: 0.35,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
        return;
      }
      if (_scrollController.hasClients) {
        final pos = _scrollController.position;
        if (pos.pixels >= pos.maxScrollExtent - 1) return; // not found
        await _scrollController.animateTo(
          min(pos.pixels + pos.viewportDimension * 0.8,
              pos.maxScrollExtent),
          duration: const Duration(milliseconds: 120),
          curve: Curves.linear,
        );
      }
      // Give the list (or a pending data load) a frame to build.
      await Future<void>.delayed(const Duration(milliseconds: 80));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reminder tapped while this screen is already on top.
    ref.listen<int?>(notificationHighlightProvider, (previous, next) {
      if (next != null) _revealItem(next);
    });

    final t = AppLocalizations.of(context);
    final groupedAsync = ref.watch(groupedItemsProvider);
    final allListsAsync = ref.watch(orderedListsProvider);
    final activeId = ref.watch(activeListIdProvider);
    final theme = Theme.of(context);
    final hasChecked = groupedAsync.valueOrNull?.groups
            .any((g) => g.items.any((i) => i.isChecked)) ??
        false;

    // Derive the title from the already-loaded lists (no async flash).
    final titleText = allListsAsync.whenData((lists) {
      final match = lists.where((l) => l.id == activeId);
      return match.isNotEmpty ? match.first.name : t.listTitleDefault;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText.valueOrNull ?? t.listTitleDefault),
        actions: [
          PopupMenuButton<String>(
            onSelected: (action) => _onMenuAction(context, ref, action),
            itemBuilder: (_) => [
              PopupMenuItem(value: 'rename', child: Text(t.listMenuRename)),
              PopupMenuItem(
                  value: 'duplicate', child: Text(t.listMenuDuplicate)),
              PopupMenuItem(
                  value: 'clear_all', child: Text(t.listMenuClearAll)),
              PopupMenuItem(value: 'delete', child: Text(t.listMenuDelete)),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // -----------------------------------------------------------------
            // List switcher strip (only visible when ≥ 2 lists exist)
            // -----------------------------------------------------------------
            allListsAsync.when(
              data: (lists) {
                if (lists.length <= 1) return const SizedBox.shrink();
                final idx = lists.indexWhere((l) => l.id == activeId);
                return _ListSwitcher(
                  lists: lists,
                  currentIndex: max(0, idx),
                  onSwitch: (list) =>
                      ref.read(activeListIdProvider.notifier).setActive(list.id),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            // -----------------------------------------------------------------
            // List content
            // -----------------------------------------------------------------
            Expanded(
              child: Stack(
                children: [
                  _buildListContent(context, ref, t, theme, groupedAsync),
                  // Contextual end-of-shopping-trip action: only visible
                  // while the list has completed items.
                  if (hasChecked)
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: FloatingActionButton.extended(
                        heroTag: 'clear_completed_fab',
                        backgroundColor:
                            theme.colorScheme.secondaryContainer,
                        foregroundColor:
                            theme.colorScheme.onSecondaryContainer,
                        elevation: 1,
                        icon: const Icon(Icons.remove_done, size: 20),
                        label: Text(t.listMenuClearCompleted),
                        onPressed: () {
                          HapticFeedback.selectionClick();
                          _confirmClearCompleted(context, ref);
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddModal(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListContent(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations t,
    ThemeData theme,
    AsyncValue<GroupedItems> groupedAsync,
  ) {
    final activeId = ref.watch(activeListIdProvider);
    return groupedAsync.when(
                data: (grouped) {
                  if (grouped.groups.isEmpty) {
                    return _EmptyList(theme: theme);
                  }
                  final showSwipeHint = activeId != null &&
                      !ref
                          .watch(swipeDeleteLearnedProvider)
                          .contains(activeId) &&
                      grouped.groups
                          .any((g) => g.items.any((i) => !i.isChecked));
                  return ListView.builder(
                    controller: _scrollController,
                    // Keep the last rows clear of the bottom action buttons.
                    // The FABs grow with the system font, so scale the
                    // reserved space with it too.
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.textScalerOf(context)
                                .scale(56) +
                            40),
                    itemCount: grouped.groups.length + 1,
                    itemBuilder: (context, gi) {
                      // Trailing row: subtle one-time swipe-to-delete hint.
                      if (gi == grouped.groups.length) {
                        if (!showSwipeHint) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.swipe_left_outlined,
                                  size: 16,
                                  color: theme.colorScheme.outline),
                              const SizedBox(width: 6),
                              // Flexible so the hint wraps instead of
                              // overflowing at enlarged font sizes.
                              Flexible(
                                child: Text(
                                  t.listSwipeDeleteHint,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.outline),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      final group = grouped.groups[gi];
                      final isCheckedGroup =
                          group.items.isNotEmpty && group.items.first.isChecked;

                      final headerText = isCheckedGroup
                          ? t.listCheckedSection
                          : (group.category != null
                              ? CategoryLocalizer.translate(
                                  group.category!.name, t)
                              : t.catOther);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category header (compact, secondary)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 2),
                            child: Text(
                              headerText.toUpperCase(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: isCheckedGroup
                                    ? theme.colorScheme.outline
                                    : theme.colorScheme.primary,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          if (isCheckedGroup)
                            Divider(color: theme.colorScheme.outlineVariant),
                          // Items — unchecked groups reorder by long-press drag
                          if (isCheckedGroup)
                            ...group.items.map((item) => _ItemTile(
                                  key: _tileKeyFor(item.id),
                                  item: item,
                                ))
                          else
                            ReorderableListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              buildDefaultDragHandles: false,
                              itemCount: group.items.length,
                              onReorderItem: (oldIndex, newIndex) {
                                final ids = group.items
                                    .map((i) => i.id)
                                    .toList();
                                final moved = ids.removeAt(oldIndex);
                                ids.insert(newIndex, moved);
                                HapticFeedback.mediumImpact();
                                ref
                                    .read(shoppingItemRepoProvider)
                                    .updatePositions(ids);
                              },
                              itemBuilder: (context, i) {
                                final item = group.items[i];
                                return ReorderableDelayedDragStartListener(
                                  key: ValueKey(item.id),
                                  index: i,
                                  child: _ItemTile(
                                    key: _tileKeyFor(item.id),
                                    item: item,
                                  ),
                                );
                              },
                            ),
                        ],
                      );
                    },
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              );
  }

  // -------------------------------------------------------------------------
  // Menu actions
  // -------------------------------------------------------------------------

  void _onMenuAction(BuildContext context, WidgetRef ref, String action) {
    switch (action) {
      case 'rename':
        _showRenameDialog(context, ref);
        break;
      case 'duplicate':
        _duplicateList(context, ref);
        break;
      case 'clear_all':
        _confirmClearWholeList(context, ref);
        break;
      case 'delete':
        _deleteList(context, ref);
        break;
    }
  }

  void _showRenameDialog(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final ctrl = TextEditingController();
    final listId = ref.read(activeListIdProvider);
    if (listId == null) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.listRenameDialogTitle),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: InputDecoration(hintText: t.listRenameHint),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t.commonCancel),
          ),
          FilledButton(
            onPressed: () async {
              if (ctrl.text.trim().isNotEmpty) {
                await ref
                    .read(shoppingListRepoProvider)
                    .rename(listId, ctrl.text);
                if (ctx.mounted) Navigator.pop(ctx);
                ref.invalidate(activeListMetaProvider);
              }
            },
            child: Text(t.commonRename),
          ),
        ],
      ),
    );
  }

  Future<void> _duplicateList(BuildContext context, WidgetRef ref) async {
    final t = AppLocalizations.of(context);
    final listId = ref.read(activeListIdProvider);
    if (listId == null) return;

    final newId =
        await ref.read(shoppingListRepoProvider).duplicate(listId);
    await ref.read(activeListIdProvider.notifier).onListCreated(newId);

    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.listDuplicatedSnackBar)));
    }
  }

  /// Shared destructive-action confirmation. Cancel, Android back, and
  /// tapping outside all dismiss without running [onConfirm].
  Future<void> _confirmDestructive(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    required Future<void> Function() onConfirm,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        // Scrollable so long localized text never clips at large fonts.
        content: SingleChildScrollView(child: Text(message)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(AppLocalizations.of(ctx).commonCancel)),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
              foregroundColor: Theme.of(ctx).colorScheme.onError,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    if (confirmed == true) await onConfirm();
  }

  /// Empties the list after explicit confirmation. The list itself, its
  /// name, and all learned history are kept. No-op on an empty list.
  Future<void> _confirmClearWholeList(
      BuildContext context, WidgetRef ref) async {
    final t = AppLocalizations.of(context);
    final listId = ref.read(activeListIdProvider);
    if (listId == null) return;

    // Preserve existing empty-list behavior: nothing to clear, no dialog.
    final items =
        await ref.read(shoppingItemRepoProvider).getByList(listId);
    if (items.isEmpty) return;

    if (!context.mounted) return;
    await _confirmDestructive(
      context,
      title: t.listClearAllDialogTitle,
      message: t.listClearAllDialogMessage,
      confirmLabel: t.listClearAllConfirm,
      onConfirm: () =>
          ref.read(shoppingItemRepoProvider).clearList(listId),
    );
  }

  /// Removes completed items after explicit confirmation (bottom-left
  /// button; only visible when completed items exist).
  Future<void> _confirmClearCompleted(
      BuildContext context, WidgetRef ref) async {
    final t = AppLocalizations.of(context);
    final listId = ref.read(activeListIdProvider);
    if (listId == null) return;

    await _confirmDestructive(
      context,
      title: t.listClearCompletedDialogTitle,
      message: t.listClearCompletedDialogMessage,
      confirmLabel: t.listMenuClearCompleted,
      onConfirm: () async {
        await ref.read(shoppingItemRepoProvider).clearChecked(listId);
      },
    );
  }

  Future<void> _deleteList(BuildContext context, WidgetRef ref) async {
    final t = AppLocalizations.of(context);
    final listId = ref.read(activeListIdProvider);
    if (listId == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.listDeleteDialogTitle),
        content: SingleChildScrollView(child: Text(t.listDeleteMessage)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(t.commonCancel)),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
              foregroundColor: Theme.of(ctx).colorScheme.onError,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.commonDelete),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    await ref.read(shoppingListRepoProvider).deleteList(listId);
    await ref.read(activeListIdProvider.notifier).onListDeleted(listId);

    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.listDeletedSnackBar)));
    }
  }

  // -------------------------------------------------------------------------
  // Quick add modal (bottom sheet with autocomplete)
  // -------------------------------------------------------------------------

  void _showAddModal(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final listId = ref.read(activeListIdProvider);
    if (listId == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom +
              MediaQuery.of(ctx).padding.bottom +
              24,
        ),
        child: ItemAutocompleteField(
          hintText: t.listQuickAddHint,
          submitLabel: t.homeAddButton,
          onSubmit: (text) async {
            final itemRepo = ref.read(shoppingItemRepoProvider);
            final catService = ref.read(categoryAssignmentProvider);
            final normalizer = ref.read(normalizationServiceProvider);
            for (final name in normalizer.splitMulti(text)) {
              final catId =
                  await catService.assignCategory(normalizer.normalize(name));
              await itemRepo.addItem(
                listId: listId,
                name: name,
                categoryId: catId,
              );
            }
            if (ctx.mounted) Navigator.pop(ctx);
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// List switcher — dots + arrows, supports horizontal swipe
// ---------------------------------------------------------------------------

class _ListSwitcher extends StatelessWidget {
  final List<ShoppingList> lists;
  final int currentIndex;
  final void Function(ShoppingList) onSwitch;

  const _ListSwitcher({
    required this.lists,
    required this.currentIndex,
    required this.onSwitch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasPrev = currentIndex > 0;
    final hasNext = currentIndex < lists.length - 1;

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity == null) return;
        if (details.primaryVelocity! < -200 && hasNext) {
          onSwitch(lists[currentIndex + 1]);
        } else if (details.primaryVelocity! > 200 && hasPrev) {
          onSwitch(lists[currentIndex - 1]);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.colorScheme.outlineVariant,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, size: 22),
              onPressed:
                  hasPrev ? () => onSwitch(lists[currentIndex - 1]) : null,
              visualDensity: VisualDensity.compact,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(lists.length, (i) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == currentIndex
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outlineVariant,
                    ),
                  );
                }),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right, size: 22),
              onPressed:
                  hasNext ? () => onSwitch(lists[currentIndex + 1]) : null,
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Item tile — checkbox, name, quantity badge, swipe-to-delete, tap-to-edit
// ---------------------------------------------------------------------------

class _ItemTile extends ConsumerWidget {
  final ShoppingListItem item;
  const _ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(shoppingItemRepoProvider);
    final historyRepo = ref.read(itemHistoryRepoProvider);
    final theme = Theme.of(context);
    final isFavorite = ref
            .watch(favoriteNamesProvider)
            .valueOrNull
            ?.contains(item.normalizedName) ??
        false;
    final isHighlighted =
        ref.watch(notificationHighlightProvider) == item.id;

    return Dismissible(
      key: ValueKey('dismiss_${item.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: theme.colorScheme.errorContainer,
        child: Icon(Icons.delete_outline,
            color: theme.colorScheme.onErrorContainer, size: 26),
      ),
      onDismissed: (_) {
        final t = AppLocalizations.of(context);
        final messenger = ScaffoldMessenger.of(context);
        HapticFeedback.mediumImpact();
        ref
            .read(swipeDeleteLearnedProvider.notifier)
            .markLearned(item.listId);
        repo.deleteItem(item.id);
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(
          SnackBar(
            content: Text(t.itemDeletedSnackBar),
            duration: const Duration(seconds: 4),
            // Newer Flutter keeps action snackbars on screen forever by
            // default; opt out so the Undo bar auto-dismisses.
            persist: false,
            action: SnackBarAction(
              label: t.commonUndo,
              onPressed: () => repo.restoreItem(item),
            ),
          ),
        );
      },
      child: _withHighlight(
          ref,
          theme,
          isHighlighted,
          ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: Checkbox(
          value: item.isChecked,
          onChanged: (_) {
            HapticFeedback.selectionClick();
            repo.toggleCheck(item.id);
          },
        ),
        title: Text(
          item.name,
          style: TextStyle(
            fontSize: 17,
            decoration:
                item.isChecked ? TextDecoration.lineThrough : null,
            color: item.isChecked ? theme.colorScheme.outline : null,
          ),
        ),
        subtitle: _buildSubtitle(context, theme),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_outline,
                size: 20,
                color: isFavorite
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline,
              ),
              onPressed: () async {
                HapticFeedback.selectionClick();
                final t = AppLocalizations.of(context);
                final messenger = ScaffoldMessenger.of(context);
                final nowPinned = await historyRepo
                    .toggleFavoriteByName(item.normalizedName);
                if (nowPinned == null) return;
                messenger.hideCurrentSnackBar();
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(nowPinned
                        ? t.itemPinnedSnackBar
                        : t.itemUnpinnedSnackBar),
                    duration: const Duration(seconds: 2),
                    persist: false,
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.edit_outlined,
                  size: 20, color: theme.colorScheme.outline),
              onPressed: () => _openEditModal(context, item),
            ),
          ],
        ),
        onTap: () {
          HapticFeedback.selectionClick();
          repo.toggleCheck(item.id);
        },
          )),
    );
  }

  /// Briefly tints the tile after a reminder-notification tap; the tint
  /// fades out and then clears the highlight state (one-shot, nothing is
  /// permanently changed on the item).
  Widget _withHighlight(
      WidgetRef ref, ThemeData theme, bool active, Widget child) {
    if (!active) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: const Duration(milliseconds: 2200),
      curve: Curves.easeOut,
      onEnd: () =>
          ref.read(notificationHighlightProvider.notifier).state = null,
      builder: (context, value, inner) => ColoredBox(
        color: theme.colorScheme.primaryContainer
            .withValues(alpha: 0.6 * value),
        child: inner,
      ),
      child: child,
    );
  }

  /// Secondary line(s) under the item name: quantity/unit plus the optional
  /// date, reminder, price, and location. Kept visually smaller than the
  /// name; wraps instead of clipping so enlarged fonts stay readable.
  Widget? _buildSubtitle(BuildContext context, ThemeData theme) {
    final hasQty = item.quantity != 1 || item.unit != null;
    final hasMeta =
        item.dueDate != null || item.price != null || item.location != null;
    if (!hasQty && !hasMeta) return null;

    final muted = theme.colorScheme.outline;
    final dateColor = item.isChecked
        ? muted
        : (isOverdue(item)
            ? theme.colorScheme.error
            : theme.colorScheme.primary);
    final metaStyle = theme.textTheme.bodySmall?.copyWith(color: muted);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasQty)
          Text(
            '${formatQuantity(item.quantity)}'
            '${item.unit != null ? ' ${item.unit}' : ''}',
            style: TextStyle(color: muted),
          ),
        if (hasMeta)
          Padding(
            padding: EdgeInsets.only(top: hasQty ? 2 : 0),
            child: Wrap(
              spacing: 12,
              runSpacing: 2,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (item.dueDate != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.event_outlined, size: 14, color: dateColor),
                      const SizedBox(width: 3),
                      Text(
                        formatDueDate(context, item),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: dateColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (item.reminderEnabled && !item.isChecked) ...[
                        const SizedBox(width: 3),
                        Icon(Icons.notifications_active_outlined,
                            size: 13, color: dateColor),
                        if (item.reminderRepeat != 'none') ...[
                          const SizedBox(width: 2),
                          Icon(Icons.repeat,
                              size: 13, color: dateColor),
                        ],
                      ],
                    ],
                  ),
                if (item.price != null)
                  Text(formatPrice(context, item.price!), style: metaStyle),
                if (item.location != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.place_outlined, size: 14, color: muted),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          item.location!,
                          style: metaStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
      ],
    );
  }

  void _openEditModal(BuildContext context, ShoppingListItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ItemEditModal(item: item),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty state
// ---------------------------------------------------------------------------

class _EmptyList extends StatelessWidget {
  final ThemeData theme;
  const _EmptyList({required this.theme});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Center(
      // Scrollable so the empty state never clips vertically when the
      // system font is strongly enlarged.
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_cart_outlined,
                size: 88, color: theme.colorScheme.outlineVariant),
            const SizedBox(height: 20),
            Text(t.listEmpty,
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: theme.colorScheme.outline)),
            const SizedBox(height: 8),
            Text(t.listEmptyHint,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.outline),
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: Text(t.listGoBack),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
