import 'dart:developer';

import 'package:flutter/material.dart';
<<<<<<< HEAD:lib/mainScreen.dart
import 'package:rars/fileLoader.dart';
import 'book.dart';
import 'bookItem.dart';
=======
import 'package:rars/data.dart';
import 'book_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
>>>>>>> f033158 (Fix all static analysis problems):lib/main_screen.dart

  @override
  _ExploreState createState() => _ExploreState();
}

<<<<<<< HEAD:lib/mainScreen.dart
class _ExploreState extends State<mainScreen> {
  List<Book> bookList = [
    Book(id: 1, title: "abc", image: "abc.com"),
  ];

=======
class _ExploreState extends State<MainScreen> {
>>>>>>> f033158 (Fix all static analysis problems):lib/main_screen.dart
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

<<<<<<< HEAD:lib/mainScreen.dart
  void addBookToLibrary(Book b) {
    log("added book");
    setState(() {
      bookList.add(b);
    });
  }

=======
>>>>>>> f033158 (Fix all static analysis problems):lib/main_screen.dart
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
          SizedBox(
            height: 480,
            child: GridView.builder(
              itemCount: bookss.length,
              itemBuilder: (BuildContext context, int index) {
                return BookItem(
                    title: bookss[index].title,
                    image: bookss[index].image,
                    id: bookss[index].id);
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
<<<<<<< HEAD:lib/mainScreen.dart
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: FileLoader(addBookToLibrary),
          ),
=======
          ),
          const Text("Hello"),
>>>>>>> f033158 (Fix all static analysis problems):lib/main_screen.dart
        ],
      ),
    );
  }
}
