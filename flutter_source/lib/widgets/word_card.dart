import 'package:flutter/material.dart';
import '../models/word_entry.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

class WordCard extends StatefulWidget {
  final WordEntry word;
  final VoidCallback? onPlayTts;
  final VoidCallback? onToggleBookmark;
  final bool isBookmarked;

  const WordCard({
    super.key,
    required this.word,
    this.onPlayTts,
    this.onToggleBookmark,
    this.isBookmarked = false,
  });

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  late bool _bookmarked;

  @override
  void initState() {
    super.initState();
    _bookmarked = widget.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      color: AppColors.bgCard,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      // Circular TTS Audio Button
                      Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: AppColors.badgeCatBg,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          key: Key('tts_btn_${widget.word.id}'),
                          icon: const Icon(Icons.volume_up, color: AppColors.terracottaSecondary),
                          onPressed: widget.onPlayTts,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // French Headword
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.word.french,
                              style: AppTypography.headword,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (widget.word.ipa.isNotEmpty)
                              Text(
                                widget.word.ipa,
                                style: const TextStyle(
                                  color: AppColors.textMuted,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Bookmark Icon
                IconButton(
                  key: Key('bookmark_btn_${widget.word.id}'),
                  icon: Icon(
                    _bookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: AppColors.bookmarkTeal,
                  ),
                  onPressed: () {
                    setState(() {
                      _bookmarked = !_bookmarked;
                    });
                    if (widget.onToggleBookmark != null) {
                      widget.onToggleBookmark!();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Badges: CEFR level + Category topic
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.badgeLevelBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.word.level,
                    style: const TextStyle(
                      color: AppColors.badgeLevelText,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.badgeCatBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.category, size: 12, color: AppColors.badgeCatIcon),
                      const SizedBox(width: 4),
                      Text(
                        widget.word.category,
                        style: const TextStyle(
                          color: AppColors.terracottaSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Translation & Example
            Text(
              widget.word.english,
              style: AppTypography.body,
            ),
            if (widget.word.example.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                widget.word.example,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: AppColors.textMuted,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
