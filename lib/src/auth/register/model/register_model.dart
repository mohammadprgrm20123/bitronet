class RegisterDto {
  String fName;
  String lName;
  String mobile;

  RegisterDto({required this.fName, required this.lName, required this.mobile});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FName'] = fName;
    data['LName'] = lName;
    data['Mobile'] = mobile;
    return data;
  }
}
