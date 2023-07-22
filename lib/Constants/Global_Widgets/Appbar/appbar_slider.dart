import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Global_Variables/Sizes/Sizes.dart';
import '../../Global_Variables/colors/colors.dart';

class GlobalCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String appbarText;
  final String sliderText1;
  final String sliderText2;
  final bool isFirstButtonSelected;
  final Function(bool) onButtonPressed;

  const GlobalCustomAppBar({
    super.key,
    required this.sliderText1,
    required this.sliderText2,
    required this.appbarText,
    required this.isFirstButtonSelected,
    required this.onButtonPressed,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(Widgets_Size.appbarWithSliderHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appbarText,
        style: TextStyle(
          fontSize: Widgets_Size.appbarWithSliderTitleFontSize,
          fontWeight: FontWeight.bold,
          color: appbarWithSliderTitleColor,
        ),
      ),
      backgroundColor: universalGray,
      elevation: Widgets_Size.appbarWithSliderelevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(Widgets_Size.appbarWithSliderBottomRadius),
        ),
      ),
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(100.w, 0, 100.w, 30.h),
            height: Widgets_Size.appbarWithSliderInsideSliderHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.grey[300],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 5.h),
                    child: TextButton(
                      onPressed: () => onButtonPressed(true),
                      style: TextButton.styleFrom(
                        backgroundColor: isFirstButtonSelected
                            ? const Color.fromRGBO(35, 35, 35, 1)
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.sp),
                        ),
                      ),
                      child: Text(
                        sliderText1,
                        style: TextStyle(
                          color: isFirstButtonSelected
                              ? Colors.white
                              : Colors.grey[800],
                          fontSize: 50.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 5.h),
                    child: TextButton(
                      onPressed: () => onButtonPressed(false),
                      style: TextButton.styleFrom(
                        backgroundColor: isFirstButtonSelected
                            ? Colors.transparent
                            : const Color.fromRGBO(35, 35, 35, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.sp),
                        ),
                      ),
                      child: Text(
                        sliderText2,
                        style: TextStyle(
                          color: isFirstButtonSelected
                              ? Colors.grey[800]
                              : Colors.white,
                          fontSize: 50.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
