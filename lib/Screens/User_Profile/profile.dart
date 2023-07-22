import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kt1_textile_calculation/Screens/Login%20Screen/LoginScreen.dart';

import '../../Constants/Global_Variables/colors/colors.dart';

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

  Future<void> updateUserData(
      String newName, String newEmail, String contactNumber) async {
    User? user = _auth.currentUser;
    DocumentReference userRef = _firestore.collection('users').doc(user!.uid);

    await userRef.update(
        {'name': newName, 'email': newEmail, 'contactNumber': contactNumber});

    SnackBar snackBar =
        const SnackBar(content: Text('value sucessfully updated'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //Update Password
  // Future<void> updatePassword(String oldPassword, String newPassword) async {
  //   User? user = _auth.currentUser;
  //
  //   // Create a credential using the user's email and old password
  //   AuthCredential credential = EmailAuthProvider.credential(
  //     email: user!.email!,
  //     password: oldPassword,
  //   );
  //
  //   try {
  //     // Reauthenticate the user with the provided credential
  //     await user.reauthenticateWithCredential(credential);
  //
  //     // If reauthentication is successful, update the password
  //     await user.updatePassword(newPassword);
  //
  //     print('Password updated successfully.');
  //   } catch (error) {
  //     print('Error updating password: $error');
  //   }
  // }

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
      appBar: AppBar(
        title: Text('Settings',
            style: TextStyle(fontSize: 70.sp, color: Colors.black)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(150.sp),
          ),
        ),
        backgroundColor: universalGray,
        elevation: 2,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Edit Switch
                  Container(
                    margin: EdgeInsets.only(left: 50.w, right: 50.w, top: 50.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit Profile',
                          style:
                              TextStyle(color: Colors.black, fontSize: 70.sp),
                        ),
                        Switch(
                          // This bool value toggles the switch.
                          value: edit,
                          // overlayColor: overlayColor,
                          // trackColor: trackColor,
                          thumbColor: const MaterialStatePropertyAll<Color>(
                              Colors.black),
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              edit = value;
                            });
                          },
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
                        TextFormField(
                          controller: edit ? _nameController : _nullController,
                          style:
                              TextStyle(fontSize: 50.sp, color: Colors.black),
                          cursorHeight: 80.sp,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            labelText: edit ? 'Name' : 'Name :- $userNamed',
                            enabled: edit,
                            labelStyle: TextStyle(fontSize: 60.sp),
                          ),
                          textInputAction: TextInputAction.next,
                        ),

                        SizedBox(
                          height: 50.h,
                        ),
                        //Email
                        TextFormField(
                          controller: edit ? _emailController : _nullController,
                          style:
                              TextStyle(fontSize: 50.sp, color: Colors.black),
                          cursorHeight: 80.sp,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            labelText:
                                edit ? 'Email' : 'Email Id :- $userEmail',
                            enabled: edit,
                            labelStyle: TextStyle(fontSize: 60.sp),
                          ),
                          textInputAction: TextInputAction.next,
                        ),

                        SizedBox(
                          height: 50.h,
                        ),

                        //Contact No
                        TextFormField(
                          controller: edit ? _contactNumber : _nullController,
                          style:
                              TextStyle(fontSize: 50.sp, color: Colors.black),
                          cursorHeight: 80.sp,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            labelText: edit
                                ? 'Contact'
                                : 'Contact No. :- 91 $userContact',
                            enabled: edit,
                            labelStyle: TextStyle(fontSize: 60.sp),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                  ),

                  edit
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              updateUserData(_nameController.text,
                                  _emailController.text, _contactNumber.text);
                            },
                            child: Ink(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 200.w, right: 200.w, top: 40.h),
                                height: 170.h,
                                decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(70.sp)),
                                alignment: Alignment.center,
                                child: Text(
                                  'Save Data',
                                  style: TextStyle(
                                      fontSize: 60.sp, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),

            //Logout Button
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: logout,
                child: Ink(
                  child: Container(
                    height: 170.h,
                    color: Colors.grey[500],
                    alignment: Alignment.center,
                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 60.sp, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
