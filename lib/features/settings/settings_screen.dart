import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';

import '../../providers/app_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.settingsTitle)),
      body: ListView(
        children: [
          // -------------------------------------------------------------------
          // Language picker
          // -------------------------------------------------------------------
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: Text(t.settingsLanguage),
            subtitle: Text(_languageLabel(locale, t)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguagePicker(context, ref),
          ),
          const Divider(),

          // -------------------------------------------------------------------
          // Theme picker (system / light / dark)
          // -------------------------------------------------------------------
          ListTile(
            leading: const Icon(Icons.brightness_6_outlined),
            title: Text(t.settingsTheme),
            subtitle: Text(_themeLabel(themeMode, t)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showThemePicker(context, ref),
          ),
          const Divider(),

          // -------------------------------------------------------------------
          // Backup: export / import
          // -------------------------------------------------------------------
          ListTile(
            leading: const Icon(Icons.upload_file_outlined),
            title: Text(t.settingsBackupExport),
            subtitle: Text(t.settingsBackupExportSubtitle),
            onTap: () => _exportBackup(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.download_outlined),
            title: Text(t.settingsBackupImport),
            subtitle: Text(t.settingsBackupImportSubtitle),
            onTap: () => _importBackup(context, ref),
          ),
          const Divider(),

          // -------------------------------------------------------------------
          // What's new in this version
          // -------------------------------------------------------------------
          ListTile(
            leading: const Icon(Icons.new_releases_outlined),
            title: Text(t.settingsWhatsNew),
            subtitle: Text(t.settingsWhatsNewSubtitle),
            onTap: () => _showWhatsNew(context),
          ),

          // -------------------------------------------------------------------
          // Help & tips
          // -------------------------------------------------------------------
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: Text(t.settingsHelp),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/help'),
          ),
          const Divider(),

          // -------------------------------------------------------------------
          // Clear all data
          // -------------------------------------------------------------------
          ListTile(
            leading: Icon(Icons.delete_forever_outlined,
                color: theme.colorScheme.error),
            title: Text(t.settingsClearData,
                style: TextStyle(color: theme.colorScheme.error)),
            subtitle: Text(t.settingsClearDataSubtitle),
            onTap: () => _confirmClear(context, ref),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Labels
  // -------------------------------------------------------------------------

  String _languageLabel(Locale? locale, AppLocalizations t) {
    if (locale == null) return t.settingsLanguageSystem;
    switch (locale.languageCode) {
      case 'hr':
        return t.settingsLanguageCroatian;
      case 'en':
        return t.settingsLanguageEnglish;
      default:
        return locale.languageCode;
    }
  }

  String _themeLabel(ThemeMode mode, AppLocalizations t) {
    switch (mode) {
      case ThemeMode.light:
        return t.settingsThemeLight;
      case ThemeMode.dark:
        return t.settingsThemeDark;
      case ThemeMode.system:
        return t.settingsThemeSystem;
    }
  }

  // -------------------------------------------------------------------------
  // What's new dialog
  // -------------------------------------------------------------------------
  void _showWhatsNew(BuildContext context) {
    final t = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.settingsWhatsNew),
        content: SingleChildScrollView(child: Text(t.whatsNewBody)),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(MaterialLocalizations.of(ctx).okButtonLabel),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Theme picker dialog
  // -------------------------------------------------------------------------
  void _showThemePicker(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final current = ref.read(themeModeProvider);

    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(t.settingsTheme),
        children: [
          for (final (mode, label) in [
            (ThemeMode.system, t.settingsThemeSystem),
            (ThemeMode.light, t.settingsThemeLight),
            (ThemeMode.dark, t.settingsThemeDark),
          ])
            _RadioOption(
              label: label,
              selected: current == mode,
              onSelect: () async {
                await ref.read(themeModeProvider.notifier).set(mode);
                if (ctx.mounted) Navigator.pop(ctx);
              },
            ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Language picker dialog
  // -------------------------------------------------------------------------
  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final currentLocale = ref.read(localeProvider);

    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(t.settingsLanguage),
        children: [
          for (final (locale, label) in [
            (null, t.settingsLanguageSystem),
            (const Locale('en'), t.settingsLanguageEnglish),
            (const Locale('hr'), t.settingsLanguageCroatian),
          ])
            _RadioOption(
              label: label,
              selected: currentLocale?.languageCode == locale?.languageCode,
              onSelect: () async {
                await ref.read(localeProvider.notifier).set(locale);
                if (ctx.mounted) Navigator.pop(ctx);
              },
            ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Backup export
  // -------------------------------------------------------------------------
  Future<void> _exportBackup(BuildContext context, WidgetRef ref) async {
    final t = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final json = await ref.read(backupServiceProvider).exportToJson();
    final now = DateTime.now();
    final stamp = '${now.year}'
        '-${now.month.toString().padLeft(2, '0')}'
        '-${now.day.toString().padLeft(2, '0')}';

    final savedPath = await FilePicker.saveFile(
      dialogTitle: t.settingsBackupExport,
      fileName: 'puffio_backup_$stamp.json',
      type: FileType.custom,
      allowedExtensions: ['json'],
      bytes: utf8.encode(json),
    );

    if (savedPath != null) {
      messenger.showSnackBar(
          SnackBar(content: Text(t.settingsExportedSnackBar)));
    }
  }

  // -------------------------------------------------------------------------
  // Backup import (replace-all, with confirmation)
  // -------------------------------------------------------------------------
  Future<void> _importBackup(BuildContext context, WidgetRef ref) async {
    final t = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;

    final file = result.files.single;
    final String content;
    try {
      content = file.bytes != null
          ? utf8.decode(file.bytes!)
          : await File(file.path!).readAsString();
    } catch (_) {
      messenger.showSnackBar(
          SnackBar(content: Text(t.settingsImportFailedSnackBar)));
      return;
    }

    if (!context.mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.settingsImportDialogTitle),
        content:
            SingleChildScrollView(child: Text(t.settingsImportDialogMessage)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(t.commonCancel)),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.commonImport),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await ref.read(backupServiceProvider).importFromJson(content);
    } on FormatException {
      messenger.showSnackBar(
          SnackBar(content: Text(t.settingsImportFailedSnackBar)));
      return;
    }

    // Re-seed categories if the backup had none, and refresh the active list.
    await ref.read(categoryRepoProvider).seedDefaults();
    await ref.read(activeListIdProvider.notifier).load();

    // Imported items got fresh ids — rebuild the reminder schedule so no
    // notification is lost or left pointing at a stale id.
    await ref.read(notificationServiceProvider).resyncAll();

    messenger
        .showSnackBar(SnackBar(content: Text(t.settingsImportedSnackBar)));
  }

  // -------------------------------------------------------------------------
  // Clear all
  // -------------------------------------------------------------------------
  Future<void> _confirmClear(BuildContext context, WidgetRef ref) async {
    final t = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.settingsClearDialogTitle),
        content:
            SingleChildScrollView(child: Text(t.settingsClearDialogMessage)),
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
            child: Text(t.commonClearAll),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    await ref.read(shoppingListRepoProvider).clearAll();
    // clearAll above also cancels every scheduled reminder.
    await ref.read(itemHistoryRepoProvider).clearAll();
    await ref.read(categoryRepoProvider).clearAll();
    await ref.read(settingsRepoProvider).clearAll();

    await ref.read(categoryRepoProvider).seedDefaults();
    await ref.read(themeModeProvider.notifier).set(ThemeMode.system);
    await ref.read(localeProvider.notifier).set(null);

    await ref
        .read(activeListIdProvider.notifier)
        .load(defaultName: t.homeDefaultListName);

    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.settingsClearedSnackBar)));
    }
  }
}

class _RadioOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelect;

  const _RadioOption({
    required this.label,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color:
            selected ? theme.colorScheme.primary : theme.colorScheme.outline,
      ),
      title: Text(label),
      onTap: onSelect,
    );
  }
}
