class LevelInfo {
  final int id;
  final String level;
  final String asset;
  final String description;
  final Duration duration;
  final int points;
  final bool isPremium;

  LevelInfo({
    required this.id,
    required this.points,
    required this.level,
    required this.asset,
    required this.description,
    required this.duration,
    required this.isPremium,
  });
}
