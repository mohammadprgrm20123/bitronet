class
ApiEndPoint {
  static String baseUrl = '';
  static const String version = '/api/v1';
  static const String loginApi = '/general/login';
  static const String registerApi = '/general/Register';
  static const String sendLoginCode = '/general/SendLoginSMS';
  static const String retryLoginCode = '/general/RetryLoginSMS';
  static const String getAllWorkPlaces = '/general/WorkplaceList';
  static const String getUseDetails = '/general/Profile';


  static const String activationWorkPlace = '/Boss/WorkplaceActive';
  static const String removeWorkPlace = '/Boss/WorkplaceRemove';
  static const String modifyWorkPlace = '/Boss/WorkplaceSave';
  static const String getAllShifts = '/Boss/ShiftList';
  static const String modifyShift = '/Boss/ShiftSave';
  static const String deleteShift = '/Boss/ShiftRemove';


}
