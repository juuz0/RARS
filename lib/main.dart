import 'dart:developer';

import 'package:flutter/material.dart';
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
  List<dynamic> TabList = [];

  @override
  void initState() {
    TabList.add(MainScreen(_addToList, _closeTab, TabList));
    super.initState();
  }

  void _addToList(dynamic vb) {
    setState(() {
      TabList.add(vb);
    });
    log("added added");
  }

  void _closeTab(int index) {
    setState(() {
      try {
        TabList.removeAt(index);
      } catch (e) {
        TabList.removeLast();
      }
      log(TabList.toString());
    });
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
