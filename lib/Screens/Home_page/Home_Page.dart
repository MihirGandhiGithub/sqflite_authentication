import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/Global_Variables/colors/colors.dart';
import '../../Constants/Global_Widgets/Buttons/image_text.dart';
import '../Sub Screens/1 Ginning_Calculator/singal_ginning.dart';
import '../Sub Screens/2 Oil_Mill_Calculator/singal_oilmill.dart';
import '../Sub Screens/3 Spinning_Calculator/singal_spinning.dart';
import '../Sub Screens/4 Exports_Calculation/Home_Export_Calculation.dart';
import '../Sub Screens/5 Conversation_Calculation/Home_Singal_Conversation_Calculator.dart';
import '../Sub Screens/6 ICE_Parity_Chart/Home_ICE_Parity_Chart.dart';
import '../Sub Screens/7 Staple Conversation Chart/Staple Conversation Chart.dart';
import '../User_Profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String release = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userName = '';

  @override
  void initState() {
    super.initState();
    loadUserName();
    checkForUpdates();
  }

  Future<void> loadUserName() async {
    User? user = _auth.currentUser;
    _firestore.collection('users').doc(user!.uid).get().then((value) {
      setState(() {
        userName = value.data()!['name'].toString();
        // print(userName);
      });
    });
  }

  Future<void> checkForUpdates() async {
    final VersionStatus? versionStatus = await newVersion.getVersionStatus();
    if (versionStatus!.canUpdate) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(
                'New Update Available',
                style: TextStyle(color: Colors.black, fontSize: 50.sp),
              ),
              content: Text(
                'A new version of the app is available. Please update to the latest version.',
                style: TextStyle(color: Colors.black, fontSize: 40.sp),
              ),
              actions: [
                ElevatedButton(
                  child: Text(
                    'Update',
                    style: (TextStyle(color: Colors.white, fontSize: 40.sp)),
                  ),
                  onPressed: () {
                    // Launch the Play Store URL to open the app page
                    _launchAppStoreUrl();
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Future<void> _launchAppStoreUrl() async {
    const String packageName = 'mg.kingtechnology.in.kt1_textile_calculation';
    final Uri playStoreUrl = Uri.https(
        'play.google.com', '/store/apps/details', {'id': packageName});

    if (await canLaunchUrl(playStoreUrl)) {
      await launchUrl(playStoreUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $playStoreUrl';
    }
  }

  NewVersionPlus newVersion = NewVersionPlus();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Textile Calculator',
              style: TextStyle(fontSize: 90.sp, color: Colors.black)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(150.sp),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 100.sp,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
            )
          ],
          backgroundColor: universalGray,
          elevation: 2,
          // flexibleSpace: Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     margin: EdgeInsets.fromLTRB(0, 0, 0, 20.sp),
          //     height: 120.h,
          //     width: 1000.w,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(150.sp),
          //       color: Colors.grey[300],
          //     ),
          //     child: Container(
          //       padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.black),
          //         borderRadius: BorderRadius.circular(100.sp),
          //       ),
          //       child: DropdownButton(
          //         isExpanded: true,
          //         isDense: true,
          //
          //         underline: Container(),
          //         value: _selectedItem,
          //         items: _dropdownItems.map((item) {
          //           return DropdownMenuItem(
          //             value: item,
          //             child: Text(
          //               item,
          //             ),
          //           );
          //         }).toList(),
          //         onChanged: (newValue) {
          //           setState(() {
          //             _selectedItem = newValue!;
          //           });
          //         },
          //         style: const TextStyle(
          //             color: Colors.black), // Set the text color
          //         iconEnabledColor: Colors.black, // Set the arrow icon color
          //         dropdownColor: Colors.white, // Set the dropdown menu color
          //       ),
          //     ),
          //   ),
          // ),
        ),
        body: Column(
          children: [
            SizedBox(height: 50.h),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Welcome $userName',
                style: TextStyle(fontSize: 80.sp, color: Colors.black),
              ),
            ),
            SizedBox(height: 50.h),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 50.w, right: 50.w),
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  childAspectRatio: (400.sp / 500.sp),
                  crossAxisCount: 3,
                  crossAxisSpacing: 70.sp,
                  mainAxisSpacing: 40.h,
                  children: [
                    HomePageBoxContainer(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const HomeSingalGinningCalculator(),
                          ),
                        );
                      },
                      imageAsset: 'assets/ginning_logo.png',
                      buttonText: 'Ginning Calculator',
                    ),
                    HomePageBoxContainer(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const HomeSingalOilMillCalculator(),
                          ),
                        );
                      },
                      imageAsset: 'assets/oilmill_logo.png',
                      buttonText: 'Oil Mill Calculator',
                    ),
                    HomePageBoxContainer(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const HomeSpinningCalculator(),
                          ),
                        );
                      },
                      imageAsset: 'assets/spinning_logo.png',
                      buttonText: 'Spinning Calculator',
                    ),
                    HomePageBoxContainer(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeExportCalculation(),
                          ),
                        );
                      },
                      imageAsset: 'assets/export_logo.png',
                      buttonText: 'Exports Calculation',
                    ),
                    HomePageBoxContainer(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HomeSingalConversationCalulator()));
                      },
                      imageAsset: 'assets/conversation_logo.png',
                      buttonText: 'Conversation',
                    ),
                    HomePageBoxContainer(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeICEParityChart(),
                          ),
                        );
                      },
                      imageAsset: 'assets/ICEparity_logo.png',
                      buttonText: 'ICE Parity Chart',
                    ),
                    HomePageBoxContainer(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    StapleConversationChart()));
                      },
                      imageAsset: 'assets/staple_logo.png',
                      buttonText: 'Staple Conversation',
                    ),
                    HomePageBoxContainer(
                      onPressed: () {},
                      imageAsset: 'assets/dictionary.png',
                      buttonText: 'Coming Soon..',
                    ),
                    HomePageBoxContainer(
                      onPressed: () {},
                      imageAsset: 'assets/only_kt_logo.png',
                      buttonText: 'Coming Soon..',
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
