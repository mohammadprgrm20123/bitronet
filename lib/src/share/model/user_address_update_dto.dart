class UserAddressUpdateDto {
  String? postalCode;
  int? fkCityId;
  String? address;
  int? fkProvinceId;

  UserAddressUpdateDto(
      {this.postalCode, this.fkCityId, this.address, this.fkProvinceId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postal_code'] = postalCode;
    data['fk_city_id'] = fkCityId;
    data['address'] = address;
    data['fk_province_id'] = fkProvinceId;
    return data;
  }

  Map<String, dynamic> toJsonJustPostalCode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postal_code'] = postalCode;
    return data;
  }
}
