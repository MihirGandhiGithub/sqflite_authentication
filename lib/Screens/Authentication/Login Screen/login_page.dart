import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kt1_textile_calculation/Constants/Global_Variables/Screen%20Util%20Size.dart';
import 'package:kt1_textile_calculation/Other%20Class/auth_services.dart';
import '../../../Constants/Global_Variables/variables/variables.dart';
import '../../../Constants/Global_Widgets/Text/CustomText.dart';
import '../../../Constants/Global_Widgets/Text/CustomTextWithSize.dart';
import '../../../Constants/Global_Widgets/TextFormField/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _emailError;
  String? _passwordError;
  String? _forgotemailError;

  // For Firebase Conncetivity

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController forgotEmail = TextEditingController();
  void forgotPasswordButtonPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 10,
          title: Text(
            'Forgot Password',
            style: TextStyle(color: Colors.black, fontSize: text60sp),
          ),
          content: CustomTextFormField(
            controller: forgotEmail,
            errorText: _forgotemailError,
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  _forgotemailError = 'Email is Required';
                } else if (!ValidationScripts.emailValidation.hasMatch(value)) {
                  _forgotemailError = 'Invalid Email Format';
                } else {
                  _forgotemailError = null;
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
          actions: [
            TextButton(
              onPressed: () {
                try {
                  if (_forgotemailError == null) {
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

                    CustomAuthService.sendPasswordResetEmail(
                        context, forgotEmail.text.trim());
                    Navigator.of(context).pop();
                  }
                } catch (error) {
                  SnackBar snackBar = SnackBar(content: Text('$error'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text('Send Reset Link',
                  style: TextStyle(color: Colors.blue, fontSize: text50sp)),
            ),
          ],
        );
      },
    );
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
      await CustomAuthService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      CustomAuthService.user = CustomAuthService.auth.currentUser;
      if (CustomAuthService.user != null) {
        // Fetch user data from Firestore
        CustomAuthService.userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(CustomAuthService.user!.uid)
            .get();
        CustomAuthService.firestore
            .collection('users')
            .doc(CustomAuthService.user!.uid)
            .get()
            .then((value) {});

        // Check if the 'admin' field exists in the document
        if (CustomAuthService.userSnapshot!.exists) {
          // Get the data from the document
          Map<String, dynamic>? userData =
              CustomAuthService.userSnapshot!.data() as Map<String, dynamic>?;
          setState(() {
            UserData.userName = userData?['name'].toString() ?? '';
            UserData.userEmail = userData?['email'].toString() ?? '';
            UserData.userPhoneNumber =
                userData?['contactNumber'].toString() ?? '';
          });

          // Check if the 'admin' field exists in the userData map
          bool isAdmin = userData?['admin'] ?? false;

          if (isAdmin) {
            // Navigate to the admin home screen
            // CustomNavigator().withBackOff(context, const AdminPanelHome());
            Navigator.pushReplacementNamed(context, '/adminPanel_home');
          } else {
            // Navigate to the regular home screen
            // CustomNavigator().withBackOff(context, const HomePage());

            Navigator.pushReplacementNamed(context, '/home_screen');
          }
        } else {
          // If 'admin' field does not exist, assume it's not an admin
          // CustomNavigator().withBackOff(context, const HomePage());
          Navigator.pushReplacementNamed(context, '/home_screen');
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
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
      statusBarIconBrightness: Brightness.dark, // dark text for status bar
      systemNavigationBarColor:
          Colors.blue, // background color of the navigation bar
    ));
    void loginButtonPressed() {
      if (_emailError == null &&
          _passwordError == null &&
          _nameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
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
      backgroundColor: Colors.blue,
      body: Stack(
        children: <Widget>[
          Container(
            width: 1.sw,
            height: 0.5.sh,
            color: Colors.white,
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: SUwidth1350w,
                height: SUheight2000h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 5,
                          offset: Offset(0, 0),
                          color: Colors.black)
                    ]),
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: 50.h, bottom: 20.h, left: 50.w, right: 50.w),
                // margin: EdgeInsets.only(
                //     left: 50.w, right: 50.w, top: 150.h, bottom: 0.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: SUheight400h,
                      child: Image.asset('assets/textile_calculator_logo.png'),
                    ),

                    // Welcome Text
                    CustomTextWithSize(
                      text: 'Welcome Back',
                      color: Colors.black87,
                      maxLine: 3,
                      bold: false,
                      size: text100sp,
                    ),

                    //Login Text
                    Padding(
                      padding: EdgeInsets.only(
                          top: SUheight50h, bottom: SUheight50h),
                      child: CustomTextWithSize(
                        text: 'Login Here',
                        color: Colors.black,
                        maxLine: 3,
                        bold: false,
                        size: text80sp,
                      ),
                    ),

                    // Email
                    CustomTextFormField(
                      controller: _nameController,
                      errorText: _emailError,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            _emailError = 'Email is Required';
                          } else if (!ValidationScripts.emailValidation
                              .hasMatch(value)) {
                            _emailError = 'Invalid Email Format';
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

                    //Password
                    CustomTextFormField(
                      controller: _passwordController,
                      errorText: _passwordError,
                      obscureText: _obscureText,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            _passwordError = 'Password is Required';
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

                    //Forgot Password
                    Padding(
                        padding: EdgeInsets.only(
                            top: SUheight20h, bottom: SUheight50h),
                        child: InkWell(
                            onTap: forgotPasswordButtonPressed,
                            child: Text(
                              'Forgot Password ?',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: text40sp, color: Colors.black),
                            ))),

                    //Login Button
                    isLoading
                        ? const SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                left: SUwidth100w, right: SUwidth100w),
                            child: ElevatedButton(
                              onPressed: loginButtonPressed,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                // backgroundColor: const Color.fromRGBO(23, 35, 255, 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(text50sp),
                                ),
                              ),
                              child: CustomTextWithSize(
                                text: 'Login',
                                color: Colors.white,
                                maxLine: 3,
                                bold: false,
                                size: text70sp,
                              ),
                            ),
                          ),

                    //OR Text
                    const Text(
                      '----------- or ----------',
                      textAlign: TextAlign.center,
                    ),

                    //Sign in with google
                    Padding(
                      padding: EdgeInsets.only(
                          left: SUwidth100w, right: SUwidth100w),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size.fromHeight(SUheight120h),
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 2.0,
                          shadowColor: Colors.grey.withOpacity(1),
                        ),
                        onPressed: () {
                          setState(() {
                            UserData.userName = '';
                            UserData.userEmail = '';
                            UserData.userPhoneNumber = '';
                          });
                          //Sign in With Google
                          CustomAuthService.signInWithGoogle(context);
                        },
                        label: const CustomText(
                          text: 'Signin With Google',
                          color: Colors.black,
                          maxLine: 3,
                          bold: false,
                        ),
                        icon: SizedBox(
                            height: SUheight100h,
                            child:
                                Image.asset('assets/google_signin_logo.png')),
                      ),
                    ),

                    //Move To Register Page Button
                    TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/register_screen');
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: 'Not a User ?',
                              color: Colors.black,
                              maxLine: 3,
                              bold: false,
                            ),
                            CustomText(
                              text: ' Create Account',
                              color: Colors.blue,
                              maxLine: 3,
                              bold: false,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // body: ListView(
      //   physics: const ClampingScrollPhysics(),
      //   children: [
      //     // Logo
      //
      //   ],
      // ),
    );
  }
}
