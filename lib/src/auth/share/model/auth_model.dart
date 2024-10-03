
class AuthModel {
  int id;
  String? name;
  String? email;
  String? token;
  String? onlineChatToken;

  AuthModel(
      {required this.id,
      required this.onlineChatToken,
        this.name,
      this.email,
      this.token});

  factory AuthModel.fromJson(final Map<String, dynamic> json) => AuthModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        token: json['token'],
        onlineChatToken: json['online_chat_token'],
      );
}
