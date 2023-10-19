import 'package:shared_preferences/shared_preferences.dart';

class LevelManager {
  static const _levelKey = 'current_level';
  static const _clearedLevelsKey = 'cleared_levels';

  late final SharedPreferences _prefs;

  int _currentLevel = 1;
    int _clearedLevels = 1;
  // Use a static method to create an instance of LevelManager which ensures that _prefs is initialized before the instance is returned.
  LevelManager._(this._prefs) {
    _loadCurrentLevel();
    _loadClearedLevels();
  }

   static Future<LevelManager> create() async {
    final prefs = await SharedPreferences.getInstance();
    return LevelManager._(prefs);
  }


  int get currentLevel => _currentLevel;

  void _loadCurrentLevel() async {
    _prefs = await SharedPreferences.getInstance();
    _currentLevel = _prefs.getInt(_levelKey) ?? 1;
  }

  void _loadClearedLevels() async {
    _clearedLevels = _prefs.getInt(_clearedLevelsKey) ?? 1;
  }

  void _saveClearedLevels() {
    _prefs.setInt(_clearedLevelsKey, _clearedLevels);
  }

  void _saveCurrentLevel() {
    _prefs.setInt(_levelKey, _currentLevel);
  }

  void increaseLevel() {
    switch (_currentLevel) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
      case 8:
      case 9:
        if (_currentLevel <= _clearedLevels) {
          _currentLevel++;
          _saveCurrentLevel();
        }
        break;
      case 10:
        // Level cannot be increased beyond 10
        break;
      
    }
  }

  void resetLevel() {
    _currentLevel = 1;
    _saveCurrentLevel();
  }

  // Call this method when a level is cleared to unlock the next level.
  void levelCleared() {
    if (_currentLevel == _clearedLevels) {
      _clearedLevels++;
      _saveClearedLevels();
    }
  }
}
