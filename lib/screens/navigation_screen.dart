import 'package:bujkan_color_reactions/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Column(
        children: [
          Expanded(child: child),
          const CustomNavigationBar(),
        ],
      ),
    );
  }
}
