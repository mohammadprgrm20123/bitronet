class ShiftModel {
  int id;
  String name;
  String fromHour;
  String toHour;
  bool globalHoliday;
  int dayOff;
  bool justPlace;
  bool needPhoto;

  ShiftModel(
      {required this.id,
      required this.name,
      required this.fromHour,
      required this.toHour,
      required this.globalHoliday,
      required this.dayOff,
      required this.justPlace,
      required this.needPhoto});

  factory ShiftModel.fromJson(final Map<String, dynamic> json) => ShiftModel(
        id: json['id'],
        name: json['name'],
        fromHour: json['fromHour'],
        toHour: json['toHour'],
        globalHoliday: json['globalHoliday'],
        dayOff: json['dayOff'],
        justPlace: json['justPlace'],
        needPhoto: json['needPhoto'],
      );
}
