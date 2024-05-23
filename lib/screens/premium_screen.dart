import 'package:bujkan_color_reactions/blocs/blocs.dart';
import 'package:bujkan_color_reactions/utils/utils.dart';
import 'package:bujkan_color_reactions/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Stack(
        children: [
          Positioned(
            top: 360.h,
            left: 62.w,
            child: Container(
              width: 250.w,
              height: 160.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/png/button_shadows/shadow1.png",
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              child: Center(
                child: Text(
                  "NO ADS",
                  style: TextStyleHelper.helper1,
                ),
              ),
            ),
          ),
          Positioned(
            top: 400.h,
            left: 45.w,
            child: Container(
              width: 285.w,
              height: 180.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/png/button_shadows/shadow2.png",
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              child: Center(
                child: Text(
                  "ALL LEVELS",
                  style: TextStyleHelper.helper1,
                ),
              ),
            ),
          ),
          Positioned(
            top: 440.h,
            left: 31.w,
            child: Container(
              width: 312.w,
              height: 200.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/png/button_shadows/shadow3.png",
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              child: Center(
                child: Text(
                  "PREMIUM SKINS",
                  style: TextStyleHelper.helper1,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 56.w,
                      height: 54.h,
                      color: Colors.transparent,
                      child: Center(
                        child: SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: Image.asset(
                            "assets/png/icons/across.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1.sp,
                  color: Colors.white.withOpacity(0.2),
                ),
                SizedBox(height: 28.h),
                SizedBox(
                  width: 415.w,
                  height: 308.h,
                  child: Transform.scale(
                    scale: 515 / 415,
                    child: Image.asset(
                      "assets/png/animals.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const Spacer(),
                CustomButton(
                  onTap: () => _onBuyPremium(context),
                  text: "Get premium for \$0.99",
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: 343.w,
                  height: 40.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => _launchUrl(links[1].uri),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        child: SizedBox(
                          width: 114.w,
                          child: Center(
                            child: Text(
                              "Terms of Use",
                              style: TextStyleHelper.helper2,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _onBuyPremium(context),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        child: SizedBox(
                          width: 114.w,
                          child: Center(
                            child: Text(
                              "Restore",
                              style: TextStyleHelper.helper2,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _launchUrl(links[0].uri),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        child: SizedBox(
                          width: 114.w,
                          child: Center(
                            child: Text(
                              "Privacy Policy",
                              style: TextStyleHelper.helper2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onBuyPremium(BuildContext context) async {
    context.read<ConfigBloc>().add(BuyPremiumConfigEvent());
    Navigator.pop(context);
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw "Could not launch $url";
    }
  }
}
