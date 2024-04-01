// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';
import 'package:moneroo_flutter_sdk/src/commons/enums.dart';
part 'payment_infos.g.dart';

@JsonSerializable()
class PaymentInfos {
  PaymentInfos({
    required this.id,
    required this.status,
    required this.isProcessed,
    required this.processedAt,
    required this.amount,
    required this.currency,
    required this.amountFormatted,
    required this.description,
    required this.returnUrl,
    required this.environment,
    required this.initiatedAt,
    // required this.metadata,
    // required this.app,
    // required this.customer,
    // required this.capture,
    required this.createdAt,
  });
  factory PaymentInfos.fromJson(Map<String, dynamic> json) =>
      _$PaymentInfosFromJson(json);

  final String? id;
  final MonerooStatus? status;

  @JsonKey(name: 'is_processed')
  final bool? isProcessed;

  @JsonKey(name: 'processed_at')
  final dynamic processedAt;
  final int? amount;
  final Currency? currency;

  @JsonKey(name: 'amount_formatted')
  final String? amountFormatted;
  final String? description;

  @JsonKey(name: 'return_url')
  final String? returnUrl;
  final String? environment;

  @JsonKey(name: 'initiated_at')
  final DateTime? initiatedAt;
  // final List<dynamic>? metadata;
  // final App? app;
  /// final Customer? customer;
  // final Capture? capture;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => _$PaymentInfosToJson(this);
}

@JsonSerializable()
class App {
  App({
    required this.id,
    required this.name,
    required this.websiteUrl,
    required this.iconUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.isEnabled,
  });

  factory App.fromJson(Map<String, dynamic> json) => _$AppFromJson(json);

  final String? id;
  final String? name;

  @JsonKey(name: 'website_url')
  final String? websiteUrl;

  @JsonKey(name: 'icon_url')
  final String? iconUrl;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'is_enabled')
  final bool? isEnabled;

  Map<String, dynamic> toJson() => _$AppToJson(this);
}

@JsonSerializable()
class Capture {
  Capture({
    required this.identifier,
    required this.rate,
    required this.rateFormatted,
    required this.correctionRate,
    required this.phoneNumber,
    required this.failureMessage,
    required this.failureErrorCode,
    required this.failureErrorType,
    required this.metadata,
    required this.amount,
    required this.amountFormatted,
    required this.currency,
    required this.method,
    required this.gateway,
    required this.context,
  });
  factory Capture.fromJson(Map<String, dynamic> json) =>
      _$CaptureFromJson(json);

  final String? identifier;
  final dynamic rate;

  @JsonKey(name: 'rate_formatted')
  final dynamic rateFormatted;

  @JsonKey(name: 'correction_rate')
  final dynamic correctionRate;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'failure_message')
  final dynamic failureMessage;

  @JsonKey(name: 'failure_error_code')
  final dynamic failureErrorCode;

  @JsonKey(name: 'failure_error_type')
  final dynamic failureErrorType;
  final Metadata? metadata;
  final int? amount;

  @JsonKey(name: 'amount_formatted')
  final String? amountFormatted;
  final Currency? currency;
  final Method? method;
  final Gateway? gateway;
  final Context? context;

  Map<String, dynamic> toJson() => _$CaptureToJson(this);
}

@JsonSerializable()
class Context {
  Context({
    required this.ip,
    required this.userAgent,
    required this.country,
    required this.local,
  });
  factory Context.fromJson(Map<String, dynamic> json) =>
      _$ContextFromJson(json);

  final String? ip;

  @JsonKey(name: 'user_agent')
  final UserAgent? userAgent;
  final Country? country;
  final String? local;

  Map<String, dynamic> toJson() => _$ContextToJson(this);
}

@JsonSerializable()
class Country {
  Country({
    required this.name,
    required this.code,
    required this.alpha3Code,
    required this.dialCode,
    required this.currency,
    required this.currencySymbol,
    required this.flag,
  });
  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  final String? name;
  final String? code;

  @JsonKey(name: 'alpha_3_code')
  final String? alpha3Code;

  @JsonKey(name: 'dial_code')
  final String? dialCode;
  final String? currency;

  @JsonKey(name: 'currency_symbol')
  final String? currencySymbol;
  final String? flag;

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class UserAgent {
  UserAgent({
    required this.isDesktop,
    required this.isRobot,
    required this.platform,
    required this.browser,
    required this.version,
    required this.device,
    required this.isMobile,
    required this.isPhone,
    required this.isTablet,
    required this.isIos,
    required this.isAndroid,
  });
  factory UserAgent.fromJson(Map<String, dynamic> json) =>
      _$UserAgentFromJson(json);

  @JsonKey(name: 'is_desktop')
  final bool? isDesktop;

  @JsonKey(name: 'is_robot')
  final bool? isRobot;
  final String? platform;
  final String? browser;
  final String? version;
  final String? device;

  @JsonKey(name: 'is_mobile')
  final bool? isMobile;

  @JsonKey(name: 'is_phone')
  final bool? isPhone;

  @JsonKey(name: 'is_tablet')
  final bool? isTablet;

  @JsonKey(name: 'is_ios')
  final bool? isIos;

  @JsonKey(name: 'is_android')
  final bool? isAndroid;

  Map<String, dynamic> toJson() => _$UserAgentToJson(this);
}

@JsonSerializable()
class Currency {
  Currency({
    required this.name,
    required this.symbol,
    required this.symbolFirst,
    required this.decimals,
    required this.decimalMark,
    required this.thousandsSeparator,
    required this.subunit,
    required this.subunitToUnit,
    required this.symbolNative,
    required this.decimalDigits,
    required this.rounding,
    required this.code,
    required this.namePlural,
    required this.iconUrl,
  });
  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  final String? name;
  final String? symbol;

  @JsonKey(name: 'symbol_first')
  final bool? symbolFirst;
  final int? decimals;

  @JsonKey(name: 'decimal_mark')
  final String? decimalMark;

  @JsonKey(name: 'thousands_separator')
  final String? thousandsSeparator;
  final String? subunit;

  @JsonKey(name: 'subunit_to_unit')
  final int? subunitToUnit;

  @JsonKey(name: 'symbol_native')
  final String? symbolNative;

  @JsonKey(name: 'decimal_digits')
  final int? decimalDigits;
  final int? rounding;
  final String? code;

  @JsonKey(name: 'name_plural')
  final String? namePlural;

  @JsonKey(name: 'icon_url')
  final String? iconUrl;

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}

@JsonSerializable()
class Gateway {
  Gateway({
    required this.id,
    required this.accountName,
    required this.name,
    required this.shortCode,
    required this.iconUrl,
    required this.transactionId,
    required this.transactionStatus,
    required this.transactionFailureMessage,
  });
  factory Gateway.fromJson(Map<String, dynamic> json) =>
      _$GatewayFromJson(json);

  final String? id;

  @JsonKey(name: 'account_name')
  final String? accountName;
  final String? name;

  @JsonKey(name: 'short_code')
  final String? shortCode;

  @JsonKey(name: 'icon_url')
  final String? iconUrl;

  @JsonKey(name: 'transaction_id')
  final String? transactionId;

  @JsonKey(name: 'transaction_status')
  final String? transactionStatus;

  @JsonKey(name: 'transaction_failure_message')
  final String? transactionFailureMessage;

  Map<String, dynamic> toJson() => _$GatewayToJson(this);
}

@JsonSerializable()
class Metadata {
  Metadata({
    required this.networkTransactionId,
    required this.amountDebited,
    required this.commission,
    required this.fees,
    required this.selectedPaymentMethod,
  });
  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  @JsonKey(name: 'network_transaction_id')
  final String? networkTransactionId;

  @JsonKey(name: 'amount_debited')
  final dynamic amountDebited;
  final dynamic commission;
  final String? fees;

  @JsonKey(name: 'selected_payment_method')
  final String? selectedPaymentMethod;

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable()
class Method {
  Method({
    required this.id,
    required this.name,
    required this.shortCode,
    required this.iconUrl,
  });
  factory Method.fromJson(Map<String, dynamic> json) => _$MethodFromJson(json);

  final String? id;
  final String? name;

  @JsonKey(name: 'short_code')
  final String? shortCode;

  @JsonKey(name: 'icon_url')
  final String? iconUrl;

  Map<String, dynamic> toJson() => _$MethodToJson(this);
}

@JsonSerializable()
class Customer {
  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.countryCode,
    required this.country,
    required this.zipCode,
    required this.profileUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  final String? id;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? email;
  final dynamic phone;
  final dynamic address;
  final dynamic city;
  final dynamic state;

  @JsonKey(name: 'country_code')
  final dynamic countryCode;
  final dynamic country;

  @JsonKey(name: 'zip_code')
  final dynamic zipCode;

  @JsonKey(name: 'profile_url')
  final String? profileUrl;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
