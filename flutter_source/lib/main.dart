import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/app_theme.dart';
import 'router/app_router.dart';
import 'providers/theme_provider.dart';
import 'providers/vocab_provider.dart';
import 'providers/journal_provider.dart';
import 'services/tts_service.dart';
import 'services/sync_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init TTS
  await TtsService.instance.init();

  // Pre-load Google Fonts to avoid layout jank
  await GoogleFonts.pendingFonts([
    GoogleFonts.playfairDisplay(),
    GoogleFonts.inter(),
    GoogleFonts.jetBrainsMono(),
  ]);

  // Load prefs
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs)),
        ChangeNotifierProvider(create: (_) => VocabProvider()),
        ChangeNotifierProvider(create: (_) {
          final jp = JournalProvider();
          jp.init(prefs);
          return jp;
        }),
      ],
      child: const FrenchProApp(),
    ),
  );
}

class FrenchProApp extends StatefulWidget {
  const FrenchProApp({super.key});

  @override
  State<FrenchProApp> createState() => _FrenchProAppState();
}

class _FrenchProAppState extends State<FrenchProApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SyncService.instance.checkForUpdates(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp.router(
      title: 'FrenchPro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      routerConfig: AppRouter.router,
    );
  }
}
