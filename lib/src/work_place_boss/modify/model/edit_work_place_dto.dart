import 'add_work_place_dto.dart';

class EditWorkPlaceDto {

  int id;
  String? name;
  bool? fixedPlace;
  Place? place;
  int? coverRadius;

  EditWorkPlaceDto(
      {
        required this.id,
        this.name, this.fixedPlace, this.place, this.coverRadius});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Name'] = name;
    data['FixedPlace'] = fixedPlace;
    if (place != null) {
      data['Place'] = place!.toJson();
    }else{
      data['Place'] =null;
    }
    data['CoverRadius'] = coverRadius;
    return data;
  }
}
