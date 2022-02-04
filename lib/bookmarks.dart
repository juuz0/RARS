import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:rars/bookmark_item.dart';

class BookmarkList extends StatefulWidget {
  final Set<int> bookmarks;
  final PdfController pdfController;
  const BookmarkList(this.bookmarks, this.pdfController, {Key? key})
      : super(key: key);

  @override
  _BookmarkListState createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
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
          for (var key in widget.bookmarks)
            BookmarkItem(key, widget.pdfController)
        ],
      ),
    );
  }
}
