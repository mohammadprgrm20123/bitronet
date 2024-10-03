class UpdateUserProfileDto {
  final String? birthday;
  final String? nationalCode;
  final String? phoneNumber;

  UpdateUserProfileDto({
     this.birthday,
    this.nationalCode,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['birthday'] = birthday!.replaceAll('-', '/');
    data['national_code'] = nationalCode;
    return data;
  }

  Map<String, dynamic> toJsonJustPhone() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phoneNumber;
    return data;
  }
}
