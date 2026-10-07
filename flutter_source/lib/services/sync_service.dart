import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Checks a remote manifest for newer vocabulary/quiz data and notifies the user.
///
/// Pass a URL at build time with:
///   --dart-define=FRENCH_PRO_MANIFEST_URL=https://example.com/manifest.json
/// If no URL is provided, sync is disabled.
class SyncService {
  SyncService._();
  static final SyncService instance = SyncService._();

  static const _manifestUrl = String.fromEnvironment('FRENCH_PRO_MANIFEST_URL');
  static const _lastCheckKey  = 'sync_last_check';
  static const _dataVersionKey = 'data_version';

  Future<void> checkForUpdates(BuildContext context) async {
    if (_manifestUrl.isEmpty) return;

    // Only check once per day
    final prefs = await SharedPreferences.getInstance();
    final lastCheck = prefs.getString(_lastCheckKey);
    final now = DateTime.now().toIso8601String().substring(0, 10);
    if (lastCheck == now) return;

    try {
      final response = await http
          .get(Uri.parse(_manifestUrl))
          .timeout(const Duration(seconds: 6));

      if (response.statusCode != 200) return;

      final manifest = json.decode(response.body) as Map<String, dynamic>;
      final remoteVersion = manifest['version'] as String?;
      final localVersion  = prefs.getString(_dataVersionKey) ?? '0';

      if (remoteVersion != null && remoteVersion != localVersion) {
        // New data available
        await prefs.setString(_dataVersionKey, remoteVersion);
        if (context.mounted) {
          _showUpdateSnackbar(context, remoteVersion);
        }
      }

      await prefs.setString(_lastCheckKey, now);
    } catch (_) {
      // Silently fail — offline or server unreachable
    }
  }

  void _showUpdateSnackbar(BuildContext context, String version) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✨ New content available (v$version)! Restart to apply.'),
        backgroundColor: const Color(0xFF22D3A7),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
