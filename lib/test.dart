// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'Constants/Global_Variables/colors/colors.dart';
//
// class userdetail extends StatefulWidget {
//   const userdetail({super.key});
//
//   @override
//   State<userdetail> createState() => _userdetailState();
// }
//
// class _userdetailState extends State<userdetail> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Detail',
//             style: TextStyle(fontSize: 70.sp, color: Colors.black)),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(150.sp),
//           ),
//         ),
//         backgroundColor: universalGray,
//         elevation: 2,
//       ),
//       body: Container(
//         margin: EdgeInsets.only(top: 50.h, left: 40.w, right: 40.w),
//         child: ListView(
//           children: [
//             Container(
//               color: Colors.grey[200],
//               padding: EdgeInsets.only(top: 40.h, bottom: 40.h),
//               child: Column(
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     child: CircleAvatar(
//                         radius: 200.sp,
//                         backgroundColor: Colors.blue,
//                         backgroundImage:
//                             const AssetImage('assets/only_kt_logo.png')),
//                   ),
//                   Container(
//                       alignment: Alignment.center,
//                       child: Text(
//                         'Mihir Gandhi',
//                         style: TextStyle(color: Colors.black, fontSize: 60.sp),
//                       )),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
