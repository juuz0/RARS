import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rars/tabBook.dart';
import 'book.dart';
import 'book_item.dart';
class tabs extends StatefulWidget {
  const tabs({ Key? key }) : super(key: key);

  @override
  _tabsState createState() => _tabsState();
}

class _tabsState extends State<tabs> {

   void initState() {
    super.initState();
    setState(() {});
  }

   void addTab(Book b) {
    setState(() {
      log('tab added');
      tabForBook();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
           
         width: 40,
         child: Drawer(
          backgroundColor: Colors.blue,
    child: ListView(
    padding: EdgeInsets.zero,
    children: [
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
      const tabForBook(),
      const tabForBook(),
      const tabForBook(),


    ]),
      ),
    );
  }
}