import 'cash_service_model.dart';
import 'category_model.dart';
import 'form_file_type.dart';

class OrderDataModel {
  List<CategoryModel> categories;
  List<CashServiceData> cashServices;
  List<ServiceModel> services;

  OrderDataModel(
      {required this.categories,
      required this.cashServices,
      required this.services});

  factory OrderDataModel.fromJson(final Map<String, dynamic> json) {
    final categories = <CategoryModel>[];
    json['categories'].forEach((final v) {
      categories.add(CategoryModel.fromJson(v));
    });
    final cashServices = CashServiceModel.fromJson(
      json['cashServices'],
    );
    final services = <ServiceModel>[];
    json['services'].forEach((final v) {
      services.add(ServiceModel.fromJson(v));
    });

    return OrderDataModel(
        categories: categories, services: services, cashServices: cashServices);
  }
}

class ServiceModel {
  int id;
  String title;
  String formFile;
  String slug;
  String type;
  FormFileType formType;
  String? instruction;
  String? instructionType;
  List<Currency>? currency;

  ServiceModel(
      {required this.formType,
      required this.id,
      required this.title,
      required this.formFile,
      required this.slug,
      required this.type,
      this.instruction,
      this.instructionType,
      this.currency});

  factory ServiceModel.fromJson(final Map<String, dynamic> json) {
    final currency = <Currency>[];
    if (json['currency'] != null) {
      json['currency'].forEach((final v) {
        currency.add(Currency.fromJson(v));
      });
    }
    return ServiceModel(
      id: json['id'],
      title: json['title'],
      formFile: json['form_file'],
      slug: json['slug'],
      type: json['type'],
      currency: currency,
      instruction: json['instruction'],
      instructionType: json['instruction_type'],
      formType: FormFileType.convert(json['form_file']),
    );
  }
}

class Currency {
  int? id;
  String? name;
  String? abbreviation;
  String? total;
  Pivot? pivot;
  Meta? meta;

  Currency(
      {this.id,
      this.name,
      this.abbreviation,
      this.total,
      this.pivot,
      this.meta});

  Currency.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    abbreviation = json['abbreviation'];
    total = json['total'].toString();
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    meta =json['meta']!=null ? Meta.fromJson(json['meta']) : null;
  }
}

class Pivot {
  int currenciesAbleId;
  int currenciesId;
  String currenciesAbleType;

  Pivot(
      {required this.currenciesAbleId,
      required this.currenciesId,
      required this.currenciesAbleType});

  factory Pivot.fromJson(final Map<String, dynamic> json) => Pivot(
      currenciesAbleId: json['currencieable_id'],
      currenciesId: json['currencies_id'],
      currenciesAbleType: json['currencieable_type']);
}

class Meta {
  int id;
  int fkCurrencyId;
  String rate;
  String price;
  String total;
  String changes;
  num changePercentage;
  int autoUpdate;
  int userId;
  String createdAt;
  String updatedAt;

  Meta(
      {required this.id,
      required this.fkCurrencyId,
      required this.rate,
      required this.price,
      required this.total,
      required this.changes,
      required this.changePercentage,
      required this.autoUpdate,
      required this.userId,
      required this.createdAt,
      required this.updatedAt});

  factory Meta.fromJson(final Map<String, dynamic> json) => Meta(
        id: json['id'],
        fkCurrencyId: json['fk_currency_id'],
        rate: json['rate'],
        price: json['price'],
        total: json['total'].toString(),
        changes: json['changes'],
        changePercentage: json['change_percentage'],
        autoUpdate: json['auto_update'],
        userId: json['user_id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );
}
