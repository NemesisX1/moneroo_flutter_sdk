import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

/// A model class representing customer information for Moneroo payments.
///
/// This class encapsulates all customer details required for processing
/// payments through Moneroo. At minimum, email, first name, and last name
/// are required, while other fields like phone, address, etc. are optional.
///
/// The class provides JSON serialization/deserialization support for
/// API communication.
@JsonSerializable()
class MonerooCustomer {
  /// Creates a new customer information object.
  ///
  /// [email], [firstName], and [lastName] are required parameters.
  /// Other fields are optional and can be provided if available.
  ///
  /// Example:
  /// ```dart
  /// final customer = MonerooCustomer(
  ///   email: 'customer@example.com',
  ///   firstName: 'John',
  ///   lastName: 'Doe',
  ///   phone: '+1234567890',
  ///   country: 'US',
  /// );
  /// ```
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

  /// Creates a [MonerooCustomer] instance from a JSON map.
  ///
  /// This factory constructor is used to deserialize customer data
  /// received from the Moneroo API.
  factory MonerooCustomer.fromJson(Map<String, dynamic> json) =>
      _$MonerooCustomerFromJson(json);

  /// The customer's email address.
  ///
  /// This is a required field and is used for communication and
  /// identification purposes.
  final String email;

  /// The customer's first name.
  ///
  /// This is a required field for identifying the customer.
  @JsonKey(name: 'first_name')
  final String firstName;

  /// The customer's last name.
  ///
  /// This is a required field for identifying the customer.
  @JsonKey(name: 'last_name')
  final String lastName;

  /// The customer's phone number.
  ///
  /// This is an optional field but recommended for verification
  /// and communication purposes. Include country code if available.
  @JsonKey(includeIfNull: false)
  final String? phone;

  /// The customer's street address.
  ///
  /// This is an optional field but may be required for certain
  /// payment methods or for verification purposes.
  @JsonKey(includeIfNull: false)
  final String? address;

  /// The customer's city.
  ///
  /// This is an optional field but may be useful for address verification.
  @JsonKey(includeIfNull: false)
  final String? city;

  /// The customer's state or province.
  ///
  /// This is an optional field but may be useful for address verification.
  @JsonKey(includeIfNull: false)
  final String? state;

  /// The customer's country.
  ///
  /// This is an optional field but recommended for international payments.
  /// Preferably use ISO country codes (e.g., 'US', 'GB', 'NG').
  @JsonKey(includeIfNull: false)
  final String? country;

  /// The customer's postal or ZIP code.
  ///
  /// This is an optional field but may be required for certain
  /// payment methods or for address verification.
  @JsonKey(includeIfNull: false)
  final String? zip;

  /// Converts this customer object to a JSON map.
  ///
  /// This method is used to serialize the customer data for API requests.
  /// Optional fields that are null will not be included in the JSON output.
  Map<String, dynamic> toJson() => _$MonerooCustomerToJson(this);
}
