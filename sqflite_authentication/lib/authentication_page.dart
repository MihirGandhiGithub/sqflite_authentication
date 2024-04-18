import 'package:flutter/material.dart';
import 'package:sqflite_authentication/authenticated%20Homepage.dart';

import 'databaseHelper.dart';
import 'main.dart';

class authenticationScreen extends StatefulWidget {
  const authenticationScreen({super.key});

  @override
  State<authenticationScreen> createState() => _authenticationScreenState();
}

class _authenticationScreenState extends State<authenticationScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // Function to handle login button press
  void _handleLogin() async {
    String userEmail = email.text.toString();
    String userPassword = password.text.toString();

    // Check if email and password are provided
    if (userEmail.isEmpty || userPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please provide email and password.'),
        ),
      );

      return;
    }

    // Retrieve user data from the database based on email and password
    Map<String, dynamic>? userData =
        await dbHelper.getUserByEmailAndPassword(userEmail, userPassword);

    // If user data exists, navigate to home page
    if (userData != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthenticatedHomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email or password.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(
                  label: Text('email'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                  label: Text('password'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> row = {
                    DatabaseHelper.email: email.text.toString(),
                    DatabaseHelper.password: password.text.toString()
                  };
                  final id = await dbHelper.insertUser(row);
                  debugPrint('inserted row id: $id');
                },
                child: Text('Insert')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: _handleLogin, child: Text('Login'))
          ],
        ),
      ),
    );
  }
}
