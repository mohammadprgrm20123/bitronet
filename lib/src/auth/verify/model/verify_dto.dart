class VerifyDto {
  final String email;
  final String token;

  VerifyDto({required this.email, required this.token});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}
