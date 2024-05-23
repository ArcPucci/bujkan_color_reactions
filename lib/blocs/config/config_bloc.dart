import 'dart:async';

import 'package:bujkan_color_reactions/models/box_asset.dart';
import 'package:bujkan_color_reactions/models/level.dart';
import 'package:bujkan_color_reactions/services/services.dart';
import 'package:bujkan_color_reactions/utils/levels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'config_event.dart';

part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final PreferenceService _preferenceService;

  ConfigBloc(this._preferenceService) : super(ConfigState.empty()) {
    on<InitConfigEvent>(_onInit);
    on<SaveRecordConfigEvent>(_onSaveRecord);
    on<BuyPremiumConfigEvent>(_onBuyPremium);
    on<SelectBoxAssetConfigEvent>(_onSelectBoxAsset);
  }

  FutureOr<void> _onInit(InitConfigEvent event, Emitter<ConfigState> emit) {
    final points = _preferenceService.getPoints();
    final premium = _preferenceService.isPremium();
    final level = _preferenceService.getLevel();
    final boxAsset = _preferenceService.getBoxAsset();
    final boxAssets = _preferenceService.getBoxAssets();

    final Map<int, int> records = {};

    for (final item in levels) {
      records[item.id] = _preferenceService.getRecord(item.id);
    }

    emit(
      ConfigState(
        boxAsset: boxAsset,
        boxAssets: boxAssets,
        points: points,
        records: records,
        premium: premium,
        level: level,
      ),
    );
  }

  FutureOr<void> _onSaveRecord(
      SaveRecordConfigEvent event, Emitter<ConfigState> emit) async {
    final levelInfo = event.levelInfo;
    final newRecord = event.record;
    final records = state.records;
    int currentLevel = state.level;
    final points = state.points + levelInfo.points;

    final oldRecord = records[levelInfo.id] ?? 0;

    _preferenceService.setPoints(points);
    if (oldRecord < newRecord) {
      records[levelInfo.id] = newRecord;
      _preferenceService.setRecord(levelInfo.id, newRecord);
    }

    // if (currentLevel == levelInfo.id && newRecord == levelInfo.congratsScore) {
    //   currentLevel++;
    //   _preferenceService.setLevel(currentLevel);
    // }

    emit(state.copyWith(
      records: records,
      points: points,
      level: currentLevel,
    ));
  }

  FutureOr<void> _onBuyPremium(
    BuyPremiumConfigEvent event,
    Emitter<ConfigState> emit,
  ) {
    _preferenceService.setPremium();
    emit(state.copyWith(premium: true));
  }

  FutureOr<void> _onSelectBoxAsset(
    SelectBoxAssetConfigEvent event,
    Emitter<ConfigState> emit,
  ) async {
    final boxAssets = state.boxAssets;
    final boxAsset = event.boxAsset;
    final hasBoxAsset = boxAssets.contains(boxAsset.asset);

    if (hasBoxAsset) {
      return emit(
        state.copyWith(
          boxAsset: boxAsset.asset,
        ),
      );
    }

    final points = state.points - boxAsset.price;
    boxAssets.add(boxAsset.asset);

    _preferenceService.setBoxAssets(boxAssets);

    emit(
      state.copyWith(
        points: points,
        boxAssets: boxAssets,
        boxAsset: boxAsset.asset,
      ),
    );
  }
}
