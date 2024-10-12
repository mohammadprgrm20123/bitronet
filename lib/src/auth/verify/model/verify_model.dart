class VerifyModel {
  final String token;
  final String onlineChatToken;

  VerifyModel({required this.token, required this.onlineChatToken});

  factory VerifyModel.fromJson(final Map<String, dynamic> json) => VerifyModel(
        token: json['token'],
        onlineChatToken: json['online_chat_token'],
      );
}
