import 'dart:typed_data';

class Book {
  final int id;
  final String title;
  final Uint8List? image;

  Book({
    required this.id,
    this.image,
    required this.title,
  });
}
