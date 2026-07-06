import 'package:flutter/material.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/shopping_list.dart';
import '../../providers/app_providers.dart';
import 'list_management_providers.dart';

class ListManagementScreen extends ConsumerWidget {
  const ListManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final listsAsync = ref.watch(allListsProvider);
    final activeId = ref.watch(activeListIdProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.listsTitle)),
      body: listsAsync.when(
        data: (lists) {
          if (lists.isEmpty) {
            return Center(child: Text(t.listsNone));
          }
          return ListView.separated(
            itemCount: lists.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final list = lists[i];
              final isActive = list.id == activeId;

              return ListTile(
                leading: Icon(
                  isActive
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: isActive
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outline,
                ),
                title: Text(
                  list.name,
                  style: TextStyle(
                    fontWeight:
                        isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                subtitle: Text(
                  isActive ? t.listsActive : t.listsSetActive,
                  style: TextStyle(
                    color: isActive
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline,
                  ),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (action) =>
                      _onAction(context, ref, list, action),
                  itemBuilder: (_) => [
                    if (!isActive)
                      PopupMenuItem(
                          value: 'activate',
                          child: Text(t.listsMenuActivate)),
                    PopupMenuItem(
                        value: 'rename', child: Text(t.listMenuRename)),
                    PopupMenuItem(
                        value: 'duplicate', child: Text(t.listMenuDuplicate)),
                    PopupMenuItem(
                        value: 'delete', child: Text(t.listMenuDelete)),
                  ],
                ),
                onTap: () async {
                  await ref
                      .read(activeListIdProvider.notifier)
                      .setActive(list.id);
                  if (context.mounted) Navigator.pop(context);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createList(context, ref),
        icon: const Icon(Icons.add),
        label: Text(t.listsFabNewList),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Actions
  // -------------------------------------------------------------------------

  void _onAction(
      BuildContext context, WidgetRef ref, ShoppingList list, String action) {
    switch (action) {
      case 'activate':
        ref.read(activeListIdProvider.notifier).setActive(list.id);
        break;
      case 'rename':
        _renameDialog(context, ref, list);
        break;
      case 'duplicate':
        _duplicate(context, ref, list);
        break;
      case 'delete':
        _delete(context, ref, list);
        break;
    }
  }

  void _createList(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.listsNewListDialogTitle),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: InputDecoration(hintText: t.listsNewListHint),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(t.commonCancel)),
          FilledButton(
            onPressed: () async {
              var name = ctrl.text.trim();
              if (name.isEmpty) {
                // Empty input → auto-generate a unique localized name.
                name = await ref
                    .read(shoppingListRepoProvider)
                    .generateUniqueName(t.homeDefaultListName);
              }
              final id =
                  await ref.read(shoppingListRepoProvider).createList(name);
              await ref
                  .read(activeListIdProvider.notifier)
                  .onListCreated(id);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: Text(t.listsCreateButton),
          ),
        ],
      ),
    );
  }

  void _renameDialog(
      BuildContext context, WidgetRef ref, ShoppingList list) {
    final t = AppLocalizations.of(context);
    final ctrl = TextEditingController(text: list.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.listRenameDialogTitle),
        content: TextField(controller: ctrl, autofocus: true),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(t.commonCancel)),
          FilledButton(
            onPressed: () async {
              if (ctrl.text.trim().isNotEmpty) {
                await ref
                    .read(shoppingListRepoProvider)
                    .rename(list.id, ctrl.text);
                if (ctx.mounted) Navigator.pop(ctx);
              }
            },
            child: Text(t.commonRename),
          ),
        ],
      ),
    );
  }

  Future<void> _duplicate(
      BuildContext context, WidgetRef ref, ShoppingList list) async {
    final t = AppLocalizations.of(context);
    await ref.read(shoppingListRepoProvider).duplicate(list.id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.listsDuplicatedSnackBar(list.name))));
    }
  }

  Future<void> _delete(
      BuildContext context, WidgetRef ref, ShoppingList list) async {
    final t = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.listsDeleteDialogTitle(list.name)),
        content: Text(t.listsDeleteMessage),
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

    await ref.read(shoppingListRepoProvider).deleteList(list.id);
    await ref.read(activeListIdProvider.notifier).onListDeleted(list.id);
  }
}
