import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/vocabulary_screen.dart';
import '../screens/writing_practice_screen.dart';
import '../screens/grammar_screen.dart';
import '../screens/journal_screen.dart';
import '../widgets/app_shell.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          final idx = routeIndexFromPath(state.uri.path);
          return AppShell(routeIndex: idx, child: child);
        },
        routes: [
          GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
          GoRoute(path: '/vocab', builder: (_, __) => const VocabularyScreen()),
          GoRoute(path: '/grammar', builder: (_, __) => const GrammarScreen()),
          GoRoute(
              path: '/writing',
              builder: (_, __) => const WritingPracticeScreen()),
          GoRoute(
              path: '/journal',
              builder: (_, __) => const JournalScreen()),
        ],
      ),
    ],
  );
}
