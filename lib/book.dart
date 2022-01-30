import 'dart:typed_data';

class Book {
  final String id;
  final String title;
  final Uint8List? image;
  final String? path;

  Book({
    required this.id,
    this.image,
    required this.title,
    required this.path,
  });
}
