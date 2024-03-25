// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonerooCustomer _$MonerooCustomerFromJson(Map<String, dynamic> json) =>
    MonerooCustomer(
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      zip: json['zip'] as String?,
    );

Map<String, dynamic> _$MonerooCustomerToJson(MonerooCustomer instance) {
  final val = <String, dynamic>{
    'email': instance.email,
    'first_name': instance.firstName,
    'last_name': instance.lastName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('phone', instance.phone);
  writeNotNull('address', instance.address);
  writeNotNull('city', instance.city);
  writeNotNull('state', instance.state);
  writeNotNull('country', instance.country);
  writeNotNull('zip', instance.zip);
  return val;
}
