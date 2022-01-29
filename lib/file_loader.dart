import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:developer';
import 'book.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';

class FileLoader extends StatelessWidget {
  final Function addBook;
  const FileLoader(this.addBook, {Key? key}) : super(key: key);

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      log(file.name);
      final pdf = await PdfDocument.openFile(file.path as String);
      final page = await pdf.getPage(1);
      final thumbnail = await page.render(width: 50, height: 50);
      Book newB = Book(
        id: 1,
        image: thumbnail!.bytes,
        title: file.name,
      );
      log('added to list');
      addBook(newB);
    } else {
      log('User cancelled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => pickFile(),
          child: const Text(
            "+",
            style: TextStyle(
              fontSize: 35,
            ),
          ),
        ),
        const Text(
          "Load new file",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
