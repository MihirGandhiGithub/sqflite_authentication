import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class spinning_answer_With_Stream_Builder extends StatelessWidget {
  final String stream;
  final String title;
  final String subtext;

  const spinning_answer_With_Stream_Builder({
    Key? key,
    required this.stream,
    required this.title,
    required this.subtext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(50.w, 20.h, 50.w, 0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Title
          Container(
            alignment: Alignment.centerLeft,
            width: 610.w,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),

          //Text field
          Row(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                  alignment: Alignment.center,
                  height: 120.h,
                  width: 450.w,
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.black,
                    //   width: 1.0,
                    // ),
                    // boxShadow: [BoxShadow(blurRadius: 50)],
                    color: Colors.grey,
                    gradient: const LinearGradient(
                        colors: [Colors.black54, Colors.blueGrey]),
                    borderRadius: BorderRadius.circular(10.0),
                  )),

              SizedBox(
                width: 20.sp,
              ),
              //sub text
              Container(
                width: 230.w,
                // child: Text(''),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
