import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Advertise/advetise_marque.dart';
import '../../Constants/Global_Variables/variables/variables.dart';
import '../../Constants/Global_Widgets/Appbar/appbar_with_action.dart';
import '../../Constants/Global_Widgets/Text/CustomText.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Check Application New Version Is Avalible Or Not
  NewVersionPlus newVersion = NewVersionPlus();
  bool isImageLoading = false;
  //For Image Slider (Advertise Slider)
  int _currentImageIndex = 0;
  final List<String> imageList = [];
  final List<String> documentid = [];

// Load image URLs from Firestore
  Future<void> _loadImageUrlsFromFirestore() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('advertise link').get();

      // Use a Map to temporarily store the data
      final Map<int, String> tempImageMap = {};
      final Map<int, String> tempDocumentIdMap = {};

      for (final doc in snapshot.docs) {
        final uid = doc.id;
        final index = doc['index'];
        final link = doc['advertise_link'];
        final int? indexInt = int.tryParse(index);

        if (indexInt != null && indexInt >= 0) {
          setState(() {
            tempImageMap[indexInt] = link;
            tempDocumentIdMap[indexInt] = uid;
          });
        }
      }

      // Clear the existing lists and add the data from the maps
      // imageList.clear();
      // documentid.clear();
      imageList.addAll(List.generate(
          tempImageMap.length, (index) => tempImageMap[index] ?? ''));
      documentid.addAll(List.generate(
          tempDocumentIdMap.length, (index) => tempDocumentIdMap[index] ?? ''));
    } catch (e) {
      // Handle any errors that may occur during the fetch process
      // print('Error fetching image URLs: $e');
    }
  }

  final CarouselController _controller = CarouselController();

  Future<void> _checkUpdate() async {
    final VersionStatus? versionStatus = await newVersion.getVersionStatus();
    if (versionStatus!.canUpdate) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const CustomText(
                text: 'New Update Available',
                color: Colors.black,
                maxLine: 1,
                bold: false,
              ),
              content: const CustomText(
                text:
                    'A new version of the app is available. Please update to the latest version.',
                color: Colors.black,
                maxLine: 2,
                bold: false,
              ),
              actions: [
                ElevatedButton(
                  child: const CustomText(
                    text: 'Update',
                    color: Colors.black,
                    maxLine: 1,
                    bold: false,
                  ),
                  onPressed: () {
                    // Launch the Play Store URL to open the app page
                    _launchAppUrl();
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Future<void> _launchAppUrl() async {
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

  @override
  Future setPageName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  void initState() {
    super.initState();
    //Check the update of application from playstore
    _checkUpdate();
    // Call the method to load image URLs from Firestore
    _loadImageUrlsFromFirestore();
    setPageName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarWithAction(
          appbarText: 'Textile Calculator',
          appbarIcon: Icons.settings,
          appbarIconOnPress: () =>
              Navigator.of(context).pushNamed('/profile_screen'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Image Advertise
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: CarouselSliderWidget(
                  imageList: imageList,
                  carouselController: _controller,
                  currentImageIndex: _currentImageIndex,
                  onPageChangedCallback: onPageChangedCallback,
                  doumentid: documentid,
                  name: UserData.userName,
                  email: UserData.userEmail,
                  contact: UserData.userPhoneNumber,
                ),
              ),
            ),

            // Welcome Text
            CustomText(
              text: 'Welcome ${UserData.userName}'.toUpperCase(),
              color: Colors.black,
              maxLine: 1,
              bold: false,
            ),

            // Space Between Text And Box
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: liked.likedItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomListTile(
                    // Pass the index to CustomListTile
                    index: index,
                    name: liked.likedItems[index]['Name'],
                    imageUrl: liked.likedItems[index]['imageUrl'],
                    isLiked: false,
                    onPreesed: () => Navigator.of(context).pushReplacementNamed(
                        '/${liked.likedItems[index]['navigatePage']}'),

                    showLikeIcon: index != 0,
                  );
                },
              ),
            )
          ],
        ));
  }
}

class CustomListTile extends StatelessWidget {
  final int index; // Add index parameter
  final Function() onPreesed;
  final String name;
  final String imageUrl;
  final bool isLiked;

  final bool showLikeIcon;

  CustomListTile({
    required this.index, // Accept index parameter
    required this.name,
    required this.imageUrl,
    required this.isLiked,
    required this.onPreesed,
    required this.showLikeIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onPreesed,
        contentPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.blue, width: 0.4),
          borderRadius: BorderRadius.circular(15.0),
        ),
        tileColor: Colors.white,
        leading: SizedBox(
          height: 50,
          width: 60,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(imageUrl),
              ),
            ),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
