import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../AdminPanel/admin_panel_home_page.dart';
import '../../Constants/Global_Widgets/TextFormField/custom_text_form_field.dart';
import '../../Screens/Home_page/home_page.dart';
import '../Login Screen/fill_user_detail_page_after_login.dart';
import '../Login Screen/login_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String? _emailError;
  String? _numberError;
  String? _passwordError;

  bool isLoading = false;
  final _passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,}$');
  final _emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
  final _numberRegex = RegExp(r'^\d{10}$');
  // final _numberRegex = RegExp(r'^[0-9]+$');
  //sign in with google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              height: 150.h,
              alignment: Alignment.center,
              // Set the desired height here
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            ),
          );
        },
      );

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

      // ... Rest of the code for checking and creating user data ...
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (userSnapshot.exists) {
        // User already exists, retrieve their data from Firestore
        final Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          // Check if the 'admin' field exists in the userData map
          bool isAdmin = userData['admin'] ?? false;

          if (isAdmin) {
            await prefs.setString('admin', 'true');
            // Navigate to the admin home screen
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AdminPanelHome()),
              (Route<dynamic> route) =>
                  false, // Remove all previous routes from the stack
            );
          } else {
            await prefs.setString('admin', 'false');

            // Check if any required fields are empty
            final String? name = userData['name'];
            final String? email = userData['email'];
            final String? contactNumber = userData['contactNumber'];

            if (name == null ||
                email == null ||
                contactNumber == null ||
                contactNumber.isEmpty) {
              // If any required field is empty, move to add detail page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AddDetailPage()),
                (Route<dynamic> route) =>
                    false, // Remove all previous routes from the stack
              );
            } else {
              // All required fields are present, move to home page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) =>
                    false, // Remove all previous routes from the stack
              );
            }
          }
        }
      } else {
        // User does not exist in Firestore, proceed with creating a new user document
        final String? name = googleUser.displayName;
        final String email = googleUser.email;
        // const String contactNumber = ""; // No need to set this here

        // Create a document with a unique identifier in the "users" collection
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'name': name,
          'email': email,
          'contactNumber': ''
          // 'contactNumber': contactNumber, // No need to set this here
        });

        // Remove the loading dialog
        Navigator.of(context, rootNavigator: true).pop();
        // Move to add detail page since some fields are empty
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AddDetailPage()),
          (Route<dynamic> route) =>
              false, // Remove all previous routes from the stack
        );
      }
    } catch (error) {
      // Sign-in with Google failed
      // Display an error message or perform appropriate error handling
      // Remove the loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      SnackBar snackBar =
          SnackBar(content: Text('Error signing in with Google: $error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  //register to firebase with custom fields
  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      final String name = _nameController.text.trim();
      final String email = _emailController.text.trim();
      final String contactNumber = _contactController.text.trim();
      final String password = _passwordController.text;

      // Check if the user already exists in Firestore
      final QuerySnapshot existingUsers = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (existingUsers.docs.isNotEmpty) {
        // User already exists, load their data from Firestore
        final DocumentSnapshot userSnapshot = existingUsers.docs.first;
        final Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          // Load the user's data into the respective fields
          _nameController.text = userData['name'];
          _contactController.text = userData['contactNumber'];
        }

        // Display a message indicating that the user already exists
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('User Already Exists'),
              content: Text('User with email $email already exists.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Create the user with email and password
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Get the user ID
        final String userId = userCredential.user!.uid;

        // Store additional user details in Firestore
        await _firestore.collection('users').doc(userId).set({
          'name': name,
          'email': email,
          'contactNumber': contactNumber,
        });

        // Registration successful, do something (e.g., navigate to the home screen)
        // Replace `HomeScreen()` with your desired destination
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) =>
              false, // Remove all previous routes from the stack
        );
      }
    } catch (error) {
      // Registration failed, handle the error (e.g., display an error message)

      SnackBar snackBar = SnackBar(content: Text('Registration error: $error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void registerButtonPressed() {
      if (_nameController.text.isNotEmpty &&
          _emailError == null &&
          _numberError == null &&
          _passwordError == null) {
        setState(() {
          isLoading = true;
        });
        // Proceed with registration since there are no errors in any field
        // Add your registration logic here
        Future.delayed(const Duration(milliseconds: 200), () {
          registerUser();
        });

        // print('Registering user...');
        // Continue with the registration process
      } else {
        if (_nameController.text.isEmpty) {
          SnackBar snackBar =
              const SnackBar(content: Text('Please Enter Name.'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          SnackBar snackBar = const SnackBar(
              content: Text('Please fix all errors before registering.'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }

    return Scaffold(
      body: CustomPaint(
        painter: CustomDividerPainter(),
        child: SafeArea(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              // Logo
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.sp),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 5,
                          offset: Offset(0, 0),
                          color: Colors.black)
                    ]),
                margin: EdgeInsets.only(
                    left: 50.w, right: 50.w, top: 100.h, bottom: 50.h),
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: 50.h, bottom: 20.h, left: 50.w, right: 50.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 120.h, bottom: 70.h),
                      height: 300.sp,
                      child: Image.asset('assets/textile_calculator_logo.png'),
                    ),

                    // Register Text and content
                    Container(
                      margin: EdgeInsets.only(bottom: 70.h, top: 50.h),
                      alignment: Alignment.center,
                      child: Text(
                        'Register Here',
                        style: TextStyle(color: Colors.black, fontSize: 80.sp),
                      ),
                    ),

                    // Name
                    TextFormFieldWidget(
                      controller: _nameController,
                      errorText: null,
                      onChanged: (value) {},
                      icon: const Icon(Icons.person),
                      labelText: 'Enter Name',
                      isLastField: false,
                      obscureText: false,
                      numberKeyboard: false,
                      enabled: true,
                    ),

                    // Email
                    TextFormFieldWidget(
                      controller: _emailController,
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
                      icon: const Icon(Icons.email_outlined),
                      labelText: 'Enter Email',
                      isLastField: false,
                      obscureText: false,
                      numberKeyboard: false,
                      enabled: true,
                    ),

                    // Contact Number
                    TextFormFieldWidget(
                      controller: _contactController,
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
                      labelText: 'Enter Conatct Number',
                      isLastField: false,
                      obscureText: false,
                      numberKeyboard: true,
                      enabled: true,
                    ),

                    //Password
                    TextFormFieldWidget(
                      controller: _passwordController,
                      errorText: _passwordError,
                      obscureText: _obscureText,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            _passwordError = 'Password is required';
                          } else if (!_passwordRegex.hasMatch(value)) {
                            _passwordError = 'Invalid Password format';
                          } else {
                            _passwordError = null;
                          }
                        });
                      },
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
                      numberKeyboard: false,
                      enabled: true,
                    ),

                    SizedBox(
                      height: 30.h,
                    ),

                    //Register Button
                    isLoading
                        ? SizedBox(
                            height: 130.h,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(left: 100.w, right: 100.w),
                            height: 130.h,
                            child: ElevatedButton(
                              onPressed: registerButtonPressed,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                // backgroundColor: const Color.fromRGBO(23, 35, 255, 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.sp),
                                ),
                              ),
                              child: Text(
                                'Register',
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

                    //Sign Up with google
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        height: 120.h,
                        margin: EdgeInsets.only(left: 300.w, right: 300.w),
                        child: TextButton(
                            onPressed: () {
                              signInWithGoogle(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/google_signin_logo.png'),
                                SizedBox(
                                  width: 40.w,
                                ),
                                Text(
                                  'SignUp With Google',
                                  style: TextStyle(
                                      fontSize: 40.sp, color: Colors.black),
                                ),
                              ],
                            ))),

                    SizedBox(
                      height: 10.h,
                    ),

                    //Already User ,Login Button
                    Container(
                      margin: EdgeInsets.only(left: 250.w, right: 250.w),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already User?',
                                style: TextStyle(
                                    fontSize: 50.sp, color: Colors.black),
                              ),
                              Text(
                                ' Login Here',
                                style: TextStyle(
                                    fontSize: 50.sp, color: Colors.blue),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
