enum VerificationType {
  nationalId,
  email,
  phone,
  mobile,
  credit,
  video,
  business,
  postalCode;

  static VerificationType convert(final String value) {
    switch (value) {
      case 'EMAIL':
        return VerificationType.email;
      case 'MOBILE':
        return VerificationType.mobile;
      case 'NATIONAL_ID':
        return VerificationType.nationalId;
      case 'CREDIT':
        return VerificationType.credit;
      case 'PHONE':
        return VerificationType.phone;
      case 'VIDEO':
        return VerificationType.video;
      case 'POSTAL_CODE':
        return VerificationType.postalCode;
      case 'BUSINESS':
        return VerificationType.business;
    }

    return VerificationType.email;
  }
}
