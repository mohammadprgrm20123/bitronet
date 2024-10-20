class AddWorkPlaceDto {
  String? name;
  bool? fixedPlace;
  Place? place;
  num? coverRadius;

  AddWorkPlaceDto(
      { this.name, this.fixedPlace, this.place, this.coverRadius});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = 0;
    data['Name'] = name;
    data['FixedPlace'] = fixedPlace;
    if (place != null) {
      data['Place'] = place!.toJson();
    }
    data['CoverRadius'] = coverRadius;
    return data;
  }
}



class Place {
  double? lat;
  double? lon;

  Place({this.lat, this.lon});

  Place.fromJson(final Map<String, dynamic> json) {
    lat = json['Lat'];
    lon = json['Lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Lat'] = lat;
    data['Lon'] = lon;
    return data;
  }
}