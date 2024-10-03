import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import 'model/file_type.dart';

class FileUtils {
  static bool fileTypeAccess(final XFile file) {
    final mimeType = lookupMimeType(file.path);
    if (mimeType != null) {
      final fileType = AppFileType.convert(mimeType.split('/')[1]);
      if (fileType == AppFileType.none) {
        return false;
      }
      return true;
    }
    return false;
  }

  static String getFileType(final XFile file) {
    final mimeType = lookupMimeType(file.path);

    return mimeType != null ? mimeType.split('/')[1] : 'unknown file';
  }

  static bool isImage({required final XFile file}) {
    final mimeType = lookupMimeType(file.path);

    if (mimeType != null && mimeType.contains('image')) {
      return true;
    }
    return false;
  }

  static bool hasStandardFileSize({required final XFile file}) {
    final size = File(file.path).lengthSync() / 1000000;

    if (size < 2) {
      return true;
    }
    return false;
  }
}
