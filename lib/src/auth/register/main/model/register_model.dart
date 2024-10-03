import 'register_type.dart';

class RegisterDto {
  String email;
  String mobile;
  String password;
  bool rules;
  String? onlineChatToken;
  String? referral;
  RegisterType registerType;

  RegisterDto({
    required this.email,
    required this.mobile,
    required this.password,
    required this.rules,
    required this.registerType,
    this.onlineChatToken,
    this.referral,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['mobile'] = mobile;
    data['password'] = password;
    data['rules'] = rules;
    data['online_chat_token'] = onlineChatToken ?? '';
    data['referral'] = referral;
    data['is_business'] = registerType.id;
    return data;
  }
}
