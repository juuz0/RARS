import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:rars/book.dart';
import 'package:rars/view_book.dart';


class BookItem extends StatelessWidget {
  final Book book;
  final Function addTab;
  final List<Book> tabListHere;

  BookItem({
    Key? key,
    required this.addTab,
    required this.book,
    required this.tabListHere,
  }) : super(key: key);

  void addTabToList(Book b) {
    addTab(b);
  }

  final placeholderImage = Image.asset(
    "assets/images/placeholder.png",
    fit: BoxFit.contain,
    width: 1000,
  );

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
            // onTap: () => addTabToList(
            //     Book(id: book.id, title: book.title, image: book.image)),
            onTap:  () {
              addTabToList(
              Book(id: book.id, title: book.title, image: book.image, path: book.path));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewBook(tabListHere, book)
        ),
      );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 2,
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        book.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: (book.image != null)
                        ? Image(image: MemoryImage(book.image as Uint8List))
                        : placeholderImage,
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
