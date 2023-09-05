// with onchaged method
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalRowWidgetWithOnchanged extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String subtitle;
  final double height;
  final double width;
  final Function(String)? onchaned;

  const GlobalRowWidgetWithOnchanged({
    super.key,
    required this.title,
    required this.controller,
    required this.subtitle,
    required this.height,
    required this.width,
    required this.onchaned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Title
          Container(
            width: 450.w,
            margin: EdgeInsets.only(left: 80.w),
            child: Tooltip(
              message: title,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 45.sp,
                ),
              ),
            ),
          ),

          //Text field
          Row(
            children: [
              SizedBox(
                height: 120.h,
                width: 500.w,
                child: TextField(
                  textAlign: TextAlign.left,
                  controller: controller,
                  onChanged: onchaned,
                  cursorColor: Colors.black,
                  // cursorHeight: 60.sp,
                  style: TextStyle(fontSize: 60.sp, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors
                        .grey[200], // Set your desired background color here
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          70.sp), // Set the circular border radius here
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 5.sp,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 30.sp),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(7),
                  ],
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
              ),

              SizedBox(
                width: 20.sp,
              ),
              //sub text
              SizedBox(
                width: 230.w,
                child: Tooltip(
                  message: subtitle,
                  child: Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 30.sp, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GlobalRowWidgetWithOnchangedForCurency extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String subtitle;
  final double height;
  final double width;
  final Function(String)? onchaned;

  const GlobalRowWidgetWithOnchangedForCurency({
    super.key,
    required this.title,
    required this.controller,
    required this.subtitle,
    required this.height,
    required this.width,
    required this.onchaned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Title
          Container(
            margin: EdgeInsets.only(left: 80.w),
            child: Tooltip(
              message: title,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 45.sp,
                ),
              ),
            ),
          ),

          //Text field
          Container(
            margin: EdgeInsets.only(right: 80.w),
            height: 120.h,
            width: 400.w,
            child: TextField(
              textAlign: TextAlign.left,
              controller: controller,
              onChanged: onchaned,
              cursorColor: Colors.black,
              // cursorHeight: 60.sp,
              style: TextStyle(fontSize: 60.sp, color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    Colors.grey[200], // Set your desired background color here
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      70.sp), // Set the circular border radius here
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 5.sp,
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 30.sp),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(7),
              ],
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
            ),
          ),
        ],
      ),
    );
  }
}
