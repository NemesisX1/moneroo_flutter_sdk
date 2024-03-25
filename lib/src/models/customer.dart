import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

/// Manage Customer data
@JsonSerializable()
class MonerooCustomer {
  ///
  MonerooCustomer({
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.address,
    this.city,
    this.country,
    this.state,
    this.zip,
  });

  ///
  factory MonerooCustomer.fromJson(Map<String, dynamic> json) =>
      _$MonerooCustomerFromJson(json);

  ///
  final String email;

  ///
  @JsonKey(name: 'first_name')
  final String firstName;

  ///
  @JsonKey(name: 'last_name')
  final String lastName;

  ///
  @JsonKey(includeIfNull: false)
  final String? phone;

  ///
  @JsonKey(includeIfNull: false)
  final String? address;

  ///
  @JsonKey(includeIfNull: false)
  final String? city;

  ///
  @JsonKey(includeIfNull: false)
  final String? state;

  ///
  @JsonKey(includeIfNull: false)
  final String? country;

  ///
  @JsonKey(includeIfNull: false)
  final String? zip;

  ///
  Map<String, dynamic> toJson() => _$MonerooCustomerToJson(this);
}
