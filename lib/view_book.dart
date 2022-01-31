import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:rars/book.dart';
import 'package:rars/main_screen.dart';
import 'package:rars/tabs.dart';

class ViewBook extends StatefulWidget {
  final List<Book> tabListHere;
  final Book book;
  const ViewBook(this.tabListHere, this.book, {Key? key}) : super(key: key);

  @override
  _ViewBookState createState() => _ViewBookState();
}

class _ViewBookState extends State<ViewBook> {
  static const int _initialPage = 1;
  int _actualPageNumber = _initialPage, _allPagesCount = 0;
  bool isSampleDoc = true;
  late PdfController _pdfController;

  @override
  void initState() {
    _pdfController = PdfController(
      // document: PdfDocument.openAsset('assets/images/sample.pdf'),
      document: PdfDocument.openFile(widget.book.path as String),
      initialPage: _initialPage,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
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
                  icon: const Icon(Icons.navigate_before_outlined),
                  color: Colors.amber,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  ),
                ),
                IconButton(
                  color: Colors.blue,
                  icon: const Icon(Icons.navigate_before),
                  onPressed: () {
                    _pdfController.previousPage(
                      curve: Curves.ease,
                      duration: const Duration(milliseconds: 100),
                    );
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
            flex: 9,
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  height: 1000,
                  width: 1000,
                    child: PdfView(
                      // scrollDirection: Axis.vertical,
                      documentLoader:
                          const Center(child: CircularProgressIndicator()),
                      pageLoader: const Center(child: CircularProgressIndicator()),
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
                        format: PdfPageFormat.JPEG,
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
                        minScale: PhotoViewComputedScale.contained * 1.5,
                        maxScale: PhotoViewComputedScale.contained * 4.0,
                        initialScale: PhotoViewComputedScale.contained * 1.5,
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
