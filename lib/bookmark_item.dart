import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class BookmarkItem extends StatelessWidget {
  final int a;
  final PdfController pdfController;
  const BookmarkItem(this.a, this.pdfController, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.cell,
      child: GestureDetector(
        onTap: () => pdfController.jumpToPage(a),
        child: Container(
          width: 15.0,
          color: Colors.red,
          child: Text(
            '$a',
            style: const TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
