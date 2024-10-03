class CityModel {
  final String name;
  final int cityId;
  final int fkProvinceId;

  CityModel({
    required this.name,
    required this.cityId,
    required this.fkProvinceId,
  });

  factory CityModel.fromJson(final Map<String, dynamic> json) => CityModel(
        name: json['name'],
        cityId: json['city_id'],
        fkProvinceId: json['fk_province_id'],
      );
}
