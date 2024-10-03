enum FormFileType {
  giftBuy,
  webMoneyCharge,
  perfectMoneyVoucher,
  onlyBuy,
  onlyOpening,
  onlyCharge,
  vipTrezor,
  draftPersonalSwift;

  static FormFileType convert(final String type) {
    if (type.endsWith('gift.buy')) {
      return FormFileType.giftBuy;
    }

    if (type.endsWith('webmoney.charge')) {
      return FormFileType.webMoneyCharge;
    }

    if (type.endsWith('perfectmoney.voucher')) {
      return FormFileType.perfectMoneyVoucher;
    }

    if (type.endsWith('buy')) {
      return FormFileType.onlyBuy;
    }

    if (type.endsWith('opening')) {
      return FormFileType.onlyOpening;
    }

    if (type.endsWith('charge')) {
      return FormFileType.onlyCharge;
    }

    if (type.endsWith('vip.trezor')) {
      return FormFileType.vipTrezor;
    }

    return FormFileType.draftPersonalSwift;
  }
}
