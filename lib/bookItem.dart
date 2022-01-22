import 'package:flutter/material.dart';
import 'book.dart';

class BookItem extends StatelessWidget {
  final String title;
  final String image;
  final int id;

  BookItem({
    required this.title,
    required this.image,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: ,
      child: Container(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 2,
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                Text(title),
                Text("`$id`"),
                Text(image),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
