import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Constants/Global_Widgets/TextFormField/TextFormField.dart';
import '../Home_page/Home_Page.dart';
import '../Register Screen/RegisterScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _emailError;

  final _emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> checkCurrentUser() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Check if the user already exists in Firestore

      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();

      if (userSnapshot.exists) {
        // User already exists, retrieve their data from Firestore
        final Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          // final String? name = userData['name'];
          // final String? email = userData['email'];
          // final String? contactNumber = userData['contactNumber'];
          //
          // print(name);
          // print(email);
          // print(contactNumber);
          // Load the retrieved user data into the respective fields
          // _nameController.text = name ?? '';
          // _emailController.text = email ?? '';
          // _contactController.text = contactNumber ?? '';
        }
      } else {
        // User does not exist in Firestore, proceed with creating a new user document
        final String? name = googleUser.displayName;
        final String email = googleUser.email;
        const String contactNumber =
            ""; // Add the logic to get the contact number

        // Create a document with a unique identifier in the "users" collection
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'name': name,
          'email': email,
          'contactNumber': contactNumber,
        });
      }

      // Successful sign-in with Google
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (error) {
      // Sign-in with Google failed
      // Display an error message or perform appropriate error handling
      SnackBar snackBar =
          SnackBar(content: Text('Error signing in with Google: $error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    // print('/n /n /n /n /n /n');
    // print(email);
    try {
      // Check if the user exists
      final user = await _auth.fetchSignInMethodsForEmail(email);
      if (user.isEmpty) {
        // User does not exist, display a snackbar message
        const snackBar = SnackBar(
          content: Text('User does not exist.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      await _auth.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      // Display a success message or navigate to a confirmation screen
      SnackBar snackBar =
          const SnackBar(content: Text('Password reset email sent'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (error) {
      // Error sending password reset email
      // Display an error message or perform appropriate error handling

      SnackBar snackBar =
          SnackBar(content: Text('Error sending password reset email: $error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void forgotPasswordButtonPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String email = '';

        return AlertDialog(
          elevation: 10,
          title: Text(
            'Forgot Password',
            style: TextStyle(color: Colors.black, fontSize: 60.sp),
          ),
          content: TextField(
            style: TextStyle(color: Colors.black, fontSize: 50.sp),
            cursorHeight: 60.sp,
            onChanged: (value) {
              setState(() {
                email = value;
              });

              // print(email);
              // print('\n \n \n \n');
              // print(value);
            },
            decoration: const InputDecoration(
              labelText: 'Enter your email',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Validate the email address
                // Call the sendPasswordResetEmail method
                // if (email.isEmpty || isValidEmail(email)) {
                //   final snackBar = SnackBar(
                //     content: Text('Please enter a valid email address.'),
                //   );
                //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //   return;
                // }
                // print(email);

                sendPasswordResetEmail(email);
                Navigator.of(context).pop();
              },
              child: Text('Send Reset Link',
                  style: TextStyle(color: Colors.blue, fontSize: 50.sp)),
            ),
          ],
        );
      },
    );
  }

// Helper method to validate email format
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  //Login Using Firebase
  Future<void> loginUser(BuildContext context) async {
    try {
      String email = _nameController.text.trim();
      String password = _passwordController.text;

      // UserCredential userCredential
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Login successful, navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (error) {
      // Login failed, handle the error (e.g., display an error message)
      SnackBar snackBar = SnackBar(content: Text('Login error: $error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool _obscureText = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    void loginButtonPressed() {
      if (_emailError == null && _passwordController.text.isNotEmpty) {
        loginUser(context);
      } else {
        SnackBar snackBar =
            SnackBar(content: Text('Please fill detial without error'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          color: Colors.grey[300],
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              // Logo
              Container(
                margin: EdgeInsets.only(top: 200.h, bottom: 50.h),
                height: 400.sp,
                width: 400.sp,
                child: Image.asset('assets/textile_calculator_logo.png'),
              ),

              // Welcome Text
              Container(
                margin: EdgeInsets.only(bottom: 50.h),
                alignment: Alignment.center,
                child: Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 100.sp, color: Colors.black),
                ),
              ),

              // Login Text and content
              Form(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50.sp),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 20.sp,
                            offset: const Offset(0, 0),
                            color: Colors.grey)
                      ]),
                  margin: EdgeInsets.only(left: 50.w, right: 50.w),
                  height: 1400.h,
                  padding: EdgeInsets.only(
                      top: 50.h, bottom: 20.h, left: 50.w, right: 50.w),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      //Login Text
                      Container(
                        margin: EdgeInsets.only(bottom: 70.h),
                        alignment: Alignment.center,
                        child: Text(
                          'Login Here',
                          style:
                              TextStyle(color: Colors.black, fontSize: 80.sp),
                        ),
                      ),

                      // Email
                      TextFormFieldWidget(
                        controller: _nameController,
                        errorText: _emailError,
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              _emailError = 'Email is required';
                            } else if (!_emailRegex.hasMatch(value)) {
                              _emailError = 'Invalid email format';
                            } else {
                              _emailError = null;
                            }
                          });
                        },
                        icon: Icon(Icons.email_outlined),
                        labelText: 'Enter Email',
                        isLastField: false,
                        obscureText: false,
                      ),

                      //Password
                      TextFormFieldWidget(
                        controller: _passwordController,
                        errorText: null,
                        obscureText: _obscureText,
                        onChanged: (value) {},
                        icon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        labelText: 'Enter Password',
                        isLastField: true,
                      ),

                      //Forgot Password
                      Container(
                          margin: EdgeInsets.only(top: 20.h, bottom: 50.h),
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              onTap: forgotPasswordButtonPressed,
                              child: Text(
                                'Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 40.sp, color: Colors.black),
                              ))),

                      //Login Button
                      Container(
                        margin: EdgeInsets.only(left: 100.w, right: 100.w),
                        height: 150.h,
                        child: ElevatedButton(
                          onPressed: loginButtonPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey, // Background color
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 70.sp),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 50.h,
                      ),

                      //OR Text
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            '----------- or ----------',
                            style:
                                TextStyle(fontSize: 50.sp, color: Colors.black),
                          )),

                      SizedBox(
                        height: 10.h,
                      ),

                      //Sign in with google
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          height: 120.h,
                          margin: EdgeInsets.only(left: 300.w, right: 300.w),
                          child: TextButton(
                              onPressed: signInWithGoogle,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon(Icons.g_mobiledata),
                                  Image.asset('assets/google_signin_logo.png'),
                                  SizedBox(
                                    width: 40.w,
                                  ),
                                  Text(
                                    'Signin With Google',
                                    style: TextStyle(
                                        fontSize: 40.sp, color: Colors.black),
                                  ),
                                ],
                              ))),

                      SizedBox(
                        height: 10.h,
                      ),

                      //Register Button
                      Container(
                        margin: EdgeInsets.only(left: 200.w, right: 200.w),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Not a User ?',
                                  style: TextStyle(
                                      fontSize: 50.sp, color: Colors.black),
                                ),
                                Text(
                                  ' Create Account',
                                  style: TextStyle(
                                      fontSize: 50.sp, color: Colors.blue),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
