import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppbarWithAction extends StatelessWidget implements PreferredSizeWidget {
  final bool centerTitle;
  final String appbarText;
  final IconData appbarIcon;
  final VoidCallback appbarIconOnPress;

  const AppbarWithAction(
      {super.key,
      required this.appbarText,
      required this.appbarIcon,
      required this.appbarIconOnPress,
      required this.centerTitle});
  @override
  Size get preferredSize => Size.fromHeight(180.sp);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            icon: Icon(
              appbarIcon,
              color: Colors.white,
              // size: 100.sp,
            ),
            onPressed: appbarIconOnPress)
      ],
      centerTitle: centerTitle,
      title: Text(appbarText,
          style: TextStyle(fontSize: 80.sp, color: Colors.white)),
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
