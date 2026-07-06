import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shop_list_pro/l10n/app_localizations.dart';

import '../data/models/shopping_list_item.dart';
import '../features/home/home_screen.dart';
import '../features/list_management/list_management_screen.dart';
import '../features/help/help_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/shopping_list/shopping_list_providers.dart';
import '../features/shopping_list/shopping_list_screen.dart';
import '../providers/app_providers.dart';
import 'theme.dart';

class ShopListProApp extends ConsumerStatefulWidget {
  const ShopListProApp({super.key});

  @override
  ConsumerState<ShopListProApp> createState() => _ShopListProAppState();
}

class _ShopListProAppState extends ConsumerState<ShopListProApp> {
  final _navKey = GlobalKey<NavigatorState>();
  StreamSubscription<Uri?>? _widgetClickSub;

  @override
  void initState() {
    super.initState();

    // Widget tapped while the app was closed (cold start).
    HomeWidget.initiallyLaunchedFromHomeWidget().then((uri) {
      if (uri != null) _openActiveList();
    });

    // Widget tapped while the app is running / in background (warm resume).
    _widgetClickSub = HomeWidget.widgetClicked.listen((uri) {
      if (uri != null) _openActiveList();
    });
  }

  @override
  void dispose() {
    _widgetClickSub?.cancel();
    super.dispose();
  }

  /// Open the shopping-list screen with Home beneath it on the back stack.
  /// Idempotent: repeated calls always end with exactly Home → List.
  void _openActiveList() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nav = _navKey.currentState;
      if (nav == null) return;
      nav.popUntil((route) => route.isFirst);
      nav.pushNamed('/list');
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider); // null = follow system

    // Push a fresh widget snapshot on startup (initial stream emission)
    // and whenever the active list's items change.
    ref.listen<AsyncValue<List<ShoppingListItem>>>(
      activeListItemsProvider,
      (_, next) {
        next.whenData((_) {
          ref.read(widgetSyncServiceProvider).sync();
        });
      },
    );

    return MaterialApp(
      navigatorKey: _navKey,
      onGenerateTitle: (ctx) => AppLocalizations.of(ctx).appTitle,
      debugShowCheckedModeBanner: false,

      // Localization
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // Routes
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/list': (_) => const ShoppingListScreen(),
        '/lists': (_) => const ListManagementScreen(),
        '/settings': (_) => const SettingsScreen(),
        '/help': (_) => const HelpScreen(),
      },
    );
  }
}
