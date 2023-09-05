import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppbarWithText extends StatelessWidget implements PreferredSizeWidget {
  final bool centerTitle;
  final String appbarText;

  const AppbarWithText(
      {super.key, required this.appbarText, required this.centerTitle});
  @override
  Size get preferredSize => Size.fromHeight(180.sp);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Text(appbarText,
          style: TextStyle(fontSize: 70.sp, color: Colors.white)),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      backgroundColor: Colors.blue,
      elevation: 2,
    );
  }
}
