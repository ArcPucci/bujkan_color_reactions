import 'package:bujkan_color_reactions/utils/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.name,
    this.onTap,
    required this.coins,
  }) : super(key: key);

  final String name;
  final VoidCallback? onTap;
  final int coins;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 375.w,
          height: 54.h,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.2),
                width: 1.sp,
              ),
            ),
          ),
          padding: EdgeInsets.only(right: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              onTap != null
                  ? GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: 56.w,
                        height: 54.h,
                        color: Colors.transparent,
                        child: Center(
                          child: SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: Image.asset(
                              "assets/png/icons/back.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(width: 56.w),
              Row(
                children: [
                  Text(
                    "$coins",
                    style: TextStyleHelper.helper1,
                  ),
                  SizedBox(width: 5.w),
                  SizedBox(
                    width: 18.w,
                    height: 18.h,
                    child: Image.asset(
                      "assets/png/icons/coin.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          name,
          style: TextStyleHelper.helper1,
        ),
      ],
    );
  }
}
