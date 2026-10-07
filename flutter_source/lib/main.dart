import 'package:flutter/material.dart';
import 'services/data_service.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/dictionary_screen.dart';
import 'screens/flashcards_screen.dart';
import 'screens/grammar_screen.dart';
import 'screens/writing_screen.dart';
import 'widgets/bottom_nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FrenchDictApp());
}

class FrenchDictApp extends StatelessWidget {
  final DataService? dataService;

  const FrenchDictApp({super.key, this.dataService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Le Lexique',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: MainNavigationHolder(dataService: dataService),
    );
  }
}

class MainNavigationHolder extends StatefulWidget {
  final DataService? dataService;

  const MainNavigationHolder({super.key, this.dataService});

  @override
  State<MainNavigationHolder> createState() => _MainNavigationHolderState();
}

class _MainNavigationHolderState extends State<MainNavigationHolder> {
  late DataService _dataService;
  bool _isLoading = true;
  int _currentIndex = 1; // Default to Dictionary view

  @override
  void initState() {
    super.initState();
    if (widget.dataService != null && widget.dataService!.isLoaded) {
      _dataService = widget.dataService!;
      _isLoading = false;
    } else {
      _dataService = widget.dataService ?? DataService();
      _initApp();
    }
  }

  Future<void> _initApp() async {
    await _dataService.loadData();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(height: 16),
              Text(
                'Chargement de Le Lexique...',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      );
    }

    final List<Widget> screens = [
      HomeScreen(dataService: _dataService),
      DictionaryScreen(dataService: _dataService),
      FlashcardsScreen(dataService: _dataService),
      GrammarScreen(dataService: _dataService),
      WritingScreen(dataService: _dataService),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
