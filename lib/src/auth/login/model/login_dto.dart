class LoginDto {
  final String phone;
  final String password;

  LoginDto({required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Mobile'] = phone;
    data['AppPass'] = password;
    return data;
  }
}
