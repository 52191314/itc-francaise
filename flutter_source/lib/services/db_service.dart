import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/session.dart';

class DbService {
  DbService._();
  static final DbService instance = DbService._();

  Database? _db;
  final List<StudySession> _memorySessions = [];
  final Map<String, WordStat> _memoryWordStats = {};

  Future<void> init() async {
    if (kIsWeb) return;

    final dbPath = await getDatabasesPath();
    _db = await openDatabase(
      join(dbPath, 'french_pro.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE sessions (
        id         INTEGER PRIMARY KEY AUTOINCREMENT,
        type       TEXT NOT NULL,
        level      TEXT NOT NULL,
        total      INTEGER NOT NULL,
        correct    INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE word_stats (
        word_fr  TEXT PRIMARY KEY,
        seen     INTEGER NOT NULL DEFAULT 0,
        correct  INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  Database get _database {
    assert(_db != null, 'DbService not initialized. Call init() first.');
    return _db!;
  }

  // ── Sessions ────────────────────────────────────────────────
  Future<int> insertSession(StudySession session) async {
    if (kIsWeb) {
      _memorySessions.insert(0, session);
      return _memorySessions.length;
    }
    return _database.insert('sessions', session.toMap());
  }

  Future<List<StudySession>> getSessions({int limit = 50}) async {
    if (kIsWeb) {
      return _memorySessions.take(limit).toList();
    }

    final maps = await _database.query(
      'sessions',
      orderBy: 'created_at DESC',
      limit: limit,
    );
    return maps.map(StudySession.fromMap).toList();
  }

  Future<Map<String, dynamic>> getSessionStats() async {
    if (kIsWeb) {
      final now = DateTime.now();
      final cutoff = now.subtract(const Duration(days: 30));
      final recentDays = _memorySessions
          .where((session) => session.createdAt.isAfter(cutoff))
          .map((session) =>
              '${session.createdAt.year}-${session.createdAt.month}-${session.createdAt.day}')
          .toSet();
      return {
        'total_sessions': _memorySessions.length,
        'total_correct': _memorySessions.fold<int>(
          0,
          (sum, session) => sum + session.correct,
        ),
        'total_answered': _memorySessions.fold<int>(
          0,
          (sum, session) => sum + session.total,
        ),
        'today_sessions': _memorySessions.where((session) {
          final date = session.createdAt;
          return date.year == now.year &&
              date.month == now.month &&
              date.day == now.day;
        }).length,
        'streak_days': recentDays.length,
      };
    }

    final db = _database;
    final totalRow = await db.rawQuery(
      'SELECT COUNT(*) as cnt, SUM(correct) as cor, SUM(total) as tot FROM sessions',
    );
    final todayRow = await db.rawQuery(
      "SELECT COUNT(*) as cnt FROM sessions WHERE date(created_at) = date('now')",
    );
    final streakRow = await db.rawQuery('''
      SELECT COUNT(DISTINCT date(created_at)) as streak
      FROM sessions
      WHERE created_at >= date('now', '-30 days')
    ''');
    return {
      'total_sessions': totalRow.first['cnt'] ?? 0,
      'total_correct': totalRow.first['cor'] ?? 0,
      'total_answered': totalRow.first['tot'] ?? 0,
      'today_sessions': todayRow.first['cnt'] ?? 0,
      'streak_days': streakRow.first['streak'] ?? 0,
    };
  }

  // ── Word stats ────────────────────────────────────────────────
  Future<void> recordWordResult(String wordFr, bool isCorrect) async {
    if (kIsWeb) {
      final stat = _memoryWordStats.putIfAbsent(
        wordFr,
        () => WordStat(wordFr: wordFr),
      );
      stat.seen += 1;
      if (isCorrect) stat.correct += 1;
      return;
    }

    final db = _database;
    final existing = await db.query(
      'word_stats',
      where: 'word_fr = ?',
      whereArgs: [wordFr],
    );
    if (existing.isEmpty) {
      await db.insert('word_stats', {
        'word_fr': wordFr,
        'seen': 1,
        'correct': isCorrect ? 1 : 0,
      });
    } else {
      await db.rawUpdate(
        'UPDATE word_stats SET seen = seen + 1, correct = correct + ? WHERE word_fr = ?',
        [isCorrect ? 1 : 0, wordFr],
      );
    }
  }

  Future<Map<String, WordStat>> getAllWordStats() async {
    if (kIsWeb) {
      return Map<String, WordStat>.from(_memoryWordStats);
    }

    final maps = await _database.query('word_stats');
    return {
      for (final m in maps) (m['word_fr'] as String): WordStat.fromMap(m)
    };
  }

  Future<WordStat?> getWordStat(String wordFr) async {
    if (kIsWeb) {
      return _memoryWordStats[wordFr];
    }

    final maps = await _database.query(
      'word_stats',
      where: 'word_fr = ?',
      whereArgs: [wordFr],
    );
    return maps.isEmpty ? null : WordStat.fromMap(maps.first);
  }
}
