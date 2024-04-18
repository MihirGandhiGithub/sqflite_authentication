import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class apiCalling extends StatefulWidget {
  const apiCalling({super.key});

  @override
  State<apiCalling> createState() => _apiCallingState();
}

class _apiCallingState extends State<apiCalling> {
  List<dynamic> data = [];
  final String api = 'https://bhagavadgitaapi.in/chapters/';

  Future<void> apiData() async {
    try {
      final response = await http.get(Uri.parse(api));

      if (response.statusCode == 200) {
        setState(() {
          data = jsonDecode(response.body);
        });
        print(data);
        print('inside response code 200');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('error occurs: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    apiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Calling'),
      ),
      body: ListView(
        children: [
          for (int i = 0; i < data.length; i++)
            Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text('${data[i]['chapter_number']}'),
              ),
            )
        ],
      ),
    );
  }
}
