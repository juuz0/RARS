import 'package:flutter/material.dart';
class tabForBook extends StatefulWidget {
  const tabForBook({ Key? key }) : super(key: key);

  @override
  _tabForBookState createState() => _tabForBookState();
}

class _tabForBookState extends State<tabForBook> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
            onPressed: () {},
            icon: const Icon(Icons.book),
            color: Colors.white60,
            tooltip: "Book Name",
          );
  }
}