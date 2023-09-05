import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kt1_textile_calculation/Constants/Global_Widgets/Appbar/appbar_with_text.dart';
import 'package:share_plus/share_plus.dart';
import '../../Authentication/Login Screen/login_page.dart';
import '../../Constants/Global_Widgets/TextFormField/custom_text_form_field.dart';
import '../../webview/webview.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumber = TextEditingController();

  final TextEditingController _nullController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _loading = false;

  String userNamed = '';
  String userEmail = '';
  String userContact = '';
  Future<void> loadUserName() async {
    User? user = _auth.currentUser;
    await _firestore.collection('users').doc(user!.uid).get().then((value) {
      setState(() {
        _nameController.text = userNamed = value.data()!['name'].toString();
        _emailController.text = userEmail = value.data()!['email'].toString();
        _contactNumber.text =
            userContact = value.data()!['contactNumber'].toString();
        // print(userNamed);
      });
    });
  }

  // final _links = ['https://camellabs.com'];
  final _numberRegex = RegExp(r'^\d{10}$');
  String? _numberError;
  Future<void> updateUserData(
      String newName, String newEmail, String contactNumber) async {
    User? user = _auth.currentUser;
    DocumentReference userRef = _firestore.collection('users').doc(user!.uid);

    await userRef.update(
        {'name': newName, 'email': newEmail, 'contactNumber': contactNumber});

    SnackBar snackBar =
        const SnackBar(content: Text('value sucessfully updated'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {
      edit = false;
    });
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> logout() async {
    try {
      await _auth.signOut();

      // Sign out from Google account
      await googleSignIn.signOut();

      // Clear the current authentication state
      // await googleSignIn.disconnect();

      // Navigate back to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (error) {
      SnackBar snackBar = SnackBar(content: Text('Logout error: $error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  final String linkToShare =
      'https://play.google.com/store/apps/details?id=mg.kingtechnology.in.kt1_textile_calculation&pcampaignid=web_share'; // Replace this with your desired link
  final String textToShare =
      'King Textile Calculator'; // Replace this with your desired text

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserName();
  }

  bool edit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppbarWithText(
        appbarText: 'Settings',
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                //Edit Switch
                Container(
                  margin: EdgeInsets.only(left: 50.w, right: 50.w, top: 50.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.black, fontSize: 70.sp),
                      ),
                      SizedBox(
                        height: 120.h,
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    edit ? Colors.grey : Colors.blue),
                            onPressed: () {
                              setState(() {
                                edit = !edit;
                              });
                            },
                            icon: const Icon(Icons.edit_calendar_outlined),
                            label: const Text('Edit')),
                      ),
                    ],
                  ),
                ),

                // user Data
                Container(
                  margin: EdgeInsets.only(
                      left: 20.w, right: 20.w, top: 50.h, bottom: 50.h),
                  child: Column(
                    children: [
                      //Name
                      TextFormFieldWidget(
                        controller: edit ? _nameController : _nullController,
                        errorText: null,
                        onChanged: (value) {},
                        icon: const Icon(Icons.person),
                        labelText:
                            edit ? 'Name' : 'Name : ${_nameController.text}',
                        isLastField: false,
                        obscureText: false,
                        numberKeyboard: false,
                        enabled: edit,
                      ),

                      //Email
                      TextFormFieldWidget(
                        controller: _nullController,
                        errorText: null,
                        onChanged: (value) {},
                        icon: const Icon(Icons.email),
                        labelText: 'Email : ${_emailController.text}',
                        isLastField: false,
                        obscureText: false,
                        numberKeyboard: false,
                        enabled: false,
                      ),

                      //Contact No
                      TextFormFieldWidget(
                        controller: edit ? _contactNumber : _nullController,
                        errorText: _numberError,
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              _numberError = 'Contact is required';
                            } else if (!_numberRegex.hasMatch(value)) {
                              _numberError = 'Invalid Number format';
                            } else {
                              _numberError = null;
                            }
                          });
                        },
                        icon: const Icon(Icons.quick_contacts_dialer_outlined),
                        labelText: edit
                            ? 'Contact No.'
                            : 'Contact No. : +91 ${_contactNumber.text}',
                        isLastField: true,
                        obscureText: false,
                        numberKeyboard: true,
                        enabled: edit,
                      ),
                    ],
                  ),
                ),

                edit
                    ? Container(
                        margin: EdgeInsets.only(
                            left: 100.w, right: 100.w, bottom: 50.h),
                        height: 150.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70.sp),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _loading = true;
                            });
                            try {
                              if (_nameController.text.isNotEmpty &&
                                  _numberError == null &&
                                  _contactNumber.text.isNotEmpty) {
                                // Proceed with registration since there are no errors in any field
                                // Add your registration logic here
                                await updateUserData(_nameController.text,
                                    _emailController.text, _contactNumber.text);
                              } else {
                                if (_contactNumber.text.isEmpty) {
                                  SnackBar snackBar = const SnackBar(
                                      content:
                                          Text('Please Enter Contact Number.'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  SnackBar snackBar = const SnackBar(
                                      content: Text(
                                          'Please Fill Detail And Fix Error before Save Data.'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            } catch (error) {
                              rethrow;
                            } finally {
                              setState(() {
                                _loading = false;
                              });
                            }
                          },
                          child: _loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Save Data',
                                  style: TextStyle(
                                      fontSize: 50.sp, color: Colors.white),
                                ),
                        ),
                      )
                    : const SizedBox(),

                Container(
                  margin:
                      EdgeInsets.only(left: 40.w, right: 40.w, bottom: 30.h),
                  // color: Colors.grey[300],
                  height: 150.h,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Share.share(
                        '$textToShare\n$linkToShare',
                        subject:
                            'Snapshot From Textile Calculator', // Subject is optional
                      );
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Share App'),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 40.w, right: 40.w, bottom: 20.h),
                  color: Colors.grey[300],
                  height: 150.h,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebView(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    contact: _contactNumber.text,
                                  )));
                    },
                    icon: SizedBox(
                      height: 100.sp,
                      child: Image.asset(
                        'assets/only_kt_logo.png',
                      ),
                    ),
                    label: const Text(
                      'About Us',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logout
                SizedBox(
                  height: 150.h,
                  child: ElevatedButton(
                    onPressed: logout,
                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 60.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
