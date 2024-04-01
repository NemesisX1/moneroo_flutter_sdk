// ignore_for_file: public_member_api_docs, constant_identifier_names

/// Help to give an API version for the API
enum MonerooVersion {
  v1,
}

/// Allowed currency on Moneroo
enum MonerooCurency {
  XAF,
  XOF,
  USD,
  NGN,
}

/// Give the current status of a payment
enum MonerooStatus {
  initiated,
  pending,
  cancelled,
  failed,
  success,
}
