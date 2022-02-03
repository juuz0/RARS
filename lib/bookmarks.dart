import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:rars/bookmark_item.dart';
import 'book.dart';

// ignore: camel_case_types
class bookmarksList extends StatefulWidget {
  final Book book;
  final PdfController pdfController;
  const bookmarksList(this.book, this.pdfController, {Key? key})
      : super(key: key);

  @override
  _bookmarksListState createState() => _bookmarksListState();
}

// ignore: camel_case_types
class _bookmarksListState extends State<bookmarksList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 20.0,
      width: 120.0,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (var key in widget.book.bookmarkslist)
            bookmarkItem(widget.book, key, widget.pdfController)
        ],
      ),
    );
  }
}
