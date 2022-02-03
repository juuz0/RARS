import 'dart:typed_data';

class Book {
  final String id;
  final String title;
  final Uint8List? image;
  final String? path;
  final int? lastPage;
  // ignore: prefer_typing_uninitialized_variables
  final bookmarkslist;

  Book({
    required this.id,
    this.image,
    required this.title,
    required this.path,
    this.lastPage,
    this.bookmarkslist,
  });
}
