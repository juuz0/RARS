import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:rars/book.dart';

class BookItem extends StatelessWidget {
  final Book book;
  final Function addTab;

  const BookItem({
    Key? key,
    required this.addTab,
    required this.book,
  }) : super(key: key);

  void addTabToList(Book b) {
    addTab(b);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: ,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: SizedBox(
          height: 200,
          width: 300,
          child: GestureDetector(
            onTap: () => addTabToList(
                Book(id: book.id, title: book.title, image: book.image)),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 2,
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(book.title),
                  Text("`$book.id`"),
                  Image(
                    image: MemoryImage(book.image as Uint8List),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
