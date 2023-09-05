import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWithSlider extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final String sliderText1;
  final String sliderText2;
  const AppBarWithSlider(
      {super.key,
      required this.titleText,
      required this.sliderText1,
      required this.sliderText2});
  @override
  Size get preferredSize => Size.fromHeight(350.sp);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        titleText,
        style: TextStyle(
          fontSize: 60.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.blue,
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(50),
        ),
      ),
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(120.sp, 0, 120.sp, 30.sp),
            padding: EdgeInsets.all(10.sp),
            height: 120.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: TabBar(
              indicator: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 0.5),
                gradient: const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Colors.blue,
                      Colors.blue,
                    ]),
                borderRadius: BorderRadius.circular(20),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  text: sliderText1,
                ),
                Tab(
                  text: sliderText2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
