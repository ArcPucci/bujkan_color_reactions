import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/png/backgrounds/background.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: const Color(0xFF000F1E).withOpacity(0.8),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
