import 'package:flutter/services.dart';

/// Haptic feedback service for French Pro interactions.
///
/// Maps to the app's physical-feeling vocabulary:
/// - journalThud → heavy impact (adding to journal)
/// - correctPop → light impact (correct quiz answer)
/// - wrongBuzz → medium impact (incorrect answer)
/// - streakRise → cascading vibrations (streak milestone)
class HapticService {
  HapticService._();
  static final HapticService instance = HapticService._();

  /// Satisfying "thud" when adding a word to Le Journal.
  void journalThud() => HapticFeedback.heavyImpact();

  /// Light "pop" for correct quiz answers.
  void correctPop() => HapticFeedback.lightImpact();

  /// Soft double-tap for incorrect answers.
  void wrongBuzz() {
    HapticFeedback.mediumImpact();
    Future.delayed(const Duration(milliseconds: 100), () {
      HapticFeedback.mediumImpact();
    });
  }

  /// Cascading vibration for streak milestones.
  void streakRise() {
    HapticFeedback.lightImpact();
    Future.delayed(const Duration(milliseconds: 80), () {
      HapticFeedback.mediumImpact();
    });
    Future.delayed(const Duration(milliseconds: 180), () {
      HapticFeedback.heavyImpact();
    });
  }

  /// Generic tap feedback.
  void tap() => HapticFeedback.selectionClick();
}
