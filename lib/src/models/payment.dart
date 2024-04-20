import 'package:json_annotation/json_annotation.dart';
part 'payment.g.dart';

@JsonSerializable()

/// Base payment class
class MonerooPayment {
  ///
  MonerooPayment({
    required this.id,
    required this.checkoutUrl,
  });

  ///
  factory MonerooPayment.fromJson(Map<String, dynamic> json) =>
      _$MonerooPaymentFromJson(json);

  ///
  @JsonKey()
  final String id;

  ///
  @JsonKey(name: 'checkout_url')
  final String checkoutUrl;

  ///
  Map<String, dynamic> toJson() => _$MonerooPaymentToJson(this);
}
