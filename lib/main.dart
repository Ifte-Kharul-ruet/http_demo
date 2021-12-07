import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_http/models.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  List<MyModel> m = [];
  getInfo() async {
    var response = await http.get(
      Uri.parse(
        'https://demo2-e7ebe-default-rtdb.firebaseio.com/user.json',
      ),
    );
    // print(response.body);
    var map = jsonDecode(response.body) as Map<String, dynamic>;
    print(response.statusCode);
    map.forEach((_, value) {
      m.add(MyModel(name: value['Name'], address: value['Address']));
    });
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    widget.getInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Http FireBase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text('Show Data'),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.m.length,
                itemBuilder: (ctx, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(widget.m[index].name),
                      Text(widget.m[index].address),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
