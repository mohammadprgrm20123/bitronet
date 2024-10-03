enum DeviceType {
  android,
  ios;

  static DeviceType convert(final String type) {
    if (type == 'Android') {
      return DeviceType.android;
    }
    return DeviceType.ios;
  }
}
