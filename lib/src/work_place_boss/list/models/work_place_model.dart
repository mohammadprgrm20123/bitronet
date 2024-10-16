class WorkPlaceModel {
  int id;
  Owner? owner;
  String? name;
  bool? fixedPlace;
  Place? place;
  int? coverRadius;
  String? shareKey;
  bool? active;

  WorkPlaceModel(
      {required this.id,
      this.owner,
      this.name,
      this.fixedPlace,
      this.place,
      this.coverRadius,
      this.shareKey,
      this.active});

  factory WorkPlaceModel.fromJson(final Map<String, dynamic> json) =>
      WorkPlaceModel(
        id: json['id'],
        owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
        name: json['name'],
        fixedPlace: json['fixedPlace'],
        place: json['place'] != null ? Place.fromJson(json['place']) : null,
        coverRadius: json['coverRadius'],
        shareKey: json['shareKey'],
        active: json['active'],
      );
}

class Owner {
  int? id;
  int? appPass;
  String? fName;
  String? lName;
  String? mobile;
  String? email;
  String? fcmToken;
  int? roleType;
  String? photo;

  Owner(
      {this.id,
      this.appPass,
      this.fName,
      this.lName,
      this.mobile,
      this.email,
      this.fcmToken,
      this.roleType,
      this.photo});

  Owner.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    appPass = json['appPass'];
    fName = json['fName'];
    lName = json['lName'];
    mobile = json['mobile'];
    email = json['email'];
    fcmToken = json['fcmToken'];
    roleType = json['roleType'];
    photo = json['photo'];
  }
}

class Place {
  num? lat;
  num? lon;

  Place({this.lat, this.lon});

  Place.fromJson(final Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }
}
