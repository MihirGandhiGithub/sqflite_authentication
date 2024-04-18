import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kt1_textile_calculation/Screens/Home_page/home_page.dart';
import 'package:kt1_textile_calculation/Screens/Splash%20Screen/splashscreen.dart';
import 'package:flutter/services.dart';
import 'AdminPanel/admin_panel_home_page.dart';
import 'Screens/Authentication/Login Screen/login_page.dart';
import 'Screens/Authentication/Login Screen/update_userdetail.dart';
import 'Screens/Authentication/Register Screen/register_page.dart';
import 'Screens/Sub Screens/1 Ginning_Calculator/singal_ginning.dart';
import 'Screens/Sub Screens/2 Dabit_Note/cotton_dabit_note.dart';
import 'Screens/Sub Screens/3 Exports_Calculation/singal_export.dart';
import 'Screens/Sub Screens/4 Oil_Mill_Calculator/singal_oilmill.dart';
import 'Screens/Sub Screens/5 Spinning_Calculator/singal_spinning.dart';
import 'Screens/Sub Screens/6 Conversation_Calculation/home_singal_conversation_calculator.dart';
import 'Screens/Sub Screens/7 Staple Conversation Chart/staple_conversation_chart.dart';
import 'Screens/Sub Screens/8 Conversation Factor/conversation_factor.dart';
import 'Screens/Sub Screens/9 Cotton Quality/cotton_quality_chart.dart';
import 'Screens/User_Profile/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the provided configuration
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //   apiKey: "AIzaSyBypTGGDxYN9kDATEco2NSMLHsfRsjXyrc",
      //   authDomain: "textile-calculator-80988.firebaseapp.com",
      //   databaseURL:
      //       "https://textile-calculator-80988-default-rtdb.firebaseio.com",
      //   projectId: "textile-calculator-80988",
      //   storageBucket: "textile-calculator-80988.appspot.com",
      //   messagingSenderId: "625365097680",
      //   appId: "1:625365097680:web:130105795bf563a3a012d5",
      //   measurementId: "G-01R92KRRP4",
      // ),
      );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(1440, 2560),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          // restorationScopeId: 'roots',
          theme: ThemeData(
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
              foregroundColor: Colors.white, //<-- SEE HERE
            ),
          ),
          debugShowCheckedModeBanner: false,
          title: 'Textile Calculator',

          initialRoute: '/splash_screen',
          routes: {
            '/splash_screen': (context) => const SplashScreen(),
            '/login_screen': (context) => const LoginPage(),
            '/register_screen': (context) => const RegisterScreen(),
            '/home_screen': (context) => const HomePage(),
            '/adminPanel_home': (context) => const AdminPanelHome(),
            '/AddDetail_screen': (context) => const AddDetailPage(),
            '/profile_screen': (context) => const Profile(),
            '/ginning_screen': (context) => const HomeSingalGinningCalculator(),
            '/spinning_screen': (context) => const HomeSpinningCalculator(),
            '/oilmill_screen': (context) => const HomeSingalOilMillCalculator(),
            '/export_screen': (context) => const HomeExportCalculation(),
            '/dabitnote_screen': (context) => const HomeDabietCalculation(),
            '/conversation_screen': (context) =>
                const HomeSingalConversationCalulator(),
            '/stapleconvert_screen': (context) =>
                const StapleConversationChart(),
            '/cottonfactor_screen': (context) => const ConversationFactor(),
            '/cottonqulity_screen': (context) => const CottonQualityChart(),
          },
        );
      },
    );
  }
}
