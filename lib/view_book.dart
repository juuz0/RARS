import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:rars/book.dart';
import 'package:rars/bookmarks.dart';
import 'package:rars/main_screen.dart';
import 'package:rars/tabs.dart';
import 'package:rars/manager.dart';
import 'package:rars/theme_list.dart';

Manager m = Manager();

class ViewBook extends StatefulWidget {
  final List<Book> tabListHere;
  final Book book;
  const ViewBook(this.tabListHere, this.book, {Key? key}) : super(key: key);

  @override
  _ViewBookState createState() => _ViewBookState();
}

class _ViewBookState extends State<ViewBook> {
  final myController = TextEditingController();
  int _allPagesCount = 0;
  bool isSampleDoc = true;
  late Set<int> bookmarks;
  late PdfController _pdfController;
  dynamic _actualPageNumber = 1;

  @override
  void initState() {
    _actualPageNumber = widget.book.lastPage;
    log('$_actualPageNumber');
    _pdfController = PdfController(
      document: PdfDocument.openFile(widget.book.path as String),
      initialPage: _actualPageNumber,
    );
    bookmarks = {...widget.book.bookmarkslist!};
    log(bookmarks.toString());
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    myController.dispose();
    super.dispose();
  }

  void givePageNumberF(pageno, Book b) async {
    setState(() {
      log("page updated");
      _actualPageNumber++;
    });
    log('$_actualPageNumber');
  }

  void givePageNumberB(pageno, Book b) async {
    setState(() {
      log("page updated");
      _actualPageNumber--;
    });

    log('$_actualPageNumber');
  }

  void returnPageNo(int pageno, Book b) {
    m.updateBook(b.title, b.path, b.image, "lastRead", pageno);
  }

  void resetInitPage(Book b) {
    m.updateBook(b.title, b.path, b.image, "lastRead", _actualPageNumber);
  }

  void updateBookmarks(int pageno) {
    setState(() {
      if (bookmarks.contains(pageno)) {
        bookmarks.remove(pageno);
      } else {
        bookmarks.add(pageno);
      }
    });
    m.updateBook(widget.book.title, widget.book.path, widget.book.image,
        "bookmarks", bookmarks.toList());
  }

  String color = "#FFFFFF";
  void changeColor(String col){
    setState(() {
      color = col;
    });
  }

    void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Jump to: '),
            content: TextField(
                controller: myController,
                decoration: InputDecoration(
                    icon: const Icon(Icons.last_page),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.black54),
                    hintText: "Jump to page number",
                    fillColor: Colors.blue[50]),
              ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                        _pdfController.jumpToPage(int.parse(myController.text));
                        Navigator.of(context).pop();
                  },
                  child: const Text('Jump')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: AppBar(
              title: Text(
                widget.book.title,
                style: const TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Row(
                children: [

                  Expanded(
                    flex:1,
                    child: Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu),
                        color: Colors.blue,
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                    icon: const Icon(Icons.navigate_before_outlined),
                    color: Colors.amber,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()),
                      );
                      resetInitPage(widget.book);
                    },
                                  ),
                  ),
                ],
              ),
              actions: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$_actualPageNumber/$_allPagesCount',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                IconButton(
                  onPressed: () {
                    updateBookmarks(_actualPageNumber);
                  },
                  icon: const Icon(Icons.bookmark),
                  color: (bookmarks.contains(_actualPageNumber) == true
                      ? Colors.red
                      : Colors.blue),
                ),
                BookmarkList(bookmarks, _pdfController),
                const SizedBox(width: 5,),
                IconButton(onPressed: ()=>_popupDialog(context), icon: const Icon(Icons.search),color: Colors.blue,),
                ThemeList(changeColor),

                
                IconButton(
                  color: Colors.amber,
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    if (isSampleDoc) {
                      _pdfController.loadDocument(
                          PdfDocument.openFile(widget.book.path as String));
                    } else {
                      _pdfController.loadDocument(
                          PdfDocument.openFile(widget.book.path as String));
                    }
                    isSampleDoc = !isSampleDoc;
                  },
                )
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: IconButton(
                    color: Colors.blue,
                    icon: const Icon(Icons.navigate_before),
                    onPressed: () {
                      _pdfController.previousPage(
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 100),
                      );
                      givePageNumberB(_actualPageNumber, widget.book);
                    },
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                        height: 1000,
                        width: 1000,
                        child: PdfView(
                          documentLoader:
                              const Center(child: CircularProgressIndicator()),
                          pageLoader:
                              const Center(child: CircularProgressIndicator()),
                          controller: _pdfController,
                          onDocumentLoaded: (document) {
                            setState(() {
                              _allPagesCount = document.pagesCount;
                            });
                          },
                          onPageChanged: (page) {
                            setState(() {
                              _actualPageNumber = page;
                            });
                          },
                          renderer: (PdfPage page) => page.render(
                            width: page.width * 2,
                            height: page.height * 2,
                            format: PdfPageFormat.PNG, 
                            backgroundColor: color,                           
                          ),
                          pageBuilder: (
                            Future<PdfPageImage> pageImage,
                            int index,
                            PdfDocument document,
                          ) =>
                              PhotoViewGalleryPageOptions(
                            imageProvider: PdfPageImageProvider(
                              pageImage,
                              index,
                              document.id,
                            ),
                            minScale: PhotoViewComputedScale.contained * 1.1,
                            maxScale: PhotoViewComputedScale.contained * 4.0,
                            initialScale:
                                PhotoViewComputedScale.contained * 1.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    color: Colors.blue,
                    icon: const Icon(Icons.navigate_next),
                    onPressed: () {
                      _pdfController.nextPage(
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 100),
                      );
                      givePageNumberF(_actualPageNumber, widget.book);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Tabs(widget.tabListHere),
    );
  }
}
