import 'package:flutter/material.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';

/// Lightweight, fully offline help screen. Content mirrors actual app
/// behavior — update it when features change.
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final topics = <(IconData, String, String)>[
      (Icons.auto_awesome_outlined, t.helpSuggestionsTitle, t.helpSuggestionsBody),
      (Icons.push_pin_outlined, t.helpPinnedTitle, t.helpPinnedBody),
      (Icons.swipe_left_outlined, t.helpSwipeTitle, t.helpSwipeBody),
      (Icons.straighten_outlined, t.helpUnitsTitle, t.helpUnitsBody),
      (Icons.category_outlined, t.helpCategoriesTitle, t.helpCategoriesBody),
      (Icons.view_agenda_outlined, t.helpListsTitle, t.helpListsBody),
      (Icons.playlist_add_outlined, t.helpQuickListTitle, t.helpQuickListBody),
      (Icons.save_alt_outlined, t.helpBackupTitle, t.helpBackupBody),
    ];

    // Giving ListView an explicit padding discards the safe-area insets it
    // would otherwise absorb automatically — so add the device's bottom
    // inset (gesture bar / 3-button nav) back in dynamically.
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      appBar: AppBar(title: Text(t.settingsHelp)),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 24 + bottomInset),
        children: [
          Text(
            t.helpIntro,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          for (final (icon, title, body) in topics)
            _HelpTopic(icon: icon, title: title, body: body),
          const SizedBox(height: 16),
          // Offline / privacy note
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.cloud_off_outlined,
                    size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    t.helpOfflineNote,
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant),
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

class _HelpTopic extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _HelpTopic({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: theme.colorScheme.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.35,
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
