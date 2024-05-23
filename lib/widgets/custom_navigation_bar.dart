import 'package:bujkan_color_reactions/models/image_item.dart';
import 'package:bujkan_color_reactions/utils/image_items.dart';
import 'package:bujkan_color_reactions/utils/text_style_helper.dart';
import 'package:bujkan_color_reactions/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.5.sp,
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        color: ThemeHelper.transparent,
      ),
      child: Row(
        children: List.generate(
          imageItems.length,
          (index) {
            final ImageItem item = imageItems[index];
            return Expanded(
              child: _NavigationBarItem(
                selected: index == _selected,
                imageItem: item,
                onTap: () => _onTap(item, index),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onTap(ImageItem item, int index) {
    _selected = index;
    context.go(item.path);
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    this.selected = false,
    this.onTap,
    required this.imageItem,
  }) : super(key: key);

  final bool selected;
  final VoidCallback? onTap;
  final ImageItem imageItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: selected
          ? Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24.r,
                    height: 24.r,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            ThemeHelper.blue,
                            ThemeHelper.purple,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: Image.asset(
                        imageItem.asset,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [
                          ThemeHelper.blue,
                          ThemeHelper.purple,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(
                        Rect.fromLTWH(
                          bounds.left - 117.w / 2,
                          bounds.top,
                          117.w,
                          14.h,
                        ),
                      );
                    },
                    child: Text(
                      imageItem.title,
                      style: TextStyleHelper.helper5.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24.r,
                    height: 24.r,
                    child: Image.asset(
                      imageItem.asset,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    imageItem.title,
                    style: TextStyleHelper.helper5,
                  ),
                ],
              ),
            ),
    );
  }
}
