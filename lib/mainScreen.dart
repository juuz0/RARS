import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rars/fileLoader.dart';
import 'book.dart';
import 'bookItem.dart';

class mainScreen extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<mainScreen> {
  List<Book> bookList = [
    Book(id: 1, title: "abc", image: "abc.com"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        leading: IconButton(
          icon: const Icon(Icons.settings),
          color: Colors.blue,
          tooltip: "Settings",
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.color_lens),
            color: Colors.blue,
            tooltip: "Themes",
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
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
          Container(
            height: 480,
            child: GridView.builder(
              itemCount: bookList.length,
              itemBuilder: (BuildContext context, int index) {
                return BookItem(
                    title: bookList[index].title,
                    image: bookList[index].image,
                    id: bookList[index].id);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 5 / 3,
              ),
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: FileLoader(addBookToLibrary),
          ),
        ],
      ),
    );
  }
}
