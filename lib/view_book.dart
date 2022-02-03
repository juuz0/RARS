import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:rars/book.dart';
import 'package:rars/bookmarks.dart';
import 'package:rars/main_screen.dart';
import 'package:rars/tabs.dart';
import 'package:rars/manager.dart';

Manager m = Manager();

class ViewBook extends StatefulWidget {
  final List<Book> tabListHere;
  final Book book;
  const ViewBook(this.tabListHere, this.book, {Key? key}) : super(key: key);

  @override
  _ViewBookState createState() => _ViewBookState();
}

class _ViewBookState extends State<ViewBook> {
  int _allPagesCount = 0;
  bool isSampleDoc = true;
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
    setState(() {});
    super.initState();
  }

  void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Book Mark Added!'),
            content: Text('Book mark added on page $_actualPageNumber.'),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Okay')),
            ],
          );
        });
  }

  @override
  void dispose() {
    _pdfController.dispose();
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
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  color: Colors.blue,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    log('${widget.book.bookmarkslist}');
                    widget.book.bookmarkslist.add(_actualPageNumber);
                    m.updateBook(
                        widget.book.title,
                        widget.book.path,
                        widget.book.image,
                        "bookmarks",
                        widget.book.bookmarkslist);
                    _popupDialog(context);
                  },
                  icon: const Icon(Icons.bookmark),
                  color: Colors.blue,
                ),
                bookmarksList(widget.book, _pdfController),
                IconButton(
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
                IconButton(
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
                IconButton(
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
                      initialScale: PhotoViewComputedScale.contained * 1.1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Tabs(widget.tabListHere),
    );
  }
}
