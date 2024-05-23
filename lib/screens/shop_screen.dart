import 'package:bujkan_color_reactions/blocs/blocs.dart';
import 'package:bujkan_color_reactions/screens/screens.dart';
import 'package:bujkan_color_reactions/utils/utils.dart';
import 'package:bujkan_color_reactions/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        final points = state.points;
        final boxAsset = boxAssets[_selected];
        final canChoose = state.boxAssets.contains(boxAsset.asset);
        final canBuy = boxAsset.price <= points && !canChoose;
        final chosen = state.boxAsset == boxAsset.asset;
        final enabled = chosen ? false : canBuy || canChoose;
        final locked = !state.premium && boxAsset.isPremium;
        return Column(
          children: [
            CustomAppBar(
              name: "Shop",
              coins: state.points,
            ),
            SizedBox(height: 70.h),
            SizedBox(
              width: 343.r,
              height: 343.r,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 13.r,
                  mainAxisSpacing: 13.r,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  final Color color = colors[index];
                  return ColorButton(
                    asset: boxAssets[_selected].asset,
                    content: "COLOR",
                    crossAxisCount: 3,
                    color: color,
                  );
                },
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 343.w,
              child: Row(
                children: [
                  _SimpleButton(
                    enabled: _selected > 0,
                    onTap: () {
                      if (_selected > 0) {
                        _selected--;
                        setState(() {});
                      }
                    },
                    asset: "assets/png/icons/prev.png",
                  ),
                  Expanded(
                    child: Text(
                      "${_selected + 1}/5",
                      style: TextStyleHelper.helper7,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  _SimpleButton(
                    enabled: _selected < 4,
                    onTap: () {
                      if (_selected < 4) {
                        _selected++;
                        setState(() {});
                      }
                    },
                    asset: "assets/png/icons/next.png",
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            CustomButton(
              onTap: enabled
                  ? () => context
                      .read<ConfigBloc>()
                      .add(SelectBoxAssetConfigEvent(boxAsset))
                  : locked
                      ? () => _toPremium(context)
                      : null,
              enabled: !chosen && !locked,
              hasIcon: !chosen && !locked,
              text: locked
                  ? "Locked"
                  : canChoose
                      ? chosen
                          ? "CHOSEN"
                          : "CHOOSE"
                      : boxAsset.price.toString(),
            ),
            SizedBox(height: 24.h),
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
}

class _SimpleButton extends StatelessWidget {
  const _SimpleButton({
    Key? key,
    required this.asset,
    this.onTap,
    this.enabled = false,
  }) : super(key: key);

  final String asset;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.sp),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1.sp,
          ),
          gradient: enabled
              ? LinearGradient(
                  colors: [
                    ThemeHelper.blue,
                    ThemeHelper.purple,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: enabled ? null : ThemeHelper.gray,
        ),
        child: Center(
          child: SizedBox(
            width: 24.w,
            height: 24.w,
            child: Image.asset(
              asset,
            ),
          ),
        ),
      ),
    );
  }
}
