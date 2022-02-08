import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:rars/book.dart';
import 'package:rars/main_screen.dart';
import 'package:rars/tabs_dynamic.dart';

dynamic viewbook;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<dynamic> TabList = [];

  @override
  void initState() {
    TabList.add(MainScreen(_addToList));
    super.initState();
  }

  void _addToList(dynamic vb) {
    setState(() {
      TabList.add(vb);
    });
    log("added added");
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Best PDF Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      // home: TabsDynamic(TabList, viewbook),
      home: TabsDynamic(TabList),
    );
  }
}
