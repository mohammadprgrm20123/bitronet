class AddWorkPlaceDto {
  int iD;
  String fName;
  String lName;
  String email;
  String photo;

  AddWorkPlaceDto(
      {required this.iD,
      required this.fName,
      required this.lName,
      required this.email,
      required this.photo});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['FName'] = fName;
    data['LName'] = lName;
    data['Email'] = email;
    data['Photo'] = photo;
    return data;
  }
}
