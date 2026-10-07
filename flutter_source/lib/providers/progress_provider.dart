import 'package:flutter/material.dart';
import '../models/session.dart';
import '../services/db_service.dart';

class ProgressProvider extends ChangeNotifier {
  Map<String, dynamic> stats = {};
  List<StudySession> sessions = [];

  Future<void> load() async {
    stats    = await DbService.instance.getSessionStats();
    sessions = await DbService.instance.getSessions();
    notifyListeners();
  }
}
