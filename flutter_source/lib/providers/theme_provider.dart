import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _themeKey = 'theme_mode';
  static const _nameKey = 'user_name';
  static const _streakKey = 'streak_count';
  static const _dailyGoalKey = 'daily_goal_minutes';

  final SharedPreferences _prefs;
  ThemeMode _mode;
  String _userName = '';
  int _streak = 0;
  int _dailyGoalMinutes = 15;

  ThemeProvider(this._prefs)
      : _mode = _modeFromString(_prefs.getString(_themeKey)) {
    _userName = _prefs.getString(_nameKey) ?? '';
    _streak = _prefs.getInt(_streakKey) ?? 0;
    _dailyGoalMinutes = _prefs.getInt(_dailyGoalKey) ?? 15;
  }

  ThemeMode get themeMode => _mode;
  bool get isDark => _mode == ThemeMode.dark;
  String get userName => _userName;
  int get streak => _streak;
  int get dailyGoalMinutes => _dailyGoalMinutes;

  void toggle() {
    _mode = isDark ? ThemeMode.light : ThemeMode.dark;
    _prefs.setString(_themeKey, _mode == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }

  void setDark(bool dark) {
    _mode = dark ? ThemeMode.dark : ThemeMode.light;
    _prefs.setString(_themeKey, _mode == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }

  void setUserName(String name) {
    _userName = name;
    _prefs.setString(_nameKey, name);
    notifyListeners();
  }

  void setStreak(int count) {
    _streak = count;
    _prefs.setInt(_streakKey, count);
    notifyListeners();
  }

  void setDailyGoal(int minutes) {
    _dailyGoalMinutes = minutes;
    _prefs.setInt(_dailyGoalKey, minutes);
    notifyListeners();
  }

  static ThemeMode _modeFromString(String? s) {
    return s == 'light' ? ThemeMode.light : ThemeMode.dark;
  }
}
