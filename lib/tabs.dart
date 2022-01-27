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
        child: ListView(padding: EdgeInsets.zero, 
        children: [
             IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.white,

            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            }),
          const TabForBook(),
          const TabForBook(),
          const TabForBook(),
        ]),
      ),
    );
  }
}
