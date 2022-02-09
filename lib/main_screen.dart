import 'package:flutter/material.dart';
import 'book_item.dart';
import 'book.dart';
import 'file_loader.dart';
import 'manager.dart';

class MainScreen extends StatefulWidget {
  final Function addToTabs;
  final Function closeTab;
  final List<dynamic> tabList;
  const MainScreen(this.addToTabs, this.closeTab, this.tabList, {Key? key})
      : super(key: key);
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<MainScreen> {
  late Future<List<List<dynamic>>> bookList;
  String filterKey = '';
  Manager man = Manager();

  @override
  void initState() {
    super.initState();
    setState(() {});
    bookList = man.getBooks();
  }

  void addBookToLibrary(Book b) async {
    setState(() {
      man.addBookInLibrary(b.title, b.path!, 1, {});
      bookList = man.getBooks();
    });
  }

  void addTabToListFinal(dynamic viewNew) {
    setState(() {
      widget.tabList.add(viewNew);
    });
  }

  void updateSearchFilter(String key) {
    setState(() {
      filterKey = key;
    });
  }

  bool checkFilter(String title) {
    if (filterKey == '') return true;
    if (title.toLowerCase().startsWith(filterKey.toLowerCase())) return true;
    return false;
  }

  void refreshLibaryWithAttr() {
    setState(() {
      bookList = man.getBooks();
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
                onChanged: (key) => updateSearchFilter(key),
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: FutureBuilder(
              future: bookList,
              builder: (BuildContext ctx,
                  AsyncSnapshot<List<List<dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data![0].isNotEmpty) {
                    return SizedBox(
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: [
                            ...snapshot.data!.map((b) {
                              if (checkFilter(b[0])) {
                                return BookItem(
                                  addTab: widget.addToTabs,
                                  book: Book(
                                    id: 'id',
                                    image: b[2],
                                    title: b[0],
                                    path: b[1],
                                    lastPage: b[3],
                                    bookmarkslist: b[4],
                                  ),
                                  tabListHere: widget.tabList,
                                  refreshLibrary: refreshLibaryWithAttr,
                                  closeTab: widget.closeTab,
                                );
                              }
                              return Container();
                            })
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      width: 300,
                      height: 300,
                      child: Column(
                        children: const [
                          Text("Aw, No books have been added yet :/"),
                          SizedBox(height: 10),
                          Text("Tap the + icon to add some!")
                        ],
                      ),
                    );
                  }
                }
                return Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ), // some space LOL
                        Text("Hang on while I load the books :D")
                      ],
                    ),
                  ),
                );
              },
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
    );
  }
}
