import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;
  String _lastSpokenText = '';
  String _language = 'fr-FR';

  bool get isSpeaking => _isSpeaking;
  String get lastSpokenText => _lastSpokenText;
  String get language => _language;

  TTSService() {
    _initTts();
  }

  Future<void> _initTts() async {
    try {
      await _flutterTts.setLanguage(_language);
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);

      _flutterTts.setStartHandler(() {
        _isSpeaking = true;
      });

      _flutterTts.setCompletionHandler(() {
        _isSpeaking = false;
      });

      _flutterTts.setErrorHandler((msg) {
        _isSpeaking = false;
        if (kDebugMode) print("TTS Error: $msg");
      });
    } catch (e) {
      if (kDebugMode) print("TTS init error: $e");
    }
  }

  Future<void> speak(String text) async {
    if (text.trim().isEmpty) return;
    _lastSpokenText = text;
    try {
      _isSpeaking = true;
      await _flutterTts.stop();
      await _flutterTts.speak(text);
    } catch (e) {
      _isSpeaking = false;
      if (kDebugMode) print("TTS Speak error: $e");
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
      _isSpeaking = false;
    } catch (e) {
      if (kDebugMode) print("TTS Stop error: $e");
    }
  }

  void setLanguage(String lang) {
    _language = lang;
    _flutterTts.setLanguage(lang).catchError((e) {
      if (kDebugMode) print("TTS setLanguage error: $e");
    });
  }
}
