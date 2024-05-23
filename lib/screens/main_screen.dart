import 'package:bujkan_color_reactions/blocs/blocs.dart';
import 'package:bujkan_color_reactions/models/models.dart';
import 'package:bujkan_color_reactions/screens/screens.dart';
import 'package:bujkan_color_reactions/utils/levels.dart';
import 'package:bujkan_color_reactions/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int levelIndex = 0;
  LevelInfo level = levels[0];

  final List<List<Color>> colors = [
    [
      Color(0xFFAEEBF8),
      Color(0xFF69BDEB),
    ],
    [
      Color(0xFFF3AF2B),
      Color(0xFFF3EB2B),
    ],
    [
      Color(0xFFF35B2B),
      Color(0xFFF32B2B),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        return BlocBuilder<GameBloc, GameState>(
          builder: (gameBloc, gameState) {
            return BackgroundWidget(
              child: Column(
                children: [
                  CustomAppBar(
                    name: "Select difficulty",
                    coins: state.points,
                  ),
                  SizedBox(height: 50.h),
                  CarouselSlider.builder(
                    itemCount: levels.length,
                    itemBuilder: (context, index, realIndex) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: DifficultyCard(
                          colors: colors[realIndex],
                          asset: levels[realIndex].asset,
                          difficulty: levels[realIndex].level,
                          description: levels[realIndex].description,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          levelIndex = index;
                          level = levels[index];
                        });
                      },
                      height: 440.sp,
                      scrollPhysics: const BouncingScrollPhysics(),
                      animateToClosest: false,
                      enableInfiniteScroll: false,
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    enabled: (state.premium || !levels[levelIndex].isPremium),
                    onTap: () {
                      if (!(state.premium || !levels[levelIndex].isPremium)) {
                        _toPremium(context);
                      } else {
                        final record = state.records[level.id] ?? 0;
                        context.read<GameBloc>().add(
                              SelectLevelGameEvent(level, record),
                            );
                        context.go("/gameScreen");
                        levelIndex = 0;
                      }
                    },
                    text: "Play",
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _toPremium(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return const PremiumScreen();
    });
    Navigator.of(context, rootNavigator: true).push(route);
    return;
  }
}
