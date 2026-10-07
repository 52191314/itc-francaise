import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/vocabulary_screen.dart';
import '../screens/flashcard_screen.dart';
import '../screens/quiz_screen.dart';
import '../screens/roleplay_screen.dart';
import '../screens/progress_screen.dart';
import '../screens/writing_practice_screen.dart';
import '../screens/grammar_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/vocab', builder: (_, __) => const VocabularyScreen()),
      GoRoute(path: '/flash', builder: (_, __) => const FlashcardScreen()),
      GoRoute(path: '/quiz', builder: (_, __) => const QuizScreen()),
      GoRoute(path: '/roleplay', builder: (_, __) => const RoleplayScreen()),
      GoRoute(path: '/grammar', builder: (_, __) => const GrammarScreen()),
      GoRoute(
          path: '/writing', builder: (_, __) => const WritingPracticeScreen()),
      GoRoute(path: '/progress', builder: (_, __) => const ProgressScreen()),
    ],
  );
}
