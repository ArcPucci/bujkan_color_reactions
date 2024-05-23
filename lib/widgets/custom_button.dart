import 'package:bujkan_color_reactions/utils/text_style_helper.dart';
import 'package:bujkan_color_reactions/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.onTap,
    required this.text,
    this.enabled = true,
    this.hasGradient = true,
    this.hasIcon = false,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String text;
  final bool enabled;
  final bool hasGradient;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 343.w,
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999.sp),
          border: Border.all(
            width: 1.sp,
            color: Colors.white.withOpacity(0.2),
          ),
          gradient: enabled && hasGradient
              ? LinearGradient(
                  colors: [
                    ThemeHelper.blue,
                    ThemeHelper.purple,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: enabled && hasGradient ? null : ThemeHelper.gray,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyleHelper.helper1,
            ),
            if(hasIcon) ...[
              SizedBox(width: 5.w),
              SizedBox(
                width: 22.w,
                height: 22.h,
                child: Image.asset(
                  "assets/png/icons/coin.png",
                  fit: BoxFit.contain,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
