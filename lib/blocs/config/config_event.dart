part of 'config_bloc.dart';

@immutable
abstract class ConfigEvent {}

class InitConfigEvent extends ConfigEvent {}

class SaveRecordConfigEvent extends ConfigEvent {
  final int record;
  final LevelInfo levelInfo;

  SaveRecordConfigEvent({
    required this.record,
    required this.levelInfo,
  });
}

class BuyPremiumConfigEvent extends ConfigEvent {}

class SelectBoxAssetConfigEvent extends ConfigEvent {
  final BoxAsset boxAsset;

  SelectBoxAssetConfigEvent(this.boxAsset);
}