// ignore_for_file: public_member_api_docs, constant_identifier_names

/// Help to give an API version for the API
enum MonerooVersion {
  v1,
}

/// Allowed currency on Moneroo
enum MonerooCurrency {
  CDF, // Airtel Congo (airtel_cd)

  MWK, // Airtel Money Malawi (airtel_mw)

  /// QR Code Nigeria (qr_ngn),
  /// Airtel Money Nigeria (airtel_ng),
  /// Bank Transfer NG (bank_transfer_ng), Barter (barter)
  NGN,

  ZMW, // Airtel Zambia (airtel_zm)

  GHS, // Credit Card GHS (card_ghs), Crypto GHS (crypto_ghs), Airtel/Tigo Ghana (tigo_gh), Vodafone Ghana (vodafone_gh)

  /// Card Kenya (card_kes), M-Pesa Kenya (mpesa_ke),
  /// TNM Mpamba Malawi (tnm_mw)
  KES,

  /// Airtel Tanzania (airtel_tz),
  /// Card Tanzania (card_tzs),
  /// Vodacom Tanzania (mpesa_tz), Tigo Tanzania (tigo_tz)
  TZS,

  /// Airtel Uganda (airtel_ug),
  /// Card Uganda (card_ugx), MTN MoMo Uganda (mtn_ug)
  UGX,

  /// Credit Card USD (card_usd),
  /// Crypto USD (crypto_usd),
  /// Test Payment Method (moneroo_payment_demo)
  USD,

  /// Credit Card XAF (card_xaf), Crypto XAF (crypto_xaf)
  /// EU Mobile Money Cameroon (eu_mobile_cm)
  /// MTN MoMo Cameroon (mtn_cm),
  /// Orange Money Cameroon (orange_cm), Wave CI (wave_ci)
  XAF,

  /// Airtel Niger (airtel_ne), Credit Card XOF (card_xof)
  /// Crypto XOF (crypto_xof), Moov Burkina Faso (moov_bf)
  /// Moov Money Benin (moov_bj), Moov Money CI (moov_ci),
  ///  Moov Money Mali (moov_ml), Moov Money Togo (moov_tg),
  /// MTN MoMo Benin (mtn_bj), MTN MoMo CI (mtn_ci),
  /// E-Money Senegal (e_money_sn), Free Money Senegal (freemoney_sn),
  /// Mobi Cash Mali (mobi_cash_ml), Orange Burkina Faso (orange_bf),
  /// Orange Money CI (orange_ci), Orange Money Guinea (orange_gn),
  /// Orange Money Mali (orange_ml),Orange Money Senegal (orange_sn),
  /// Wave Senegal (wave_sn), Wizall Senegal (wizall_sn),
  /// Togocel Money (togocel)
  XOF,

  ZAR, // Credit Card ZAR (card_zar)

  EUR, // Crypto EUR (crypto_eur)

  GNF, // MTN MoMo Guinea (mtn_gn), Orange Money Guinea (orange_gn)

  RWF, //Airtel Rwanda (airtel_rw), MTN MoMo Rwanda (mtn_rw)
}

enum MonerooMethod {
  djamo_ci,
  djamo_sandbox_ci,
  djamo_sn,
  djamo_sandbox_sn,
  e_money_sn,
  hubtwo_payout_sn,
  paydunya,
  freemoney_sn,
  pawapay,
  one_pay,
  one_pay_sandbox,
  pawapay_sandbox,
  moov_bf,
  hubtwo_payout_bf,
  moov_bj,
  hubtwo_payout_bj,
  qosic_bj,
  kkiapay,
  kkiapay_sandbox,
  moov_ci,
  hubtwo_payout_ci,
  moov_ml,
  hubtwo_payout_ml,
  moov_tg,
  qosic_tg,
  mtn_bj,
  mtn_ci,
  orange_bf,
  orange_ci,
  orange_ml,
  orange_sn,
  togocel,
  wave_ci,
  wave_business_payout_ci,
  wave_sn
}

/// Give the current status of a payment
enum MonerooStatus {
  initiated,
  pending,
  cancelled,
  failed,
  success,
}
