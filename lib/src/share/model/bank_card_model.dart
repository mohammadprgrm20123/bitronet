import 'card_bank_status.dart';

class BankCardModel {
  int id;
  String name;
  String cardNumber;
  String? accountNumber;
  String? iban;
  CardBankStatus? status;

  BankCardModel({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.accountNumber,
    required this.iban,
    this.status,
  });

  factory BankCardModel.fromJson(final Map<String, dynamic> json) =>
      BankCardModel(
        status: json['status'] == null
            ? null
            : CardBankStatus.convert(json['status']),
        id: (json['id'] is String) ? int.parse(json['id']) : json['id'],
        name: json['name'],
        cardNumber: json['card_number'],
        accountNumber: json['account_number'],
        iban: json['iban'],
      );
}
