import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  TtsService._();
  static final TtsService instance = TtsService._();

  final FlutterTts _tts = FlutterTts();
  bool _ready = false;

  Future<void> init() async {
    try {
      // Basic initialization parameters
      await _tts.setLanguage('fr-FR');
      await _tts.setSpeechRate(0.85); // slightly slower for learning
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);
      _ready = true;

      // Asynchronously select the best French voice
      _selectBestFrenchVoice();
    } catch (e) {
      debugPrint('TTS init error: $e');
      _ready = false;
    }
  }

  /// Selects the best French voice from available system voices to prevent English accent fallbacks.
  Future<void> _selectBestFrenchVoice() async {
    try {
      List<dynamic>? voices = await _tts.getVoices;
      
      // On web, voices load asynchronously and might be empty at first. Retry once after a delay.
      if (voices == null || voices.isEmpty) {
        await Future.delayed(const Duration(milliseconds: 500));
        voices = await _tts.getVoices;
      }

      if (voices != null && voices.isNotEmpty) {
        // Filter for French voices (e.g. fr-FR, fr-CA, fr-CH)
        final frenchVoices = voices.where((voice) {
          if (voice is Map) {
            final locale = voice['locale']?.toString().toLowerCase() ?? '';
            return locale.startsWith('fr');
          }
          return false;
        }).toList();

        if (frenchVoices.isNotEmpty) {
          // Prioritize fr-FR specifically, fallback to first available French voice
          var selectedVoice = frenchVoices.firstWhere(
            (v) => v['locale']?.toString().toLowerCase() == 'fr-fr',
            orElse: () => frenchVoices.first,
          );

          await _tts.setVoice(Map<String, String>.from(selectedVoice as Map));
          debugPrint('TTS: Selected French voice: ${selectedVoice['name']} (${selectedVoice['locale']})');
        } else {
          debugPrint('TTS: No French voice package found on device.');
        }
      } else {
        debugPrint('TTS: No available voices returned by TTS engine.');
      }
    } catch (e) {
      debugPrint('TTS: Error selecting French voice: $e');
    }
  }

  /// Set the speech rate dynamically.
  Future<void> setRate(double rate) async {
    if (!_ready) return;
    try {
      await _tts.setSpeechRate(rate);
    } catch (e) {
      debugPrint('TTS: Error setting rate: $e');
    }
  }

  /// Speak a French phrase.
  Future<void> speak(String text) async {
    if (!_ready || text.isEmpty) return;
    try {
      await _tts.stop();
      await _tts.speak(text);
    } catch (_) {
      _ready = false;
    }
  }

  /// Stop current speech.
  Future<void> stop() async {
    if (!_ready) return;
    try {
      await _tts.stop();
    } catch (_) {
      _ready = false;
    }
  }

  /// Check if a French TTS voice is available on the device.
  Future<bool> isFrenchAvailable() async {
    if (!_ready) return false;
    try {
      final langs = await _tts.getLanguages as List?;
      if (langs == null) return false;
      return langs.any((l) => l.toString().startsWith('fr'));
    } catch (_) {
      return false;
    }
  }
}
