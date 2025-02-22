// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'methods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonerooRemoteMethod _$MonerooRemoteMethodFromJson(Map<String, dynamic> json) =>
    MonerooRemoteMethod(
      name: json['name'] as String?,
      shortCode: json['short_code'] as String?,
      description: json['description'] as String?,
      gateways: (json['gateways'] as List<dynamic>?)
          ?.map((e) => Gateway.fromJson(e as Map<String, dynamic>))
          .toList(),
      iconUrl: json['icon_url'] as String?,
      isEnabled: json['is_enabled'] as bool?,
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => MonerooField.fromJson(e as Map<String, dynamic>))
          .toList(),
      currency: json['currency'] == null
          ? null
          : MethodCurrency.fromJson(json['currency'] as Map<String, dynamic>),
      countries: (json['countries'] as List<dynamic>?)
          ?.map((e) => MonerooCountry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MonerooRemoteMethodToJson(
        MonerooRemoteMethod instance) =>
    <String, dynamic>{
      'name': instance.name,
      'short_code': instance.shortCode,
      'description': instance.description,
      'gateways': instance.gateways,
      'icon_url': instance.iconUrl,
      'is_enabled': instance.isEnabled,
      'fields': instance.fields,
      'currency': instance.currency,
      'countries': instance.countries,
    };

MonerooField _$MonerooFieldFromJson(Map<String, dynamic> json) => MonerooField(
      label: json['label'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      length: json['length'],
    );

Map<String, dynamic> _$MonerooFieldToJson(MonerooField instance) =>
    <String, dynamic>{
      'label': instance.label,
      'type': instance.type,
      'name': instance.name,
      'length': instance.length,
    };

MethodCurrency _$MethodCurrencyFromJson(Map<String, dynamic> json) =>
    MethodCurrency(
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
      code: json['code'] as String?,
      iconUrl: json['icon_url'] as String?,
    );

Map<String, dynamic> _$MethodCurrencyToJson(MethodCurrency instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'code': instance.code,
      'icon_url': instance.iconUrl,
    };

MonerooCountry _$MonerooCountryFromJson(Map<String, dynamic> json) =>
    MonerooCountry(
      name: json['name'] as String?,
      code: json['code'] as String?,
      alpha3Code: json['alpha_3_code'] as String?,
      dialCode: json['dial_code'] as String?,
      currency: json['currency'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      flag: json['flag'] as String?,
    );

Map<String, dynamic> _$MonerooCountryToJson(MonerooCountry instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'alpha_3_code': instance.alpha3Code,
      'dial_code': instance.dialCode,
      'currency': instance.currency,
      'currency_symbol': instance.currencySymbol,
      'flag': instance.flag,
    };
