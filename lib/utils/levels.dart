import 'package:bujkan_color_reactions/models/level.dart';

final List<LevelInfo> levels = [
  LevelInfo(
    id: 0,
    level: "EASY LVL",
    asset: "assets/png/easy_level.png",
    description: "You should choose correct color 2x2 gameboard\n3 seconds",
    duration: const Duration(seconds: 3),
    points: 10,
    isPremium: false,
  ),
  LevelInfo(
    id: 1,
    level: "MEDIUM LVL",
    asset: "assets/png/medium_level.png",
    description: "You should choose correct color 3x3 gameboard\n2 seconds",
    duration: const Duration(seconds: 2),
    points: 25,
    isPremium: true,
  ),
  LevelInfo(
    id: 2,
    level: "HARD LVL",
    asset: "assets/png/hard_level.png",
    description: "You should choose correct color 4x4 gameboard\n1.5 seconds",
    duration: const Duration(seconds: 2),
    points: 50,
    isPremium: true,
  ),
];
