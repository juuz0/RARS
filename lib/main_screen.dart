import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rars/tab_book.dart';
import 'package:rars/tabs.dart';
import 'book_item.dart';
import 'book.dart';
import 'file_loader.dart';
import 'tabs.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<MainScreen> {
  List<Book> bookList = [
    const Book(id: 1, title: "abc", image: "abc.com"),
    const Book(id: 1, title: "abc", image: "abc.com"),

  ];

     List<Book> tabList = [
    const Book(id: 1, title: "abc", image: "abc.com"),
    const Book(id: 1, title: "abc", image: "abc.com"),
  ];
 

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  void addBookToLibrary(Book b) {
    log("added book");
    setState(() {
      bookList.add(b);
    });
  }
  
  void addTabToListFinal(Book tab){
    log("added tab to list uwu");
    setState(() {
      tabList.add(tab);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "MY SHELF",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.blue,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.color_lens),
            color: Colors.blue,
            tooltip: "Themes",
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.blue,
            tooltip: "Settings",
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                    icon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.black54),
                    hintText: "Search the book in your book sheft",
                    fillColor: Colors.blue[50]),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: SizedBox(
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    for (var book in bookList)
                      BookItem(
                        addTabToListFinal,
                        title: book.title,
                        image: book.image,
                        id: book.id,
                      )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FileLoader(addBookToLibrary),
            ),
          ),
        ],
      ),
      drawer: Tabs(tabList),
    );
  }
}
