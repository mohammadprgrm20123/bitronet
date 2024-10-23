class AddShiftDto {
  int id;
  Workplace workplace;
  String name;
  String fromHour;
  String toHour;
  bool globalHoliday;
  int dayOff;
  bool justPlace;
  bool needPhoto;

  AddShiftDto(
      {required this.id,
      required this.workplace,
      required this.name,
      required this.fromHour,
      required this.toHour,
      required this.globalHoliday,
      required this.dayOff,
      required this.justPlace,
      required this.needPhoto});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Workplace'] = workplace.toJson();

    data['Name'] = name;
    data['FromHour'] = fromHour;
    data['ToHour'] = toHour;
    data['GlobalHoliday'] = globalHoliday;
    data['DayOff'] = dayOff;
    data['JustPlace'] = justPlace;
    data['NeedPhoto'] = needPhoto;
    return data;
  }
}

class Workplace {
  int id;

  Workplace({required this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    return data;
  }
}
