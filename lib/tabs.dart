import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rars/tab_book.dart';
import 'book.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  void addTab(Book b) {
    setState(() {
      log('tab added');
      const TabForBook();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Drawer(
        backgroundColor: Colors.blue,
        child: ListView(padding: EdgeInsets.zero, children: [
          Container(
            height: 50,
            padding: EdgeInsets.zero,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(''),
            ),
          ),
          const TabForBook(),
          const TabForBook(),
          const TabForBook(),
        ]),
      ),
    );
  }
}
