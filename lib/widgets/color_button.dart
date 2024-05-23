import 'package:bujkan_color_reactions/utils/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({
    Key? key,
    required this.asset,
    this.onTap,
    required this.content,
    required this.crossAxisCount,
    required this.color,
    this.enabled = true,
  }) : super(key: key);

  final String asset;
  final VoidCallback? onTap;
  final String content;
  final int crossAxisCount;
  final Color color;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: enabled ? Duration.zero : const Duration(seconds: 1),
        opacity: enabled ? 1 : 0.3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular((48.r * 2) / crossAxisCount),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 12.r / crossAxisCount,
                width: 165.r * (2 / crossAxisCount),
                child: Image.asset(
                  asset,
                ),
              ),
              Container(
                color: color.withOpacity(0.7),
              ),
              Text(
                content,
                style: crossAxisCount == 2
                    ? TextStyleHelper.helper8.copyWith(
                        color: color == Colors.white ? Colors.black : null,
                      )
                    : crossAxisCount == 3
                        ? TextStyleHelper.helper6.copyWith(
                            color: color == Colors.white ? Colors.black : null,
                          )
                        : TextStyleHelper.helper10.copyWith(
                            color: color == Colors.white ? Colors.black : null,
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
