import 'cash_type.dart';
import 'currency_model.dart';

class CashServiceModel {
  List<CashServiceData> list;

  CashServiceModel({required this.list});

  static List<CashServiceData> fromJson(final Map<String, dynamic> json) {
    final List<CashServiceData> list = [];

    if (json['PAYPAL'] != null) {
      final paypal =
          CashServiceData.fromJson(json['PAYPAL'], CashFormType.paypal);
      list.add(paypal);
    }

    if (json['HAMSTER'] != null) {
      final wise = CashServiceData.fromJson(json['HAMSTER'], CashFormType.hamster);
      list.add(wise);
    }

    if (json['WEBMONEY'] != null) {
      final webMoney =
          CashServiceData.fromJson(json['WEBMONEY'], CashFormType.webMoney);
      list.add(webMoney);
    }

    if (json['BTC'] != null) {
      final btc = CashServiceData.fromJson(json['BTC'], CashFormType.btc);
      list.add(btc);
    }

    if (json['ETHEREUM'] != null) {
      final ethereum =
          CashServiceData.fromJson(json['ETHEREUM'], CashFormType.ethereum);
      list.add(ethereum);
    }

    if (json['TETER'] != null) {
      final tether =
          CashServiceData.fromJson(json['TETER'], CashFormType.tether);
      list.add(tether);
    }

    if (json['BROKER_CASHINCOME'] != null) {
      final perfectMoney = CashServiceData.fromJson(
          json['BROKER_CASHINCOME'], CashFormType.broker);
      list.add(perfectMoney);
    }

    if (json['PERFECTMONEY'] != null) {
      final perfectMoney = CashServiceData.fromJson(
          json['PERFECTMONEY'], CashFormType.perfectMoney);
      list.add(perfectMoney);
    }
    if (json['PERFECTMONEY_VOUCHER'] != null) {
      final perfectMoneyVoucher = CashServiceData.fromJson(
          json['PERFECTMONEY_VOUCHER'], CashFormType.perfectMoneyVoucher);
      list.add(perfectMoneyVoucher);
    }


    if (json['WISE'] != null) {
      final wise = CashServiceData.fromJson(json['WISE'], CashFormType.wise);
      list.add(wise);
    }

    return list;
  }
}

class CashServiceData {
  String name;
  CashFormType type;
  List<CurrencyModel> currencies;
  String needVideoVerification;
  String instruction;
  String? image;

  CashServiceData({
    required this.name,
    required this.type,
    required this.currencies,
    required this.needVideoVerification,
    required this.instruction,
    this.image,
  });

  factory CashServiceData.fromJson(
      final Map<String, dynamic> json, final CashFormType type) {
    final currencies = <CurrencyModel>[];
    if (json['currencies'] != null) {
      json['currencies'].forEach((final v) {
        currencies.add(CurrencyModel.fromJson(v));
      });
    }

    print(json['icon']);

    return CashServiceData(
      name: json['name'],
      currencies: currencies,
      type: type,
      needVideoVerification: json['need_video_verification'],
      instruction: json['instruction'],
      image: json['icon'],
    );
  }
}
