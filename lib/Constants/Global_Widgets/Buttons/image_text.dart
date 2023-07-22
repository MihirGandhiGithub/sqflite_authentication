import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageBoxContainer extends StatelessWidget {
  final String imageAsset;
  final String buttonText;
  final VoidCallback onPressed;

  const HomePageBoxContainer({
    super.key,
    required this.imageAsset,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 5.sp,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.sp),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.sp,
            color: Colors.grey.withOpacity(1),
          ),
        ],
      ),
      // height: 500.h,
      // width: 400.w,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Ink(
            decoration: const BoxDecoration(
                // color: Colors.blue,
                // borderRadius: BorderRadius.circular(10),
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(imageAsset),
                  height: 250.h,
                ),
                Tooltip(
                  message: buttonText,
                  child: Text(
                    buttonText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
