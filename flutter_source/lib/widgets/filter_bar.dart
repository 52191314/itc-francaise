import 'package:flutter/material.dart';

import '../models/filter_state.dart';
import '../theme/app_theme.dart';

/// A 56px collapsible bar below the search pill showing active
/// filters as small terracotta chips. Tapping opens the filter overlay.
class FilterBar extends StatelessWidget {
  final FilterState filter;
  final bool isDark;
  final int totalCount;
  final int filteredCount;
  final VoidCallback onTap;

  const FilterBar({
    super.key,
    required this.filter,
    required this.isDark,
    required this.totalCount,
    required this.filteredCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final labels = filter.activeFilterLabels;
    final hasFilters = labels.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF14161C)
              : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          border: Border.all(
            color: hasFilters
                ? AppTheme.terracotta.withValues(alpha: 0.2)
                : (isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.black.withValues(alpha: 0.05)),
          ),
        ),
        child: Row(
          children: [
            // Filter icon
            Icon(
              Icons.filter_list_rounded,
              size: 16,
              color: hasFilters
                  ? AppTheme.terracotta
                  : (isDark ? AppTheme.mutedGrey : AppTheme.warmGrey),
            ),
            const SizedBox(width: 8),

            // Count + active filter chips
            Expanded(
              child: hasFilters
                  ? ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...labels.map((label) => Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppTheme.terracotta
                                      .withValues(alpha: 0.1),
                                  borderRadius:
                                      BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      label,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.terracotta,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    )
                  : Text(
                      'All words  ·  $totalCount',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppTheme.mutedGrey
                            : AppTheme.warmGrey,
                      ),
                    ),
            ),

            // Result count
            if (hasFilters)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.terracotta.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$filteredCount',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.terracotta,
                  ),
                ),
              ),

            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right_rounded,
              size: 16,
              color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
            ),
          ],
        ),
      ),
    );
  }
}
