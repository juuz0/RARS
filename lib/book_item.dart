import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final String title;
  final String image;
  final int id;

  const BookItem({
    Key? key,
    required this.title,
    required this.image,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: ,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text(title),
              Text("`$id`"),
              Text(image),
            ],
          ),
        ),
      ),
    );
  }
}
