import 'dart:math';
import 'dart:ui';

import 'package:bujkan_color_reactions/blocs/blocs.dart';
import 'package:bujkan_color_reactions/screens/end_game_screen.dart';
import 'package:bujkan_color_reactions/utils/utils.dart';
import 'package:bujkan_color_reactions/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _onWilPop(context);
        return false;
      },
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (configBloc, configState) {
          return BlocConsumer<GameBloc, GameState>(
            listener: _listener,
            builder: (context, state) {
              return Column(
                children: [
                  CustomAppBar(
                    onTap: () async {
                      context.read<GameBloc>().add(PauseGameEvent());
                      await _onWilPop(context);
                    },
                    name: "Game",
                    coins: configState.points,
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    "0:0${state.timer}",
                    style: TextStyleHelper.helper9,
                  ),
                  SizedBox(height: 28.h),
                  SizedBox(
                    width: 343.r,
                    height: 343.r,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: state.length,
                        crossAxisSpacing: 13.r,
                        mainAxisSpacing: 13.r,
                      ),
                      itemCount: pow(state.length, 2).toInt(),
                      itemBuilder: (context, index) {
                        final box = state.boxes[index];
                        final animate = state.appState != AppState.success;
                        final match = state.targetBox.id == box.id;
                        return ColorButton(
                          enabled: animate || match,
                          asset: configState.boxAsset,
                          content: state.colorNames[index],
                          crossAxisCount: state.length,
                          color: box.color,
                          onTap: animate
                              ? () => context
                                  .read<GameBloc>()
                                  .add(SelectBoxGameEvent(box))
                              : null,
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 340.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Score: ${state.score}",
                          style: TextStyleHelper.helper4,
                        ),
                        Text(
                          "Record: ${state.record}",
                          style: TextStyleHelper.helper4,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: 343.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      border: GradientBoxBorder(
                        gradient: LinearGradient(
                          colors: [
                            ThemeHelper.blue,
                            ThemeHelper.purple,
                          ],
                        ),
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(
                      child: Text(
                        "Choose ${state.targetBox.name}",
                        style: TextStyleHelper.helper1,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void finishGame(BuildContext context, GameState state) {
    showDialog(
      context: context,
      useSafeArea: false,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) {
        return _buildEndGameScreen(context, state);
      },
    );
  }

  Widget _buildEndGameScreen(BuildContext context, GameState state) {
    return EndGameScreen(gameState: state);
  }

  Future<void> _onWilPop(BuildContext context) async {
    await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      useSafeArea: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaY: 10,
            sigmaX: 10,
          ),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: 343.w,
                height: 180.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 1.sp,
                  ),
                  color: ThemeHelper.transparent.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    Text(
                      "LEAVE THE GAME",
                      style: TextStyleHelper.helper11,
                    ),
                    SizedBox(height: 10.h),
                    Opacity(
                      opacity: 0.72,
                      child: Text(
                        "Are you leaving the game?\nYour score will not be saved",
                        style: TextStyleHelper.alertContent,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 343.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1.sp,
                            color: Colors.white.withOpacity(0.25),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                context.read<GameBloc>().add(ResumeGameEvent());
                              },
                              splashColor: Colors.transparent,
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              child: Text(
                                "No",
                                style: TextStyleHelper.helper13,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: 0.25,
                            child: Container(
                              height: 60.h,
                              width: 1.sp,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                context.go("/");
                              },
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              child: Text(
                                "Yes",
                                style: TextStyleHelper.helper13,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _listener(BuildContext context, GameState state) {
    if (state.appState == AppState.failed) {
      finishGame(context, state);
    }
  }
}
