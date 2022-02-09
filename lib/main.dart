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
  List<dynamic> tabList = [];

  @override
  void initState() {
    tabList.add(MainScreen(_addToList, _closeTab, tabList));
    super.initState();
  }

  void _addToList(dynamic vb) {
    setState(() {
      tabList.add(vb);
    });
  }

  void _closeTab(int index) {
    // setState(() {
    //   try {
    //     tabList.removeAt(index);
    //   } catch (e) {
    //     tabList.removeLast();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Best PDF Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      // home: TabsDynamic(tabList, viewbook),
      home: TabsDynamic(tabList),
    );
  }
}
