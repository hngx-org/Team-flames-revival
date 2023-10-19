import 'package:shared_preferences/shared_preferences.dart';

class LevelManager {
  static const _levelKey = 'current_level';
  static const _clearedLevelsKey = 'cleared_levels';

  SharedPreferences? _prefs;

  int _currentLevel = 1;
  int _clearedLevels = 1;

  LevelManager() {
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadCurrentLevel();
    _loadClearedLevels();
  }

  int get currentLevel => _currentLevel;

  void _loadCurrentLevel() {
    _currentLevel = _prefs!.getInt(_levelKey) ?? 1;
  }

  void _loadClearedLevels() {
    _clearedLevels = _prefs!.getInt(_clearedLevelsKey) ?? 1;
  }

  void _saveClearedLevels() {
    _prefs!.setInt(_clearedLevelsKey, _clearedLevels);
  }

  void _saveCurrentLevel() {
    _prefs!.setInt(_levelKey, _currentLevel);
  }

  void increaseLevel() {
    if (_currentLevel <= 10) {
      if (_currentLevel <= _clearedLevels) {
        _currentLevel++;
        _saveCurrentLevel();
      }
      // Fetch and use the brick arrangement for the current level
      List<List<int>> brickArrangement =
          getBrickArrangementForLevel(_currentLevel);
      // Use the brickArrangement as needed
    } else {
      // Level cannot be increased beyond 10
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

  // Define a method to get the brick arrangement for a given level
  List<List<int>> getBrickArrangementForLevel(int level) {
    // Define different brick arrangements for each level with different number arrangements
    final levelBrickArrangements = {
      1: [
        [1, 0, 0, 0, 1],
        [1, 0, 0, 0, 1],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 0, 1],
        [1, 0, 0, 0, 1],
      ],
      2: [
        [0, 0, 1, 0, 0],
        [0, 1, 0, 1, 0],
        [1, 0, 0, 0, 1],
        [0, 1, 0, 1, 0],
        [0, 0, 1, 0, 0],
      ],
      3: [
        [0, 1, 0, 1, 0],
        [1, 0, 1, 0, 1],
        [1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 0, 1],
      ],
      4: [
        [5, 5, 5, 5, 5],
        [4, 4, 4, 4, 4],
      ],
      5: [
        [10, 9, 8, 7, 6],
        [1, 2, 3, 4, 5],
      ],
      6: [
        [2, 4, 6, 8, 10],
        [1, 3, 5, 7, 9],
      ],
      7: [
        [3, 6, 9, 12, 15],
        [2, 4, 8, 10, 14],
      ],
      8: [
        [5, 4, 3, 2, 1],
        [10, 9, 8, 7, 6],
      ],
      9: [
        [1, 2, 3, 4, 5],
        [6, 7, 8, 9, 10],
      ],
      10: [
        [10, 9, 8, 7, 6],
        [5, 4, 3, 2, 1],
      ],
      // Add more levels and brick arrangements as needed
    };

    return levelBrickArrangements[level] ?? [];
  }
}
