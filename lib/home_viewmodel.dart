import 'dart:io';

import 'package:file_upload/base_model.dart';
import 'package:file_upload/ftp_service.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomeViewModel extends BaseModel {
  FtpService _ftpService = FtpService();

  String imagePath = '';

  Future pickImageC() async {
    try {
      var image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.rear);

      if (image == null) return;
      final imageTemp = await saveImageLocal(image.path);
      imagePath = imageTemp.path;
      setBusy(false);
      print('[imageTemp] $imagePath');
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    setBusy(false);
  }

  Future<File> saveImageLocal(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}.png');

    return File(imagePath).copy(image.path);
  }

  bool isPathNull() {
    if (imagePath.isEmpty) {
      return false;
    }
    return true;
  }

  void uploadFile() async {
    bool statusUpload =
    await _ftpService.uploadFile(File(imagePath), ('3'));
    if(statusUpload){
      print('File berhasil dikirimkan');
    } else {
      print('File gagal dikirimkan');
    }
  }
}