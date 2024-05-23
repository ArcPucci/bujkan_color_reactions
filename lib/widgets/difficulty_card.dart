import 'package:bujkan_color_reactions/utils/text_style_helper.dart';
import 'package:bujkan_color_reactions/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DifficultyCard extends StatelessWidget {
  const DifficultyCard({
    Key? key,
    required this.asset,
    required this.difficulty,
    required this.description,
    required this.colors,
  }) : super(key: key);

  final String asset;
  final String difficulty;
  final String description;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeHelper.darkGrey,
        borderRadius: BorderRadius.circular(15.sp),
        border: Border.all(
          width: 1.sp,
          color: Colors.white.withOpacity(0.2),
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              // width: 343.w,
              // height: 300.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.sp),
                  topRight: Radius.circular(15.sp),
                ),
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: 208.sp,
                  height: 208.sp,
                  child: Image.asset(
                    asset,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  difficulty,
                  style: TextStyleHelper.helper3,
                ),
                Text(
                  description,
                  style: TextStyleHelper.helper4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
