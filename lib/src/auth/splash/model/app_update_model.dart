import 'device_type.dart';

class AppUpdateModel {
  DeviceType deviceType;
  int versionCode;
  String versionName;
  int forcedUpdateVersion;
  List<String> changeLog;
  List<DownloadLinks> downloadLinks;

  AppUpdateModel(
      {required this.deviceType,
      required this.versionCode,
      required this.versionName,
      required this.forcedUpdateVersion,
      required this.changeLog,
      required this.downloadLinks});

  factory AppUpdateModel.fromJson(final Map<String, dynamic> json) {
    final downloadLinks = <DownloadLinks>[];
    if (json['download_links'] != null) {
      json['download_links'].forEach((final v) {
        downloadLinks.add(DownloadLinks.fromJson(v));
      });
    }
    return AppUpdateModel(
      downloadLinks: downloadLinks,
      deviceType: DeviceType.convert(json['device_type']),
      versionCode: json['version_code'],
      versionName: json['version_name'],
      forcedUpdateVersion: json['forced_update_version'],
      changeLog: json['change_log'].cast<String>(),
    );
  }
}

class DownloadLinks {
  String? name;
  String? nameFa;
  String link;
  bool show;

  DownloadLinks(
      {required this.name,
      required this.nameFa,
      required this.link,
      required this.show});

  factory DownloadLinks.fromJson(final Map<String, dynamic> json) =>
      DownloadLinks(
        name: json['name'],
        nameFa: json['name_fa'],
        link: json['link'],
        show: (json['show']=='1')? true : false,
      );
}
