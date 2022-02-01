import 'dart:developer';

import 'package:xml/xml.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Manager {
  /// Private function to get XML file
  ///
  /// It tries to get a file under rars/data.xml under User's documents directory
  ///
  /// If the file is not found, it creates one and returns that.
  Future<File> _getXml() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File xmlFile = File(appDocPath +
        Platform.pathSeparator +
        "rars" +
        Platform.pathSeparator +
        "data.xml");
    if (!(await xmlFile.exists())) {
      await xmlFile.create(recursive: true);
    }
    return xmlFile;
  }

  /// (Async) Adds a book into library
  ///
  /// [title] for book path (String)
  ///
  /// [lastReadPage] for the last read page by user (int)
  ///
  /// [bookmarkedPages] list of pages bookmarked (List<int>)
  ///
  /// returns [true], if added, [false] if some error.
  Future<bool> addBookInLibrary(
      String title, int lastReadPage, List<int> bookmarkedPages) async {
    File xmlFile = await _getXml();
    var document = XmlDocument();
    final XmlBuilder builder = XmlBuilder();
    String finalXml = '';

    builder.processing('xml', 'version="1.0"');
    try {
      document = XmlDocument.parse(xmlFile.readAsStringSync());
      document.findAllElements('book').forEach((node) =>
          finalXml += '\n' + node.toXmlString(pretty: true, indent: '\t'));
      String tempString = _addBook(title, lastReadPage, bookmarkedPages);
      finalXml += tempString;
      builder.element('library', nest: () {
        builder.xml(finalXml);
      });
      finalXml =
          builder.buildDocument().toXmlString(pretty: true, indent: '\t');
    } on XmlParserException {
      builder.element('library', nest: () {
        builder.xml(_addBook(title, lastReadPage, bookmarkedPages));
      });
      document = builder.buildDocument();
      finalXml += document.toXmlString(pretty: true, indent: '\t');
    } catch (e) {
      log(e.toString());
      return false;
    }
    xmlFile.writeAsStringSync(finalXml);
    return true;
  }

  /// (Async) Updates an attribute of a book
  ///
  /// [path] - path of book
  ///
  /// [attribute] - attribute to change
  ///
  /// [value] - new value of [attribute]
  ///
  /// returns true if success.
  Future<bool> updateBook(String path, String attribute, dynamic value) async {
    try {
      int lastRead = await getBookAttribute(path, "lastRead");
      List<int> bookmarks = await getBookAttribute(path, "bookmarks");
      bool a, b;
      switch (attribute) {
        case "lastRead":
          a = await deleteBook(path);
          b = await addBookInLibrary(path, value, bookmarks);
          if (a == true && b == true) {
            return true;
          } else {
            break;
          }
        case "bookmarks":
          a = await deleteBook(path);
          b = await addBookInLibrary(path, lastRead, value);
          if (a == true && b == true) {
            return true;
          } else {
            break;
          }
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  /// (Async) Deletes a book from the library
  ///
  /// [path] - path of book to delete
  ///
  /// Returns true if success.
  Future<bool> deleteBook(String path) async {
    File xmlFile = await _getXml();
    String finalXml = '';
    XmlBuilder builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    try {
      final document = XmlDocument.parse(xmlFile.readAsStringSync());
      for (var book in document.findAllElements('book')) {
        if (book.getElement('path')!.text != path) {
          finalXml += book.toXmlString(pretty: true, indent: '\t');
        }
      }
      builder.element('library', nest: () {
        builder.xml(finalXml);
      });
      xmlFile.writeAsStringSync(
          builder.buildDocument().toXmlString(pretty: true, indent: '\t'));
    } catch (e) {
      log(e.toString());
      return false;
    }
    return true;
  }

  /// Helper function to build a book
  ///
  /// Returns an xml representation of a <book> element
  String _addBook(String path, int lastReadPage, List<int> bookmarkedPages) {
    XmlBuilder bb = XmlBuilder();
    bb.element('book', nest: () {
      bb.element('path', nest: path);
      bb.element('lastRead', nest: lastReadPage);
      bb.element('bookmarks', nest: () {
        for (var page in bookmarkedPages) {
          bb.element('page', nest: page);
        }
      });
    });
    return bb.buildDocument().toXmlString(pretty: true, indent: '\n');
  }

  /// (Async) get the specified attribute of book
  ///
  /// [path] - path of book to identify it
  ///
  /// [attribute] - attribute to find
  ///
  /// Returns [String], [int], [List<int>] depending on the attribute
  dynamic getBookAttribute(String path, String attribute) async {
    File xmlFile = await _getXml();
    var document = XmlDocument.parse(xmlFile.readAsStringSync());
    final element = document.findAllElements('book').where(
        (element) => element.findAllElements('path').single.text == path);
    final elem = element.first.getElement(attribute)!;
    switch (attribute) {
      case "path":
        return elem.text;
      case "lastRead":
        return int.parse(elem.text);
      case "bookmarks":
        List<int> lis = [];
        for (var e in elem.findElements('page')) {
          int tempNum = int.parse(e.firstChild.toString());
          lis.add(tempNum);
        }
        return lis;
      default:
        return -1;
    }
  }

  /// (Async) get paths of all books
  /// Returns [List<String>] with path of all books
  Future<List<String>> getBooks() async {
    File xmlFile = await _getXml();
    var document = XmlDocument.parse(xmlFile.readAsStringSync());
    final bookList = document.findAllElements('path');
    List<String> ls = [];
    for (var book in bookList) {
      ls.add(book.firstChild.toString());
    }
    return ls;
  }
}
