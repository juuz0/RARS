import 'package:flutter/material.dart';
import 'package:rars/book.dart';
import 'package:rars/tab_book.dart';

class BookItem extends StatelessWidget {
  final String title;
  final String image;
  final int id;
  final Function addTab;

  const BookItem({
    Key? key,
    required this.addTab,
    required this.title,
    required this.image,
    required this.id,
  }) : super(key: key);

  void addTabToList(Book b){
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
            onTap: ()=>addTabToList(Book(id: id, title: title, image: image)),
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
        ),
      ),
    );
  }
}
