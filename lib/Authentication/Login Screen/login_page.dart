import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../AdminPanel/admin_panel_home_page.dart';
import '../../Constants/Global_Widgets/navigate_page_with_animation.dart';
import '../../Constants/Global_Widgets/TextFormField/custom_text_form_field.dart';
import '../../Screens/Home_page/home_page.dart';
import '../Register Screen/register_page.dart';
import 'fill_user_detail_page_after_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? localStorageAdminCheck = prefs.getString('admin') ?? 'false';

      if (localStorageAdminCheck == 'true') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AdminPanelHome()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Add any required imports and dependencies here

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

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      // Check if the user exists
      final user = await _auth.fetchSignInMethodsForEmail(email);
      if (user.isEmpty) {
        // User does not exist, display a snackbar message
        const snackBar = SnackBar(
          content: Text('User Does Not Exist.'),
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

  TextEditingController forgotEmail = TextEditingController();
  void forgotPasswordButtonPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 10,
          title: Text(
            'Forgot Password',
            style: TextStyle(color: Colors.black, fontSize: 60.sp),
          ),
          content: TextField(
            controller: forgotEmail,
            style: TextStyle(color: Colors.black, fontSize: 50.sp),
            cursorHeight: 60.sp,
            onChanged: (value) {
              // setState(() {
              //   forgotEmail.text = value.toString();
              // });

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
                // print(email);
                sendPasswordResetEmail(forgotEmail.text.trim());
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
    setState(() {
      isLoading = true;
    });
    try {
      String email = _nameController.text.trim();
      String password = _passwordController.text;

      // UserCredential userCredential
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = _auth.currentUser;
      if (user != null) {
        // Fetch user data from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // Check if the 'admin' field exists in the document
        if (userDoc.exists) {
          // Get the data from the document
          Map<String, dynamic>? userData =
              userDoc.data() as Map<String, dynamic>?;

          // Check if the 'admin' field exists in the userData map
          bool isAdmin = userData?['admin'] ?? false;

          if (isAdmin) {
            await prefs.setString('admin', 'true');
            // Navigate to the admin home screen
            CustomNavigator().withBackOff(context, const AdminPanelHome());
          } else {
            await prefs.setString('admin', 'false');
            // Navigate to the regular home screen
            CustomNavigator().withBackOff(context, const HomePage());
          }
        } else {
          await prefs.setString('admin', 'false');
          // If 'admin' field does not exist, assume it's not an admin
          CustomNavigator().withBackOff(context, const HomePage());
        }
      }
    } catch (error) {
      // Navigator.of(context, rootNavigator: true).pop();
      // Login failed, handle the error (e.g., display an error message)
      SnackBar snackBar = SnackBar(content: Text('Login error: $error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool _obscureText = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentUser();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    void loginButtonPressed() {
      if (_emailError == null && _passwordController.text.isNotEmpty) {
        // showDialog(
        //   context: context,
        //   barrierDismissible: false, // Prevent dialog dismiss on tap outside
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       content: Container(
        //         height: 120.h, // Set the desired height here
        //         child: Row(
        //           children: [
        //             Container(
        //               child: CircularProgressIndicator(
        //                 color: Colors.black26,
        //               ),
        //             ),
        //             SizedBox(
        //               width: 80.w,
        //             ),
        //             Container(
        //               child: Center(
        //                 child: Text(
        //                   'Loading....',
        //                   style:
        //                       TextStyle(color: Colors.black, fontSize: 50.sp),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // );
        setState(() {
          isLoading = true;
        });
        Future.delayed(const Duration(milliseconds: 200), () {
          loginUser(context);
        });
      } else {
        setState(() {
          isLoading = false;
        });
        SnackBar snackBar =
            const SnackBar(content: Text('Please fill details without error'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Scaffold(
      body: CustomPaint(
        painter: CustomDividerPainter(),
        child: SafeArea(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              // Login Text and content
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
                    left: 50.w, right: 50.w, top: 250.h, bottom: 50.h),
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: 50.h, bottom: 20.h, left: 50.w, right: 50.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo
                    SizedBox(
                      height: 400.sp,
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
                    //Login Text
                    Container(
                      margin: EdgeInsets.only(bottom: 70.h),
                      alignment: Alignment.center,
                      child: Text(
                        'Login Here',
                        style: TextStyle(color: Colors.black, fontSize: 80.sp),
                      ),
                    ),

                    // Email
                    TextFormFieldWidget(
                      controller: _nameController,
                      errorText: _emailError,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            _emailError = 'Email is Required';
                          } else if (!_emailRegex.hasMatch(value)) {
                            _emailError = 'Invalid Email Format';
                          } else {
                            _emailError = null;
                          }
                        });
                      },
                      icon: const Icon(Icons.email_outlined),
                      labelText: 'Enter Email ',
                      isLastField: false,
                      obscureText: false,
                      numberKeyboard: false,
                      enabled: true,
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
                      numberKeyboard: false,
                      enabled: true,
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
                            height: 130.h,
                            margin: EdgeInsets.only(left: 100.w, right: 100.w),
                            child: ElevatedButton(
                              onPressed: loginButtonPressed,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                // backgroundColor: const Color.fromRGBO(23, 35, 255, 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.sp),
                                ),
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
                            onPressed: () {
                              signInWithGoogle(context);
                            },
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
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Paint the top half in blue
    paint.color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height / 2), paint);

    // Paint the bottom half in red
    paint.color = Colors.blue;
    canvas.drawRect(
        Rect.fromLTWH(0, size.height / 2, size.width, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
