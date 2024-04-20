// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonerooPayment _$MonerooPaymentFromJson(Map<String, dynamic> json) =>
    MonerooPayment(
      id: json['id'] as String,
      checkoutUrl: json['checkout_url'] as String,
    );

Map<String, dynamic> _$MonerooPaymentToJson(MonerooPayment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'checkout_url': instance.checkoutUrl,
    };
