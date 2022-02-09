import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
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
      final pdf = await PdfDocument.openFile(file.path as String);
      final page = await pdf.getPage(1);
      final thumbnail = await page.render(
        width: 1000,
        height: 1000,
      );
      Book newB = Book(
        id: pdf.id,
        image: thumbnail!.bytes,
        title: file.name,
        path: file.path,
      );
      addBook(newB);
    } else {}
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
              fontSize: 40,
            ),
          ),
        ),
      ],
    );
  }
}
