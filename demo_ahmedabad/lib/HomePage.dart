import 'package:demo_ahmedabad/apiCalling.dart';
import 'package:demo_ahmedabad/todoList.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => todoList()));
                },
                child: Text('To Do List')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => apiCalling()));
                },
                child: Text('Api Calling'))
          ],
        ),
      ),
    );
  }
}
