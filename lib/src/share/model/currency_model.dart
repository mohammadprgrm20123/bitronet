
class CurrencyModel {
  int? id;
  String? name;
  String? abbreviation;
  String? total;

  CurrencyModel({this.id, this.name, this.abbreviation, this.total});

  CurrencyModel.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    abbreviation = json['abbreviation'];
    total = json['total'].toString();
  }

}
