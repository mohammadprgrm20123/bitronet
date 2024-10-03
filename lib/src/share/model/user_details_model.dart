import 'auth_status.dart';
import 'level_status.dart';
import 'verification_type.dart';

class UserDetailsModel {
  Data data;

  UserDetailsModel({required this.data});

  factory UserDetailsModel.fromJson(final Map<String, dynamic> json) =>
      UserDetailsModel(
        data: Data.fromJson(json['data']),
      );
}

class Data {
  User? user;
  int? balance;
  List<VerificationModel> verifications;
  Map<String, dynamic>? verificationTypes;
  VerificationSettings verificationSettings;
  String? avatar;

  Data({
    required this.verificationSettings,
    required this.verifications,
    this.user,
    this.balance,
    this.verificationTypes,
    this.avatar,
  });

  factory Data.fromJson(final Map<String, dynamic> json) {
    final verifications = <VerificationModel>[];
    if (json['verifications'] != null) {
      json['verifications'].forEach((final v) {
        verifications.add(VerificationModel.fromJson(v));
      });
    }

    return Data(
      verifications: verifications,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      avatar: json['avatar'],
      balance: json['balance'],
      verificationTypes: json['verificationTypes'] != null
          ? (json['verificationTypes'])
          : null,
      verificationSettings:
          VerificationSettings.fromJson(json['verificationSettings']),
    );
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? email;
  String? nationalCode;
  String? mobile;
  String? phone;
  Info? info;
  int? status;
  int? fkCityId;
  int? fkProvinceId;
  String? postalCode;
  String? address;
  String? birthday;
  bool? isBusiness;
  String? createdAt;
  String? updatedAt;
  int? weTrust;
  int? block;
  String? lastLoginAt;
  String? lastLoginIp;
  String? notifyLogin;
  int? towFactorAuth;
  String? ip;
  String? adminText;
  String? tfaType;
  String? affiliateId;
  String? reagent;
  int? limit;
  LevelStatus? level;
  int? userProfit;
  int? canWithdraw;
  int? canAddfund;
  int? needVideoVerification;
  int? cooperation;
  int? fkSeconderId;
  int? confirmed;
  String? onlineChatToken;
  int? enableAutoOrder;
  int? avalClubPoint;
  bool? avalClubIsActive;
  String? originalName;
  String? birthdayFa;
  Province? province;
  City? city;

  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.nationalCode,
      this.mobile,
      this.info,
      this.phone,
      this.status,
      this.fkCityId,
      this.fkProvinceId,
      this.postalCode,
      this.address,
      this.birthday,
      this.isBusiness,
      this.createdAt,
      this.updatedAt,
      this.weTrust,
      this.block,
      this.lastLoginAt,
      this.lastLoginIp,
      this.notifyLogin,
      this.towFactorAuth,
      this.ip,
      this.adminText,
      this.tfaType,
      this.affiliateId,
      this.reagent,
      this.limit,
      this.level,
      this.userProfit,
      this.canWithdraw,
      this.canAddfund,
      this.needVideoVerification,
      this.cooperation,
      this.fkSeconderId,
      this.confirmed,
      this.onlineChatToken,
      this.enableAutoOrder,
      this.avalClubPoint,
      this.avalClubIsActive,
      this.originalName,
      this.birthdayFa,
      this.province,
      this.city});

  User.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    nationalCode = json['national_code'];
    mobile = json['mobile'];
    phone = json['phone'];
    info = json['info'] == null ? null : Info.fromJson(json['info']);
    status = json['status'];
    fkCityId = json['fk_city_id'];
    fkProvinceId = json['fk_province_id'];
    postalCode = json['postal_code'];
    address = json['address'];
    birthday = json['birthday'];
    isBusiness = json['is_business'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    weTrust = json['we_trust'];
    block = json['block'];
    lastLoginAt = json['last_login_at'];
    lastLoginIp = json['last_login_ip'];
    notifyLogin = json['notify_login'];
    towFactorAuth = json['tow_factor_auth'];
    ip = json['ip'];
    adminText = json['admin_text'];
    tfaType = json['tfa_type'];
    affiliateId = json['affiliate_id'];
    reagent = json['reagent'];
    limit = json['limit'];
    level = LevelStatus.convert(json['level']);
    userProfit = json['user_profit'];
    canWithdraw = json['can_withdraw'];
    canAddfund = json['can_addfund'];
    needVideoVerification = json['need_video_verification'];
    cooperation = json['cooperation'];
    fkSeconderId = json['fk_seconder_id'];
    confirmed = json['confirmed'];
    onlineChatToken = json['online_chat_token'];
    enableAutoOrder = json['enable_auto_order'];
    avalClubPoint = json['avalClubPoint'];
    avalClubIsActive = json['avalClubIsActive'];
    originalName = json['originalName'];
    birthdayFa = json['birthday_fa'];
    province =
        json['province'] != null ? Province.fromJson(json['province']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }
}

class Info {
  int? id;
  int? userId;
  String? bankName;
  String? bankAccountNumber;
  String? bankAccountCardNumber;
  String? bankAccountSheba;
  VerificationStatus? verificationStatus;
  bool? canUseAlternativeGateway;
  BusinessInformation? businessInformation;
  String? createdAt;
  String? updatedAt;

  Info(
      {this.id,
      this.userId,
      this.bankName,
      this.bankAccountNumber,
      this.bankAccountCardNumber,
      this.bankAccountSheba,
      this.verificationStatus,
      this.canUseAlternativeGateway,
      this.businessInformation,
      this.createdAt,
      this.updatedAt});

  Info.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bankName = json['bank_name'];
    bankAccountNumber = json['bank_account_number'];
    bankAccountCardNumber = json['bank_account_card_number'];
    bankAccountSheba = json['bank_account_sheba'];
    verificationStatus = json['verification_status'] != null
        ? VerificationStatus.fromJson(json['verification_status'])
        : null;
    canUseAlternativeGateway = json['can_use_alternative_gateway'];
    businessInformation = json['business_information'] != null
        ? BusinessInformation.fromJson(json['business_information'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class VerificationStatus {
  String? autoVerificationGetaddressbypostalcode;
  String? autoVerificationValidatemobilenumber;
  String? autoVerificationGetinformationfrombankcard;

  VerificationStatus(
      {this.autoVerificationGetaddressbypostalcode,
      this.autoVerificationValidatemobilenumber,
      this.autoVerificationGetinformationfrombankcard});

  VerificationStatus.fromJson(Map<String, dynamic> json) {
    autoVerificationGetaddressbypostalcode =
        json['auto_verification_getaddressbypostalcode'];
    autoVerificationValidatemobilenumber =
        json['auto_verification_validatemobilenumber'];
    autoVerificationGetinformationfrombankcard =
        json['auto_verification_getinformationfrombankcard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['auto_verification_getaddressbypostalcode'] =
        this.autoVerificationGetaddressbypostalcode;
    data['auto_verification_validatemobilenumber'] =
        this.autoVerificationValidatemobilenumber;
    data['auto_verification_getinformationfrombankcard'] =
        this.autoVerificationGetinformationfrombankcard;
    return data;
  }
}

class BusinessInformation {
  String? name;
  String? financialCode;
  String? registerNumber;
  String? nationalIndex;

  BusinessInformation(
      {this.name, this.financialCode, this.registerNumber, this.nationalIndex});

  BusinessInformation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    financialCode = json['financial_code'];
    registerNumber = json['register_number'];
    nationalIndex = json['national_index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['financial_code'] = this.financialCode;
    data['register_number'] = this.registerNumber;
    data['national_index'] = this.nationalIndex;
    return data;
  }
}

class Province {
  int? provinceId;
  String? name;

  Province({this.provinceId, this.name});

  Province.fromJson(final Map<String, dynamic> json) {
    provinceId = json['province_id'];
    name = json['name'];
  }
}

class City {
  int? cityId;
  int? fkProvinceId;
  String? name;

  City({this.cityId, this.fkProvinceId, this.name});

  City.fromJson(final Map<String, dynamic> json) {
    cityId = json['city_id'];
    fkProvinceId = json['fk_province_id'];
    name = json['name'];
  }
}

class VerificationModel {
  VerificationType verificationType;
  AuthStatus resultStatus;

  VerificationModel(
      {required this.verificationType, required this.resultStatus});

  factory VerificationModel.fromJson(final Map<String, dynamic> json) =>
      VerificationModel(
        verificationType: VerificationType.convert(json['verification_type']),
        resultStatus: AuthStatus.convert(json['resultStatus']),
      );
}

class VerificationTypes {
  String? email;
  String? mobile;
  String? nationalId;
  String? credit;
  String? phone;
  String? video;
  String? postalCade;
  String? business;

  VerificationTypes(
      {this.email,
      this.mobile,
      this.nationalId,
      this.credit,
      this.phone,
      this.video,
      this.postalCade,
      this.business});

  VerificationTypes.fromJson(final Map<String, dynamic> json) {
    email = json['EMAIL'];
    mobile = json['MOBILE'];
    nationalId = json['NATIONAL_ID'];
    credit = json['CREDIT'];
    phone = json['PHONE'];
    video = json['VIDEO'];
    postalCade = json['POSTAL_CODE'];
    business = json['BUSINESS'];
  }
}

class VerificationSettings {
  bool canVerifyBUSINESS;
  bool showVerifyBUSINESS;
  bool canVerifyPOSTALCODE;
  bool canVerifyCREDIT;
  AuthStatus bankCardVerificationStatus;
  bool autoAddressVerification;
  bool autoGetBankData;
  String videoVerificationText;

  VerificationSettings({
    required this.bankCardVerificationStatus,
    required this.canVerifyBUSINESS,
    required this.showVerifyBUSINESS,
    required this.canVerifyPOSTALCODE,
    required this.canVerifyCREDIT,
    required this.autoAddressVerification,
    required this.autoGetBankData,
    required this.videoVerificationText,
  });

  factory VerificationSettings.fromJson(final Map<String, dynamic> json) =>
      VerificationSettings(
        canVerifyBUSINESS: json['can_verify_BUSINESS'],
        showVerifyBUSINESS: json['show_verify_BUSINESS'],
        canVerifyPOSTALCODE: json['can_verify_POSTAL_CODE'],
        canVerifyCREDIT: json['can_verify_CREDIT'],
        bankCardVerificationStatus:
            AuthStatus.convert(json['bank_card_verification_status']),
        autoAddressVerification: json['auto_address_verification'],
        autoGetBankData: json['auto_get_bank_data'],
        videoVerificationText: json['video_verification_text'],
      );
}

class ThemeDetails {
  WebDesktop? webDesktop;
  WebDesktop? webMobile;

  ThemeDetails({this.webDesktop, this.webMobile});

  ThemeDetails.fromJson(final Map<String, dynamic> json) {
    webDesktop = json['web_desktop'] != null
        ? WebDesktop.fromJson(json['web_desktop'])
        : null;
    webMobile = json['web_mobile'] != null
        ? WebDesktop.fromJson(json['web_mobile'])
        : null;
  }
}

class WebDesktop {
  String? hueRotationValue;
  String? fontWeightValue;
  String? wordSpacingValue;
  String? grayScaleValue;
  String? fontSizeValue;
  String? showThemeButton;
  String? systemTheme;
  String? linkUnderline;
  String? lineHeightValue;
  String? pattern;
  String? isThemeDark;
  String? theme;
  String? isAnimationEnabled;

  WebDesktop(
      {this.hueRotationValue,
      this.fontWeightValue,
      this.wordSpacingValue,
      this.grayScaleValue,
      this.fontSizeValue,
      this.showThemeButton,
      this.systemTheme,
      this.linkUnderline,
      this.lineHeightValue,
      this.pattern,
      this.isThemeDark,
      this.theme,
      this.isAnimationEnabled});

  WebDesktop.fromJson(final Map<String, dynamic> json) {
    hueRotationValue = json['hueRotationValue'];
    fontWeightValue = json['fontWeightValue'];
    wordSpacingValue = json['wordSpacingValue'];
    grayScaleValue = json['grayScaleValue'];
    fontSizeValue = json['fontSizeValue'];
    showThemeButton = json['showThemeButton'];
    systemTheme = json['systemTheme'];
    linkUnderline = json['linkUnderline'];
    lineHeightValue = json['lineHeightValue'];
    pattern = json['pattern'];
    isThemeDark = json['isThemeDark'];
    theme = json['theme'];
    isAnimationEnabled = json['isAnimationEnabled'];
  }
}
