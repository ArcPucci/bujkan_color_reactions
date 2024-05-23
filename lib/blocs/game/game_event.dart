part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class SelectLevelGameEvent extends GameEvent {
  final LevelInfo levelInfo;
  final int record;

  SelectLevelGameEvent(this.levelInfo, this.record);
}

class StartGameEvent extends GameEvent {}

class SelectBoxGameEvent extends GameEvent {
  final Box box;

  SelectBoxGameEvent(this.box);
}

class PauseGameEvent extends GameEvent {}

class ResumeGameEvent extends GameEvent {}

class _FailedGameEvent extends GameEvent {}

class _UpdateTimerGameEvent extends GameEvent {}