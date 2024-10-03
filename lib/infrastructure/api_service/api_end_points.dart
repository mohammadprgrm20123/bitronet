class
ApiEndPoint {
  static String baseUrl = '';
  static const String version = '/api/v1';
  static const String loginApi = '/general/login';
  static const String verifyCode = '/$version/auth/validate/token';
  static const String resendVerifyCode = '/$version/auth/token/resend';
  static const String forgetPassword = '/$version/auth/password/forget';
  static const String register = '/$version/auth/register';
  static const String getAllOrders = '/$version/orders';
  static const String getCashIncomes = '/$version/casheincomes/cash-services-list';
  static const String createOrder = '/$version/orders/create';

  static String orderPrice(final String serviceId) =>
      '/$version/orders/calc/$serviceId/price';

  static const String getProvince = '/$version/provinces';

  static String getCashForm(final String type) =>
      '/$version/casheincomes/create/$type';

  static String getCity(final String id) => '/$version/cities/$id';

  static String orderRegister(final String id) => '/orders/new/order/$id';
  static String cashRegister = '/cashincomes/create';

  static String getCalculateCashPrice(
          {required final String amount,
          required final String currencyId,
          required final String type}) =>
      '/$version/casheincomes/$type/calculate?amount=$amount&currency=$currencyId';

  static String getCashIncomesDetails(final String id) =>
      '$version/casheincomes/$id';

  static String checkDiscountCode(final String id) => '/vouchers/check/$id';

  static String getPaymentDetails(final String id) =>
      '$version/transactions/$id';
  static String getOrderTransaction = '$version/orders/list';
  static String getCashIncomesTransaction = '$version/casheincomes/list';
  static String getTransactions = '$version/transactions';

  static String getOrderInvoiceDetails(final String id) =>
      '$version/orders/show/$id';
  static String addFund = '/wallet/addfund';
  static String getUserDetails = '$version/profile?size=150';
  static String updateUserDetails = '/profile/update';
  static String withdrawOtp = '$version/transactions/withdraw/otp';
  static String withdrawRequest = '/wallet/withdraw';
  static String getDashboard = version;
  static String changePassword = '/profile/change-password';
  static String getAllTickets = '$version/tickets';
  static String getCreateTicketData = '$version/tickets/create';
  static String createTicket = '/tickets/store';

  static String createReply(final int id) => '/tickets/reply/$id';

  static String getTicketDetails(final String id) =>
      '$version/tickets/show/$id';

  static String payWithWallet(final String id) => '/wallet/invoice/$id/send';

  static String onlinePayment(final String id) => '/wallet/invoice/$id/send';

  static String polPayment(final String id) => '/wallet/invoice/$id/send';
  static String getBankCards = '$version/bank-credits';
  static String submitCreditCard = '/bank-credits/create';
  static String submitDocument = '/profile/upload-document';
  static String submitPhoneAndPostalCode = '/profile/upload-document';
  static String getAddressData = '/profile/address/get';
  static String updateUserAddress = '/profile/address/update';
  static String uploadVideo = '$version/profile/video/record';
  static String uploadAvatar = '/profile/avatar';
  static String getNotifications = '$version/notifications';
  static String submitLegalInfo = '/profile/update';
  static String ajaxVerify = '/profile/verify-ajax';
  static String getAllEvents = '$version/notifications/list';
  static String getProductDetails = '$version/orders/amazon/ae/product-details';

  static String readMessage(final int id) => '$version/notifications/$id';
  static String userAddresses = '$version/profile/userAddresses';
  static String createAddress = '$version/profile/userAddresses';

  static String getVersion(final String deviceType) =>
      '$version/app/get-version?device_type=$deviceType';
}
