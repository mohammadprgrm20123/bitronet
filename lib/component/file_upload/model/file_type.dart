enum AppFileType {
  jpg,
  none,
  jpeg,
  gif,
  png,
  zip,
  rar,
  pdf;

  static AppFileType convert(final String type) {
    switch (type) {
      case 'jpg':
        return AppFileType.jpg;
      case 'jpeg':
        return AppFileType.jpeg;
      case 'gif':
        return AppFileType.gif;
      case 'png':
        return AppFileType.png;
      case 'zip':
        return AppFileType.zip;
      case 'rar':
        return AppFileType.rar;
      case 'pdf':
        return AppFileType.pdf;
    }
    return AppFileType.none;
  }
}
