
enum CashFormType {
  webMoney('WEBMONEY'),
  paypal('PAYPAL'),
  btc('BTC'),
  ethereum('ETHEREUM'),
  tether('TETER'),
  perfectMoney('PERFECTMONEY'),
  broker('BROKER_CASHINCOME'),
  perfectMoneyVoucher('PERFECTMONEY_VOUCHER'),
  wise('WISE'),
  hamster('HAMSTER');

  final String cashTypeTitle;

  const CashFormType(this.cashTypeTitle);
}