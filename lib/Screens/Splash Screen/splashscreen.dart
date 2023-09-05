import 'package:flutter/material.dart';
import 'package:kt1_textile_calculation/Other%20Class/auth_services.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../Constants/Global_Variables/Screen Util Size.dart';
import '../../Constants/Global_Variables/variables/variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Load image URLs from Firestore

    // Add a delay of 3 seconds before navigating to the next screen
    Future.delayed(const Duration(milliseconds: 100), () async {
      CustomAuthService.user = CustomAuthService.auth.currentUser;
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? localStorageAdminCheck = prefs.getString('admin') ?? 'false';

      try {
        if (CustomAuthService.user != null) {
          CustomAuthService.userSnapshot = await CustomAuthService.firestore
              .collection('users')
              .doc(CustomAuthService.user!.uid)
              .get();

          setState(() {
            UserData.userName =
                CustomAuthService.userSnapshot!['name'].toString();
            UserData.userEmail =
                CustomAuthService.userSnapshot!['email'].toString();
            UserData.userPhoneNumber =
                CustomAuthService.userSnapshot!['contactNumber'].toString();
          });

          Map<String, dynamic>? userData =
              CustomAuthService.userSnapshot!.data() as Map<String, dynamic>?;
          bool localStorageAdminCheck = userData?['admin'] ?? false;

          if (UserData.userName.isEmpty || UserData.userPhoneNumber.isEmpty) {
            Navigator.pushReplacementNamed(context, '/AddDetail_screen');
          } else if (localStorageAdminCheck) {
            Navigator.pushReplacementNamed(context, '/adminPanel_home');
          } else {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String lastScreen = prefs.getString('last_screen') ?? 'home_screen';
            // Navigator.pushReplacementNamed(context, lastScreen);
            Navigator.pushReplacementNamed(context, '/$lastScreen');
            // CustomNavigationClass.Homepage(context);
          }
        } else {
          // User is not authenticated, navigate to login page
          Navigator.pushReplacementNamed(context, '/login_screen');
        }
      } catch (e) {
        SnackBar snackBar = SnackBar(content: Text('error: $e'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Handle any errors here
        // You can show an error message or navigate to the login page
        Navigator.pushReplacementNamed(context, '/login_screen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: SUwidth50w,
            right: SUwidth50w,
            bottom: SUheight1200h,
            child: SizedBox(
              height: SUheight400h,
              child: Image.asset('assets/textile_calculator_logo.png'),
            ),
          ),
          Positioned(
            left: SUwidth50w, right: SUwidth50w, bottom: SUheight800h,
            // color: Colors.transparent,
            child: SizedBox(
                height: SUheight600h,
                child: Lottie.asset('assets/loading 5.json')),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Designed By',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: text50sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              GradientText(
                'KING TECHNOLOGY',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: text70sp,
                  fontWeight: FontWeight.bold,
                ),
                colors: const [
                  Colors.blue,
                  Colors.red,
                  Colors.teal,
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

// {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   Future<void> checkCurrentUser() async {
//     CustomAuthService.user = CustomAuthService.auth.currentUser;
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? localStorageAdminCheck = prefs.getString('admin') ?? 'false';
//
//     try {
//       if (CustomAuthService.user != null) {
//         CustomAuthService.userSnapshot = await CustomAuthService.firestore
//             .collection('users')
//             .doc(CustomAuthService.user!.uid)
//             .get();
//
//         setState(() {
//           UserData.userName =
//               CustomAuthService.userSnapshot!['name'].toString();
//           UserData.userEmail =
//               CustomAuthService.userSnapshot!['email'].toString();
//           UserData.userPhoneNumber =
//               CustomAuthService.userSnapshot!['contactNumber'].toString();
//         });
//
//         if (UserData.userName.isEmpty || UserData.userPhoneNumber.isEmpty) {
//           _controller.stop();
//           CustomNavigationClass.AddUserDetailPage(context);
//         } else if (localStorageAdminCheck == 'true') {
//           _controller.stop();
//           CustomNavigationClass.AdminPanelHomePage(context);
//         } else {
//           _controller.stop();
//           CustomNavigationClass.Homepage(context);
//         }
//       } else {
//         _controller.stop();
//         // User is not authenticated, navigate to login page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginPage()),
//         );
//       }
//     } catch (e) {
//       _controller.stop();
//       SnackBar snackBar = SnackBar(content: Text('error: $e'));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       // Handle any errors here
//       // You can show an error message or navigate to the login page
//       CustomNavigationClass.loginPage(context);
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );
//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           // Animation completed, check current user
//         }
//       });
//     _controller.repeat();
//
//     Future.delayed(const Duration(milliseconds: 700), () {
//       checkCurrentUser();
//     }); // Start the animation
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Opacity(
//               opacity: _animation.value,
//               child: Container(
//                 alignment: Alignment.center,
//                 height: 650.sp,
//                 width: 600.sp,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.grey[200],
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 10,
//                       offset: Offset(0, 0),
//                     ),
//                   ],
//                 ),
//                 child: Image.asset('assets/textile_calculator_logo.png'),
//               ),
//             ),
//             SizedBox(
//               height: 550.sp,
//               width: 550.sp,
//               child: CircularProgressIndicator(
//                 strokeWidth: 3,
//                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.black38),
//                 backgroundColor: Colors.grey[300],
//                 value: _animation.value,
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: SizedBox(
//                 width: 1500.w,
//                 height: 250.h,
//                 child: Column(
//                   children: [
//                     Text(
//                       'Designed By ',
//                       style: TextStyle(
//                         fontSize: 60.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                     // SizedBox(height: 0.01.sh),
//                     Image.asset(
//                       'assets/kt_text.png',
//                       height: 120.h,
//                       // width: 0.08.sh,
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
