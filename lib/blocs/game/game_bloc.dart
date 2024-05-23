import 'dart:async';
import 'dart:math';

import 'package:bujkan_color_reactions/blocs/blocs.dart';
import 'package:bujkan_color_reactions/blocs/config/config_bloc.dart';
import 'package:bujkan_color_reactions/models/box.dart';
import 'package:bujkan_color_reactions/models/level.dart';
import 'package:bujkan_color_reactions/utils/boxes.dart';
import 'package:bujkan_color_reactions/utils/levels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  late StreamSubscription _streamSubscription;

  final ConfigBloc _configBloc;

  GameBloc(this._configBloc) : super(GameState.empty()) {
    on<SelectLevelGameEvent>(_onSelectLevel);
    on<StartGameEvent>(_onStart);
    on<SelectBoxGameEvent>(_onSelectBox);
    on<_FailedGameEvent>(_onFailed);
    on<_UpdateTimerGameEvent>(_onUpdateTimer);
    on<PauseGameEvent>(_onPause);
    on<ResumeGameEvent>(_onResume);
  }

  FutureOr<void> _onSelectLevel(
    SelectLevelGameEvent event,
    Emitter<GameState> emit,
  ) {
    emit(state.copyWith(levelInfo: event.levelInfo, record: event.record));
    add(StartGameEvent());
  }

  FutureOr<void> _onStart(StartGameEvent event, Emitter<GameState> emit) {
    final state = _onGenerate();

    final int counter = state.levelInfo.duration.inMilliseconds;
    emit(state.copyWith(counter: counter));
    _streamSubscription =
        Stream.periodic(const Duration(milliseconds: 500)).listen(_listener);
  }

  FutureOr<void> _onSelectBox(
      SelectBoxGameEvent event, Emitter<GameState> emit) async {
    _streamSubscription.cancel();
    if (event.box.id != state.targetBox.id) {
      return add(_FailedGameEvent());
    }

    final int score = state.score + 1;
    final record = max(score, state.record);
    emit(
      state.copyWith(
        appState: AppState.success,
        score: score,
        record: record,
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    _configBloc.add(SaveRecordConfigEvent(
      record: score,
      levelInfo: state.levelInfo,
    ));

    add(StartGameEvent());
  }

  FutureOr<void> _onFailed(
      _FailedGameEvent event, Emitter<GameState> emit) async {
    _streamSubscription.cancel();
    emit(state.copyWith(appState: AppState.failed));

    //wait for showing score result
    await Future.delayed(const Duration(milliseconds: 50));
    emit(state.copyWith(score: 0));
  }

  FutureOr<void> _onUpdateTimer(
      _UpdateTimerGameEvent event, Emitter<GameState> emit) async {
    final counter = state.counter - 500;
    if (counter <= 0) {
      return add(_FailedGameEvent());
    }
    emit(state.copyWith(counter: counter));
  }

  GameState _onGenerate() {
    final int targetIndex = Random().nextInt(9);
    final length = state.levelInfo.id + 2;

    final totalElement = length * length - 1;

    //target Box
    final targetBox = boxList[targetIndex];

    //generate the unique boxes
    List<Box> boxes = [];
    final List<Box> tempBoxes = List.from(boxList);
    tempBoxes.removeAt(targetIndex);

    tempBoxes.addAll(List.from(tempBoxes));

    boxes = tempBoxes.take(totalElement).toList();

    //generate the unique color names

    List<String> colorNames = [];
    final tempColorNames = tempBoxes.map((e) => e.name).toList();

    colorNames = tempColorNames.take(totalElement).toList();

    //add target box to list
    boxes.add(targetBox);
    colorNames.add(targetBox.name);

    boxes.shuffle();
    colorNames.shuffle();

    return state.copyWith(
      targetBox: targetBox,
      colorNames: colorNames,
      boxes: boxes,
    );
  }

  void _listener(event) {
    add(_UpdateTimerGameEvent());
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onPause(
    PauseGameEvent event,
    Emitter<GameState> emit,
  ) async {
    _streamSubscription.pause();
  }

  FutureOr<void> _onResume(
    ResumeGameEvent event,
    Emitter<GameState> emit,
  ) async {
    _streamSubscription.resume();
  }
}
