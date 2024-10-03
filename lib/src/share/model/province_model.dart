class ProvinceModel {
  String name;
  int provinceId;

  ProvinceModel({required this.name, required this.provinceId});

  factory ProvinceModel.fromJson(final Map<String, dynamic> json) =>
      ProvinceModel(
        name: json['name'],
        provinceId: json['province_id'],
      );

}
