import 'dart:io';
import 'package:ftpconnect/ftpconnect.dart';

class FtpService {
  Future<bool> uploadFile(File file, String name) async {
    FTPConnect ftpConnect =
    FTPConnect('ftp5.pptik.id', user: 'semut-jabar',
        pass: 's3muTqq!22',
        port: 2121);
    try {
      await ftpConnect.connect();
      // await ftpConnect.createFolderIfNotExist('gambar');
      // await ftpConnect.changeDirectory('/');
      await ftpConnect.uploadFile(file, sRemoteName: '$name.png');
      print('[Upload To FTP]  Success');
    } catch (e) {
      print('[Upload To FTP] - error ocurred $e');
      return false;
    } finally {
      await ftpConnect.disconnect();
    }
    return true;
  }
}
