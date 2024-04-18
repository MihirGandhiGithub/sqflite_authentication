import 'package:flutter/material.dart';

class AuthenticatedHomePage extends StatefulWidget {
  const AuthenticatedHomePage({super.key});

  @override
  State<AuthenticatedHomePage> createState() => _AuthenticatedHomePageState();
}

class _AuthenticatedHomePageState extends State<AuthenticatedHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authenticated Home Page'),
      ),
    );
  }
}
