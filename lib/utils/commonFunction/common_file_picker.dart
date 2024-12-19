import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../enum/ui_enum.dart';
import 'common_snackbar.dart';

Future<PlatformFile?> commonFilePicker(BuildContext context) async {
  try {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      return result.files.single;
    }
  } catch (e) {
    CommonSnackbar.showSnackBar(context, e.toString(), StatusType.error);
  }
  return null;
}
