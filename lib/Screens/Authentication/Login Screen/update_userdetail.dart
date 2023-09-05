import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kt1_textile_calculation/Constants/Global_Widgets/Appbar/appbar_with_text.dart';

import '../../../Constants/Global_Variables/variables/variables.dart';
import '../../../Constants/Global_Widgets/Text/CustomText.dart';
import '../../../Constants/Global_Widgets/TextFormField/custom_text_form_field.dart';
import '../../../Other Class/auth_services.dart';

class AddDetailPage extends StatefulWidget {
  const AddDetailPage({super.key});

  @override
  State<AddDetailPage> createState() => _AddDetailPageState();
}

class _AddDetailPageState extends State<AddDetailPage> {
  String? _contactError;
  String? _nameError;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumber = TextEditingController();

  bool isLoading = false;
  Future<void> updateUserData(String newName, String contactNumber) async {
    try {
      setState(() {
        isLoading = true;
      });

      DocumentReference userRef = CustomAuthService.firestore
          .collection('users')
          .doc(CustomAuthService.user!.uid);

      await userRef.update({'name': newName, 'contactNumber': contactNumber});
      setState(() {
        UserData.userName = newName;
        UserData.userPhoneNumber = contactNumber;
      });

      Future.delayed(const Duration(milliseconds: 200), () {
        Navigator.pushReplacementNamed(context, '/home_screen');
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
    _nameController.text = UserData.userName;
    _emailController.text = UserData.userEmail;
    _contactNumber.text = UserData.userPhoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWithText(
        appbarText: 'Upadate User Detail',
        centerTitle: true,
        isBackButton: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Edit Switch
                Padding(
                  padding: EdgeInsets.only(top: 50.h, bottom: 50.h),
                  child: const CustomText(
                    text: 'Please Fill Below Detail',
                    color: Colors.black,
                    maxLine: 1,
                    bold: false,
                  ),
                ),

                // user Data
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, top: 50.h, bottom: 50.h),
                  child: Column(
                    children: [
                      //Name
                      CustomTextFormField(
                        controller: _nameController,
                        errorText: _nameError,
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              _nameError = 'Name is required';
                            } else {
                              _nameError = null;
                            }
                          });
                        },
                        icon: const Icon(Icons.person),
                        labelText: 'Name',
                        isLastField: false,
                        obscureText: false,
                        numberKeyboard: false,
                        enabled: true,
                      ),

                      //Email
                      CustomTextFormField(
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
                      CustomTextFormField(
                        controller: _contactNumber,
                        errorText: _contactError,
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              _contactError = 'Contact is required';
                            } else if (!ValidationScripts.contactNumber
                                .hasMatch(value)) {
                              _contactError = 'Invalid Number format';
                            } else {
                              _contactError = null;
                            }
                          });
                        },
                        icon: const Icon(Icons.quick_contacts_dialer_outlined),
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
                            bool alltrue = _nameError == null &&
                                _nameController.text.isNotEmpty &&
                                _contactError == null &&
                                _contactNumber.text.isNotEmpty;
                            if (alltrue) {
                              updateUserData(
                                _nameController.text,
                                _contactNumber.text,
                              );

                              // print('Registering user...');
                              // Continue with the registration process
                            } else {
                              if (_contactNumber.text.isEmpty ||
                                  _contactError != null) {
                                setState(() {
                                  _contactError = 'Please Enter Contact Number';
                                });
                              } else if (_nameController.text.isEmpty ||
                                  _nameError != null) {
                                setState(() {
                                  _nameError = 'Please Enter Name';
                                });
                              }
                            }
                          },
                          child: Text(
                            'Save & Next',
                            style:
                                TextStyle(fontSize: 60.sp, color: Colors.white),
                          ),
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
