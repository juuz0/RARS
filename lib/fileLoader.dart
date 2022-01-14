import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:developer';

class FileLoader extends StatelessWidget {
  const FileLoader({Key? key}) : super(key: key);

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      log(file.name);
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
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
