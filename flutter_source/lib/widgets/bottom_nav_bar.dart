import 'package:flutter/material.dart';
import '../theme/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.terracottaPrimary,
      unselectedItemColor: AppColors.textMuted,
      backgroundColor: Colors.white,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          activeIcon: Icon(Icons.menu_book),
          label: 'Dictionnaire',
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.terracottaPrimary,
            child: Icon(Icons.style, color: Colors.white, size: 20),
          ),
          label: 'Flashcards',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school_outlined),
          activeIcon: Icon(Icons.school),
          label: 'Grammaire',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_note_outlined),
          activeIcon: Icon(Icons.edit_note),
          label: 'Écriture',
        ),
      ],
    );
  }
}
