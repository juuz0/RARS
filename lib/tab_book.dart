import 'package:flutter/material.dart';

class TabForBook extends StatelessWidget {
  final String title;
  const TabForBook({Key? key, required this.title}) : super(key: key);
  
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
