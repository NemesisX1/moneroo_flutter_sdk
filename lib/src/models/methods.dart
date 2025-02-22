import 'package:json_annotation/json_annotation.dart';
import 'package:moneroo_flutter_sdk/src/models/payment_infos.dart';

part 'methods.g.dart';

@JsonSerializable()

/// Moneroo available payment methods
class MonerooMethod {
  ///
  MonerooMethod({
    required this.name,
    required this.shortCode,
    required this.description,
    required this.gateways,
    required this.iconUrl,
    required this.isEnabled,
    required this.fields,
    required this.currency,
    required this.countries,
  });

  ///
  factory MonerooMethod.fromJson(Map<String, dynamic> json) =>
      _$MonerooMethodFromJson(json);

  ///
  Map<String, dynamic> toJson() => _$MonerooMethodToJson(this);

  ///
  final String? name;

  ///
  @JsonKey(name: 'short_code')
  final String? shortCode;

  ///
  final String? description;

  ///
  final List<Gateway>? gateways;

  ///
  @JsonKey(name: 'icon_url')
  final String? iconUrl;

  ///
  @JsonKey(name: 'is_enabled')
  final bool? isEnabled;

  ///
  final List<MonerooField>? fields;

  ///
  final MethodCurrency? currency;

  ///
  final List<MonerooCountry>? countries;
}

///
@JsonSerializable()
class MonerooField {
  ///
  MonerooField({
    required this.label,
    required this.type,
    required this.name,
    required this.length,
  });

  ///
  factory MonerooField.fromJson(Map<String, dynamic> json) =>
      _$MonerooFieldFromJson(json);

  ///
  Map<String, dynamic> toJson() => _$MonerooFieldToJson(this);

  ///
  final String? label;

  ///
  final String? type;

  ///
  final String? name;

  ///
  final dynamic length;
}

///
@JsonSerializable()
class MethodCurrency {
  ///
  MethodCurrency({
    required this.name,
    required this.symbol,
    required this.code,
    required this.iconUrl,
  });

  ///
  factory MethodCurrency.fromJson(Map<String, dynamic> json) =>
      _$MethodCurrencyFromJson(json);

  ///
  Map<String, dynamic> toJson() => _$MethodCurrencyToJson(this);

  ///
  final String? name;

  ///
  final String? symbol;

  ///
  final String? code;

  ///
  @JsonKey(name: 'icon_url')
  final String? iconUrl;
}

///
@JsonSerializable()
class MonerooCountry {
  ///
  MonerooCountry({
    required this.name,
    required this.code,
    required this.alpha3Code,
    required this.dialCode,
    required this.currency,
    required this.currencySymbol,
    required this.flag,
  });

  ///
  factory MonerooCountry.fromJson(Map<String, dynamic> json) =>
      _$MonerooCountryFromJson(json);

  ///
  Map<String, dynamic> toJson() => _$MonerooCountryToJson(this);

  ///
  final String? name;

  ///
  final String? code;

  ///
  @JsonKey(name: 'alpha_3_code')
  final String? alpha3Code;

  ///
  @JsonKey(name: 'dial_code')
  final String? dialCode;

  ///

  final String? currency;

  ///
  @JsonKey(name: 'currency_symbol')
  final String? currencySymbol;

  ///
  final String? flag;
}
