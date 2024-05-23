part of 'config_bloc.dart';

@immutable
class ConfigState {
  final String boxAsset;
  final List<String> boxAssets;
  final int points;
  final Map<int, int> records;
  final bool premium;
  final int level;

  factory ConfigState.empty() => const ConfigState(
        boxAsset: "assets/png/circles/bird.png",
        boxAssets: ["assets/png/circles/bird.png"],
        points: 500,
        records: {},
        premium: false,
        level: 0,
      );

//<editor-fold desc="Data Methods">

  const ConfigState({
    required this.boxAsset,
    required this.boxAssets,
    required this.points,
    required this.records,
    required this.premium,
    required this.level,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConfigState &&
          runtimeType == other.runtimeType &&
          boxAsset == other.boxAsset &&
          boxAssets == other.boxAssets &&
          points == other.points &&
          records == other.records &&
          premium == other.premium &&
          level == other.level);

  @override
  int get hashCode =>
      boxAsset.hashCode ^
      boxAssets.hashCode ^
      points.hashCode ^
      records.hashCode ^
      premium.hashCode ^
      level.hashCode;

  @override
  String toString() {
    return 'ConfigState{ boxAsset: $boxAsset, boxAssets: $boxAssets, points: $points, records: $records, premium: $premium, level: $level,}';
  }

  ConfigState copyWith({
    String? boxAsset,
    List<String>? boxAssets,
    int? points,
    Map<int, int>? records,
    bool? premium,
    int? level,
  }) {
    return ConfigState(
      boxAsset: boxAsset ?? this.boxAsset,
      boxAssets: boxAssets ?? this.boxAssets,
      points: points ?? this.points,
      records: records ?? this.records,
      premium: premium ?? this.premium,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'boxAsset': boxAsset,
      'boxAssets': boxAssets,
      'points': points,
      'records': records,
      'premium': premium,
      'level': level,
    };
  }

  factory ConfigState.fromMap(Map<String, dynamic> map) {
    return ConfigState(
      boxAsset: map['boxAsset'] as String,
      boxAssets: map['boxAssets'] as List<String>,
      points: map['points'] as int,
      records: map['records'] as Map<int, int>,
      premium: map['premium'] as bool,
      level: map['level'] as int,
    );
  }

//</editor-fold>
}
