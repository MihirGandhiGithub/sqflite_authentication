import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class GlobalResultBuilderForResults extends StatelessWidget {
  final double result;
  final String substreamtext;
  final String streamtitletext;

  const GlobalResultBuilderForResults(
      {super.key,
      required this.substreamtext,
      required this.streamtitletext,
      required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(50.w, 20.h, 50.w, 0),
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 10.w, 10.h),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(50.sp),
      ),
      child: Row(
        children: [
          Text(
            streamtitletext,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(
            width: 40.w,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 120.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(40.sp),
              ),
              child: Tooltip(
                message: '$result' ' $substreamtext',
                child: GradientText(
                  '$result' ' $substreamtext',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 55.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: const [
                    Colors.black,
                    Colors.teal,
                    Colors.red,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
