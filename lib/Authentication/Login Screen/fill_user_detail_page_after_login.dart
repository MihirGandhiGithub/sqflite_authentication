import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kt1_textile_calculation/Constants/Global_Widgets/Appbar/appbar_with_text.dart';
import 'package:kt1_textile_calculation/Screens/Home_page/home_page.dart';

import '../../Constants/Global_Widgets/TextFormField/custom_text_form_field.dart';

class AddDetailPage extends StatefulWidget {
  const AddDetailPage({super.key});

  @override
  State<AddDetailPage> createState() => _AddDetailPageState();
}

class _AddDetailPageState extends State<AddDetailPage> {
  final _numberRegex = RegExp(r'^\d{10}$');
  String? _numberError;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _contactNumber = TextEditingController();

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

  bool isLoading = false;
  Future<void> updateUserData(String newName, String contactNumber) async {
    try {
      setState(() {
        isLoading = true;
      });
      User? user = _auth.currentUser;
      DocumentReference userRef = _firestore.collection('users').doc(user!.uid);

      await userRef.update({'name': newName, 'contactNumber': contactNumber});

      // SnackBar snackBar =
      //     const SnackBar(content: Text('value sucessfully updated'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Future.delayed(const Duration(milliseconds: 200), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) =>
              false, // Remove all previous routes from the stack
        );
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      SnackBar snackBar =
          SnackBar(content: Text('Error Connecting DataBase: $e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // TODO
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWithText(
        appbarText: 'Upadate User Detail',
        centerTitle: false,
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
                    margin: EdgeInsets.only(top: 50.h, bottom: 50.h),
                    child: Text('Fill The Detail',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 70.sp, color: Colors.black)),
                  ),

                  // user Data
                  Container(
                    margin: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 50.h, bottom: 50.h),
                    child: Column(
                      children: [
                        //Name
                        TextFormFieldWidget(
                          controller: _nameController,
                          errorText: null,
                          onChanged: (value) {},
                          icon: const Icon(Icons.person),
                          labelText: 'Name',
                          isLastField: false,
                          obscureText: false,
                          numberKeyboard: false,
                          enabled: true,
                        ),

                        //Email
                        TextFormFieldWidget(
                          controller: _emailController,
                          errorText: null,
                          onChanged: (value) {},
                          icon: const Icon(Icons.email),
                          labelText: 'Email',
                          isLastField: false,
                          obscureText: false,
                          numberKeyboard: false,
                          enabled: false,
                        ),

                        //Contact No
                        TextFormFieldWidget(
                          controller: _contactNumber,
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
                          icon:
                              const Icon(Icons.quick_contacts_dialer_outlined),
                          labelText: 'Enter Conatct Number',
                          isLastField: true,
                          obscureText: false,
                          numberKeyboard: true,
                          enabled: true,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.only(left: 200.w, right: 200.w, top: 40.h),
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              // backgroundColor: const Color.fromRGBO(23, 35, 255, 1.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.sp),
                              ),
                            ),
                            onPressed: () {
                              if (_nameController.text.isNotEmpty &&
                                  _numberError == null &&
                                  _contactNumber.text.isNotEmpty) {
                                // Proceed with registration since there are no errors in any field
                                // Add your registration logic here
                                updateUserData(
                                  _nameController.text,
                                  _contactNumber.text,
                                );

                                // print('Registering user...');
                                // Continue with the registration process
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
                            },
                            child: Text(
                              'Save & Next',
                              style: TextStyle(
                                  fontSize: 60.sp, color: Colors.white),
                            ),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
