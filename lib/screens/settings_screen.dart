import 'package:bujkan_color_reactions/blocs/blocs.dart';
import 'package:bujkan_color_reactions/screens/screens.dart';
import 'package:bujkan_color_reactions/utils/links.dart';
import 'package:bujkan_color_reactions/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        return Column(
          children: [
            CustomAppBar(
              name: "Settings",
              coins: state.points,
            ),
            SizedBox(height: 24.h),
            if (!state.premium) ...[
              CustomButton(
                text: "Get Premium",
                onTap: () => _toPremium(context),
              ),
              SizedBox(height: 16.h),
            ],
            ...List.generate(
              links.length,
              (index) => Column(
                children: [
                  CustomButton(
                    onTap: () => _launchUrl(links[index].uri),
                    hasGradient: false,
                    text: links[index].content,
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
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

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw "Could not launch $url";
    }
  }
}
