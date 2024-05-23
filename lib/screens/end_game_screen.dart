import 'dart:ui';

import 'package:bujkan_color_reactions/blocs/blocs.dart';
import 'package:bujkan_color_reactions/utils/utils.dart';
import 'package:bujkan_color_reactions/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EndGameScreen extends StatelessWidget {
  const EndGameScreen({
    Key? key,
    required this.gameState,
  }) : super(key: key);

  final GameState gameState;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 6,
              sigmaY: 6,
            ),
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    CustomAppBar(
                      name: "Game over",
                      coins: state.points,
                    ),
                    SizedBox(height: 126.h),
                    SizedBox(
                      width: 202.w,
                      height: 237.h,
                      child: Transform.scale(
                        scale: 2,
                        child: Image.asset(
                          "assets/png/fail.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      "SCORE:\n${gameState.score}",
                      style: TextStyleHelper.helper14,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    CustomButton(
                      onTap: () {
                        context.read<GameBloc>().add(StartGameEvent());
                        Navigator.pop(context);
                      },
                      text: "Try again",
                    ),
                    SizedBox(height: 16.h),
                    CustomButton(
                      onTap: () {
                        Navigator.pop(context);
                        context.go("/");
                      },
                      text: "Main menu",
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
