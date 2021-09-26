import 'dart:io';

import 'package:mime/mime.dart';

bool isImage(FileSystemEntity file) {
  String path = file.path;
  final mimeType = lookupMimeType(path);

  return mimeType!.startsWith('image/');
}
