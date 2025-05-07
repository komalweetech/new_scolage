import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';


abstract class CommonImagePicker {
  // PIC AND GET IMAGE PATH
  static Future<String?> picImageAndGetFilePath() async {
    var file = await ImagePicker().pickImage(
      imageQuality: 50,
      source: ImageSource.gallery,
    );
    await file?.readAsBytes();
    return file?.path;
  }

  static Future<CroppedFile?> cropImage(filepath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: filepath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1), // Use fixed aspect ratio
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          showCropGrid: true,
          toolbarWidgetColor: Colors.black,
          cropGridColor: Colors.white,
          cropFrameColor: Colors.white,
          dimmedLayerColor: Colors.black26,
          cropGridStrokeWidth: 2,
          cropFrameStrokeWidth: 2,
          backgroundColor: Colors.white,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
          showCancelConfirmationDialog: true,
        ),
      ],
    );
    return croppedFile;
  }
}
