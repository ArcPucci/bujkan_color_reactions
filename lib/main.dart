import 'dart:async';

import 'package:apphud/apphud.dart';
import 'package:bujkan_color_reactions/blocs/blocs.dart';
import 'package:bujkan_color_reactions/screens/game_screen.dart';
import 'package:bujkan_color_reactions/screens/main_screen.dart';
import 'package:bujkan_color_reactions/screens/navigation_screen.dart';
import 'package:bujkan_color_reactions/screens/settings_screen.dart';
import 'package:bujkan_color_reactions/screens/shop_screen.dart';
import 'package:bujkan_color_reactions/services/preference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceService().init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runZonedGuarded(
      () => runApp(
            ScreenUtilInit(
              designSize: const Size(375, 812),
              builder: (BuildContext context, Widget? child) => MyApp(),
            ),
          ), (error, stack) {
    debugPrint(error.toString());
    debugPrintStack(stackTrace: stack);
  });
}

CustomTransitionPage buildPageWithDefaultTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 100),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        key: state.pageKey,
        opacity: animation,
        child: child,
      );
    },
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) => NavigationScreen(
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const MainScreen(),
            ),
            routes: [
              GoRoute(
                path: 'gameScreen',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const GameScreen(),
                  );
                },
              )
            ],
          ),
          GoRoute(
            path: '/settingsScreen',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const SettingsScreen(),
              );
            },
          ),
          GoRoute(
            path: '/shopScreen',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const ShopScreen(),
              );
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PreferenceService(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ConfigBloc(
                RepositoryProvider.of(context),
              )..add(InitConfigEvent());
            },
          ),
          BlocProvider(
            create: (context) {
              return GameBloc(
                BlocProvider.of(context),
              );
            },
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
          routeInformationProvider: _router.routeInformationProvider,
        ),
      ),
    );
  }
}
