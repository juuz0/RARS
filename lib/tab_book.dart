import 'package:flutter/material.dart';

class TabForBook extends StatelessWidget {
  final String title;
  const TabForBook({Key? key, required this.title}) : super(key: key);

//   @override
//   _TabForBookState createState() => _TabForBookState();
// }

// class _TabForBookState extends State<TabForBook> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.book),
      color: Colors.white60,
      tooltip: title,
    );
  }
}
