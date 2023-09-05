import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppbarWithText extends StatelessWidget implements PreferredSizeWidget {
  final bool isBackButton;
  final bool centerTitle;
  final String appbarText;

  const AppbarWithText(
      {super.key, required this.appbarText, required this.centerTitle, required this.isBackButton});
  @override
  Size get preferredSize => Size.fromHeight(180.h);
  @override
  Widget build(BuildContext context) {
    return AppBar(
         leading:isBackButton? IconButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home_screen');
        },
        icon: const Icon(Icons.arrow_back_sharp),
      ):null,
      centerTitle: centerTitle,
      title: Text(
        appbarText,
      ),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     bottom: Radius.circular(30),
      //   ),
      // ),
      backgroundColor: Colors.blue,
      elevation: 2,
    );
  }
}
