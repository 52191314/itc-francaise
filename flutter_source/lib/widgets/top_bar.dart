import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final int count;
  final int total;
  final VoidCallback? onToggleFlashcards;
  final VoidCallback? onOpenDrawer;

  const TopBar({
    super.key,
    required this.count,
    required this.total,
    this.onToggleFlashcards,
    this.onOpenDrawer,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.bgApp,
      elevation: 0,
      leading: IconButton(
        key: const Key('drawer_menu_btn'),
        icon: const Icon(Icons.menu, color: AppColors.textPrimary),
        onPressed: onOpenDrawer ?? () => Scaffold.of(context).openDrawer(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Le Lexique',
            style: AppTypography.headerTitle,
          ),
          Text(
            'Dictionnaire Français A1-B1',
            style: AppTypography.subtitle.copyWith(fontSize: 12),
          ),
        ],
      ),
      actions: [
        // Progress counter badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.badgeLevelBg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            '$count / $total',
            style: const TextStyle(
              color: AppColors.badgeLevelText,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Flashcard mode toggle button
        IconButton(
          key: const Key('flashcard_toggle_btn'),
          icon: const Icon(Icons.style, color: AppColors.terracottaPrimary),
          onPressed: onToggleFlashcards,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
