import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:rars/tabs.dart';
import 'package:rars/view_book.dart';
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
    Book(id: '1', title: "Sample Book 1", path: "assests/images/sample.pdf"),
    Book(id: '2', title: "Nikhil Goat", path: "assests/images/sample.pdf"),
  ];

  List<Book> tabList = [
    Book(id: '1', title: "abc", path: "assests/images/sample.pdf"),
    Book(id: '1', title: "abc", path: "assests/images/sample.pdf"),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  void addBookToLibrary(Book b) async {
    setState(() {
      bookList.add(b);
    });
  }

  void addTabToListFinal(Book tab) {
    log("added tab to list uwu");
    setState(() {
      tabList.add(tab);
    });
  }

  void sendList(List<Book> tabL, Book b) {
    setState(() {
      ViewBook(tabList, b);
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
            flex: 2,
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
            flex: 15,
            child: SizedBox(
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    for (var b in bookList)
                      BookItem(
                        addTab: addTabToListFinal,
                        book: Book(
                          id: b.id,
                          image: b.image,
                          title: b.title,
                          path: b.path,
                        ),
                        tabListHere: tabList,
                      )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
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
