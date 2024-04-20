// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_infos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonerooPaymentInfos _$MonerooPaymentInfosFromJson(Map<String, dynamic> json) =>
    MonerooPaymentInfos(
      id: json['id'] as String?,
      status: $enumDecodeNullable(_$MonerooStatusEnumMap, json['status']),
      isProcessed: json['is_processed'] as bool?,
      processedAt: json['processed_at'],
      amount: json['amount'] as int?,
      currency: json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      amountFormatted: json['amount_formatted'] as String?,
      description: json['description'] as String?,
      returnUrl: json['return_url'] as String?,
      environment: json['environment'] as String?,
      initiatedAt: json['initiated_at'] == null
          ? null
          : DateTime.parse(json['initiated_at'] as String),
      metadata: json['metadata'],
      app: json['app'] == null
          ? null
          : App.fromJson(json['app'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : MonerooCustomer.fromJson(json['customer'] as Map<String, dynamic>),
      capture: json['capture'] == null
          ? null
          : Capture.fromJson(json['capture'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MonerooPaymentInfosToJson(
  MonerooPaymentInfos instance,
) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$MonerooStatusEnumMap[instance.status],
      'is_processed': instance.isProcessed,
      'processed_at': instance.processedAt,
      'amount': instance.amount,
      'currency': instance.currency,
      'amount_formatted': instance.amountFormatted,
      'description': instance.description,
      'return_url': instance.returnUrl,
      'environment': instance.environment,
      'initiated_at': instance.initiatedAt?.toIso8601String(),
      'metadata': instance.metadata,
      'app': instance.app,
      'customer': instance.customer,
      'capture': instance.capture,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$MonerooStatusEnumMap = {
  MonerooStatus.initiated: 'initiated',
  MonerooStatus.pending: 'pending',
  MonerooStatus.cancelled: 'cancelled',
  MonerooStatus.failed: 'failed',
  MonerooStatus.success: 'success',
};

App _$AppFromJson(Map<String, dynamic> json) => App(
      id: json['id'] as String?,
      name: json['name'] as String?,
      websiteUrl: json['website_url'] as String?,
      iconUrl: json['icon_url'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      isEnabled: json['is_enabled'] as bool?,
    );

Map<String, dynamic> _$AppToJson(App instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'website_url': instance.websiteUrl,
      'icon_url': instance.iconUrl,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'is_enabled': instance.isEnabled,
    };

Capture _$CaptureFromJson(Map<String, dynamic> json) => Capture(
      identifier: json['identifier'] as String?,
      rate: json['rate'],
      rateFormatted: json['rate_formatted'],
      correctionRate: json['correction_rate'],
      phoneNumber: json['phone_number'] as String?,
      failureMessage: json['failure_message'],
      failureErrorCode: json['failure_error_code'],
      failureErrorType: json['failure_error_type'],
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      amount: json['amount'] as int?,
      amountFormatted: json['amount_formatted'] as String?,
      currency: json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      method: json['method'] == null
          ? null
          : Method.fromJson(json['method'] as Map<String, dynamic>),
      gateway: json['gateway'] == null
          ? null
          : Gateway.fromJson(json['gateway'] as Map<String, dynamic>),
      context: json['context'] == null
          ? null
          : Context.fromJson(json['context'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CaptureToJson(Capture instance) => <String, dynamic>{
      'identifier': instance.identifier,
      'rate': instance.rate,
      'rate_formatted': instance.rateFormatted,
      'correction_rate': instance.correctionRate,
      'phone_number': instance.phoneNumber,
      'failure_message': instance.failureMessage,
      'failure_error_code': instance.failureErrorCode,
      'failure_error_type': instance.failureErrorType,
      'metadata': instance.metadata,
      'amount': instance.amount,
      'amount_formatted': instance.amountFormatted,
      'currency': instance.currency,
      'method': instance.method,
      'gateway': instance.gateway,
      'context': instance.context,
    };

Context _$ContextFromJson(Map<String, dynamic> json) => Context(
      ip: json['ip'] as String?,
      userAgent: json['user_agent'] == null
          ? null
          : UserAgent.fromJson(json['user_agent'] as Map<String, dynamic>),
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      local: json['local'] as String?,
    );

Map<String, dynamic> _$ContextToJson(Context instance) => <String, dynamic>{
      'ip': instance.ip,
      'user_agent': instance.userAgent,
      'country': instance.country,
      'local': instance.local,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      name: json['name'] as String?,
      code: json['code'] as String?,
      alpha3Code: json['alpha_3_code'] as String?,
      dialCode: json['dial_code'] as String?,
      currency: json['currency'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      flag: json['flag'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'alpha_3_code': instance.alpha3Code,
      'dial_code': instance.dialCode,
      'currency': instance.currency,
      'currency_symbol': instance.currencySymbol,
      'flag': instance.flag,
    };

UserAgent _$UserAgentFromJson(Map<String, dynamic> json) => UserAgent(
      isDesktop: json['is_desktop'] as bool?,
      isRobot: json['is_robot'] as bool?,
      platform: json['platform'] as String?,
      browser: json['browser'] as String?,
      version: json['version'] as String?,
      device: json['device'] as String?,
      isMobile: json['is_mobile'] as bool?,
      isPhone: json['is_phone'] as bool?,
      isTablet: json['is_tablet'] as bool?,
      isIos: json['is_ios'] as bool?,
      isAndroid: json['is_android'] as bool?,
    );

Map<String, dynamic> _$UserAgentToJson(UserAgent instance) => <String, dynamic>{
      'is_desktop': instance.isDesktop,
      'is_robot': instance.isRobot,
      'platform': instance.platform,
      'browser': instance.browser,
      'version': instance.version,
      'device': instance.device,
      'is_mobile': instance.isMobile,
      'is_phone': instance.isPhone,
      'is_tablet': instance.isTablet,
      'is_ios': instance.isIos,
      'is_android': instance.isAndroid,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
      symbolFirst: json['symbol_first'] as bool?,
      decimals: json['decimals'] as int?,
      decimalMark: json['decimal_mark'] as String?,
      thousandsSeparator: json['thousands_separator'] as String?,
      subunit: json['subunit'] as String?,
      subunitToUnit: json['subunit_to_unit'] as int?,
      symbolNative: json['symbol_native'] as String?,
      decimalDigits: json['decimal_digits'] as int?,
      rounding: json['rounding'] as int?,
      code: json['code'] as String?,
      namePlural: json['name_plural'] as String?,
      iconUrl: json['icon_url'] as String?,
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'symbol_first': instance.symbolFirst,
      'decimals': instance.decimals,
      'decimal_mark': instance.decimalMark,
      'thousands_separator': instance.thousandsSeparator,
      'subunit': instance.subunit,
      'subunit_to_unit': instance.subunitToUnit,
      'symbol_native': instance.symbolNative,
      'decimal_digits': instance.decimalDigits,
      'rounding': instance.rounding,
      'code': instance.code,
      'name_plural': instance.namePlural,
      'icon_url': instance.iconUrl,
    };

Gateway _$GatewayFromJson(Map<String, dynamic> json) => Gateway(
      id: json['id'] as String?,
      accountName: json['account_name'] as String?,
      name: json['name'] as String?,
      shortCode: json['short_code'] as String?,
      iconUrl: json['icon_url'] as String?,
      transactionId: json['transaction_id'] as String?,
      transactionStatus: json['transaction_status'] as String?,
      transactionFailureMessage: json['transaction_failure_message'] as String?,
    );

Map<String, dynamic> _$GatewayToJson(Gateway instance) => <String, dynamic>{
      'id': instance.id,
      'account_name': instance.accountName,
      'name': instance.name,
      'short_code': instance.shortCode,
      'icon_url': instance.iconUrl,
      'transaction_id': instance.transactionId,
      'transaction_status': instance.transactionStatus,
      'transaction_failure_message': instance.transactionFailureMessage,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      networkTransactionId: json['network_transaction_id'] as String?,
      amountDebited: json['amount_debited'],
      commission: json['commission'],
      fees: json['fees'] as String?,
      selectedPaymentMethod: json['selected_payment_method'] as String?,
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'network_transaction_id': instance.networkTransactionId,
      'amount_debited': instance.amountDebited,
      'commission': instance.commission,
      'fees': instance.fees,
      'selected_payment_method': instance.selectedPaymentMethod,
    };

Method _$MethodFromJson(Map<String, dynamic> json) => Method(
      id: json['id'] as String?,
      name: json['name'] as String?,
      shortCode: json['short_code'] as String?,
      iconUrl: json['icon_url'] as String?,
    );

Map<String, dynamic> _$MethodToJson(Method instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'short_code': instance.shortCode,
      'icon_url': instance.iconUrl,
    };
