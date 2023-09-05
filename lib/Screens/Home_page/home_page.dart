import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Advertise/advetise_marque.dart';
import '../../Constants/Global_Widgets/Appbar/appbar_with_action.dart';
import '../../Constants/Global_Widgets/Buttons/image_text.dart';
import '../../Constants/Global_Widgets/navigate_page_with_animation.dart';
import '../Sub Screens/1 Ginning_Calculator/singal_ginning.dart';
import '../Sub Screens/2 Oil_Mill_Calculator/singal_oilmill.dart';
import '../Sub Screens/3 Spinning_Calculator/singal_spinning.dart';
import '../Sub Screens/4 Exports_Calculation/singal_export.dart';
import '../Sub Screens/5 Conversation_Calculation/home_singal_conversation_calculator.dart';
import '../Sub Screens/6 ICE_Parity_Chart/ice_parity_chart.dart';
import '../Sub Screens/7 Staple Conversation Chart/staple_conversation_chart.dart';
import '../Sub Screens/8 Conversation Factor/conversation_factor.dart';
import '../Sub Screens/9 Cotton Quality/cotton_quality_chart.dart';
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

  final List<String> imageList = [];
  final List<String> documentid = [];
  // Method to load image URLs from Firestore based on the index key

  Future<void> loadImageUrlsFromFirestore() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('advertise link')
          .get(); // Get the documents from the 'advertise link' collection

      // Clear the lists before updating them with new data
      imageList.clear();
      documentid.clear();

      // Update the imageList with the URLs from the Firestore documents
      for (final doc in snapshot.docs) {
        final uid = doc.id;
        final index = doc['index']; // Get the index from the 'index' field
        final link = doc[
            'advertise_link']; // Get the image link from the 'advertise_link' field
        final int? indexInt = int.tryParse(index);

        if (indexInt != null && indexInt >= 0) {
          // Make sure the imageList has enough elements to store the links
          if (indexInt >= imageList.length) {
            for (int i = imageList.length; i <= indexInt; i++) {
              imageList.add('');
              documentid.add('');
            }
          }
          setState(() {
            imageList[indexInt] = link;
            documentid[indexInt] = uid;
          });
          // Update the link and uid at the given index
        }
      }

      // Print all data of imageList
      // print('All data of imageList:');
      for (int i = 0; i < imageList.length; i++) {
        // print('Index $i: ${imageList[i]}');
      }
    } catch (e) {
      // Handle any errors that may occur during the fetch process
      // print('Error fetching image URLs: $e');
    }
  }

  String userName = '';
  String eEmail = '';
  String contactnumber = '';

  int _currentImageIndex = 0;
  @override
  void initState() {
    super.initState();
    loadUserName();
    checkForUpdates();
    // Call the method to load image URLs from Firestore
    loadImageUrlsFromFirestore();
  }

  final CarouselController _controller = CarouselController();

  Future<void> loadUserName() async {
    User? user = _auth.currentUser;
    _firestore.collection('users').doc(user!.uid).get().then((value) {
      setState(() {
        userName = value.data()!['name'].toString();
        eEmail = value.data()!['email'].toString();
        contactnumber = value.data()!['contactNumber'].toString();

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

  void onPageChangedCallback(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentImageIndex = index;
    });
  }

  NewVersionPlus newVersion = NewVersionPlus();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarWithAction(
          appbarText: 'Textile Calculator',
          appbarIcon: Icons.settings,
          appbarIconOnPress: () =>
              CustomNavigator().navigateToPage(context, const Profile()),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Image Advertise
              CarouselSliderWidget(
                imageList: imageList,
                carouselController: _controller,
                currentImageIndex: _currentImageIndex,
                onPageChangedCallback: onPageChangedCallback,
                doumentid: documentid,
                name: userName,
                email: eEmail,
                contact: contactnumber,
              ),

              //  Start Main Content
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Welcome $userName'.toUpperCase(),
                  style: TextStyle(fontSize: 60.sp, color: Colors.black),
                ),
              ),
              SizedBox(height: 50.h),
              Container(
                padding: EdgeInsets.only(left: 80.sp, right: 80.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomePageBoxContainer(
                          onPressed: () => CustomNavigator().navigateToPage(
                              context, const HomeSingalGinningCalculator()),
                          imageAsset: 'assets/ginning_logo.png',
                          buttonText: 'Ginning Calculator',
                        ),
                        HomePageBoxContainer(
                          onPressed: () => CustomNavigator().navigateToPage(
                              context, const HomeSingalOilMillCalculator()),
                          imageAsset: 'assets/oilmill_logo.png',
                          buttonText: 'Oil Mill Calculator',
                        ),
                        HomePageBoxContainer(
                          onPressed: () => CustomNavigator().navigateToPage(
                              context, const HomeSpinningCalculator()),
                          imageAsset: 'assets/spinning_logo.png',
                          buttonText: 'Spinning Calculator',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomePageBoxContainer(
                          onPressed: () => CustomNavigator().navigateToPage(
                              context, const HomeExportCalculation()),
                          imageAsset: 'assets/export_logo.png',
                          buttonText: 'Exports Calculation',
                        ),
                        HomePageBoxContainer(
                          onPressed: () => CustomNavigator().navigateToPage(
                              context, const HomeSingalConversationCalulator()),
                          imageAsset: 'assets/conversation_logo.png',
                          buttonText: 'Conversation',
                        ),
                        HomePageBoxContainer(
                          onPressed: () => CustomNavigator().navigateToPage(
                              context, const HomeICEParityChart()),
                          imageAsset: 'assets/ICEparity_logo.png',
                          buttonText: 'ICE Parity Chart',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomePageBoxContainer(
                          onPressed: () => CustomNavigator().navigateToPage(
                              context, const StapleConversationChart()),
                          imageAsset: 'assets/staple_logo.png',
                          buttonText: 'Staple Conversation',
                        ),
                        HomePageBoxContainer(
                          onPressed: () => CustomNavigator().navigateToPage(
                              context, const ConversationFactor()),
                          imageAsset: 'assets/cottonfactor.png',
                          buttonText: 'Coversation Factor',
                        ),
                        HomePageBoxContainer(
                          onPressed: () => CustomNavigator().navigateToPage(
                              context, const CottonQualityChart()),
                          imageAsset: 'assets/cotton_quality.png',
                          buttonText: 'Cotton Quality',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
