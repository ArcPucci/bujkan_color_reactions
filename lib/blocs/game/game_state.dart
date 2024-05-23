part of 'game_bloc.dart';

enum AppState { success, failed, loading, idle }

@immutable
class GameState {
  final int score;
  final int record;
  final List<Box> boxes;
  final List<String> colorNames;
  final Box targetBox;
  final Box? selectedBox;
  final AppState appState;
  final LevelInfo levelInfo;
  final int counter;

  factory GameState.empty() => GameState(
        score: 0,
        record: 0,
        boxes: const [],
        targetBox: Box.empty(),
        appState: AppState.idle,
        levelInfo: levels[0],
        counter: 0,
        colorNames: const [],
      );

  int get length => levelInfo.id + 2;

  int get timer => counter ~/ 1000;

//<editor-fold desc="Data Methods">

  const GameState({
    required this.score,
    required this.record,
    required this.boxes,
    required this.colorNames,
    required this.targetBox,
    this.selectedBox,
    required this.appState,
    required this.levelInfo,
    required this.counter,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameState &&
          runtimeType == other.runtimeType &&
          score == other.score &&
          record == other.record &&
          boxes == other.boxes &&
          colorNames == other.colorNames &&
          targetBox == other.targetBox &&
          selectedBox == other.selectedBox &&
          appState == other.appState &&
          levelInfo == other.levelInfo &&
          counter == other.counter);

  @override
  int get hashCode =>
      score.hashCode ^
      record.hashCode ^
      boxes.hashCode ^
      colorNames.hashCode ^
      targetBox.hashCode ^
      selectedBox.hashCode ^
      appState.hashCode ^
      levelInfo.hashCode ^
      counter.hashCode;

  @override
  String toString() {
    return 'GameState{ score: $score, record: $record, boxes: $boxes, colorNames: $colorNames, targetBox: $targetBox, selectedBox: $selectedBox, appState: $appState, levelInfo: $levelInfo, counter: $counter,}';
  }

  GameState copyWith({
    int? score,
    int? record,
    List<Box>? boxes,
    List<String>? colorNames,
    Box? targetBox,
    Box? selectedBox,
    AppState? appState,
    LevelInfo? levelInfo,
    int? counter,
  }) {
    return GameState(
      score: score ?? this.score,
      record: record ?? this.record,
      boxes: boxes ?? this.boxes,
      colorNames: colorNames ?? this.colorNames,
      targetBox: targetBox ?? this.targetBox,
      selectedBox: selectedBox ?? this.selectedBox,
      appState: appState ?? AppState.idle,
      levelInfo: levelInfo ?? this.levelInfo,
      counter: counter ?? this.counter,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'score': score,
      'record': record,
      'boxes': boxes,
      'colorNames': colorNames,
      'targetBox': targetBox,
      'selectedBox': selectedBox,
      'appState': appState,
      'levelInfo': levelInfo,
      'counter': counter,
    };
  }

  factory GameState.fromMap(Map<String, dynamic> map) {
    return GameState(
      score: map['score'] as int,
      record: map['record'] as int,
      boxes: map['boxes'] as List<Box>,
      colorNames: map['colorNames'] as List<String>,
      targetBox: map['targetBox'] as Box,
      selectedBox: map['selectedBox'] as Box,
      appState: map['appState'] as AppState,
      levelInfo: map['levelInfo'] as LevelInfo,
      counter: map['counter'] as int,
    );
  }

//</editor-fold>
}
