import 'dart:io';
import 'package:dio/dio.dart';
import 'package:moneroo_flutter_sdk/src/api/endpoints.dart';
import 'package:moneroo_flutter_sdk/src/commons/enums.dart';
import 'package:moneroo_flutter_sdk/src/commons/exceptions.dart';
import 'package:moneroo_flutter_sdk/src/models/api_response.dart';
import 'package:moneroo_flutter_sdk/src/models/customer.dart';
import 'package:moneroo_flutter_sdk/src/models/methods.dart';
import 'package:moneroo_flutter_sdk/src/models/payment.dart';
import 'package:moneroo_flutter_sdk/src/models/payment_infos.dart';

/// An API wrapper for the Moneroo payment processing API.
///
/// This class provides methods to interact with Moneroo's payment services,
/// including initializing payments, retrieving payment information, and
/// fetching available payment methods.
///
/// Usage:
/// ```dart
/// final api = MonerooApi(
///   apiKey: 'your_api_key',
///   sandbox: false, // Set to true for testing
/// );
/// ```
class MonerooApi {
  /// Creates a new instance of the Moneroo API wrapper.
  ///
  /// [apiKey] is your Moneroo API key required for authentication.
  /// [sandbox] determines whether to use the sandbox (testing) environment.
  MonerooApi({
    required this.apiKey,
    this.sandbox = false,
  });

  /// Your Moneroo API key used for authentication with the Moneroo API.
  final String apiKey;

  /// Whether to use the sandbox (testing) environment.
  ///
  /// Set to `true` for development and testing, and `false` for production.
  /// More about it here: https://docs.moneroo.io/payments/testing#using-the-sandbox-environment
  final bool sandbox;

  /// The API version to use for requests.
  ///
  /// Currently only supports `MonerooVersion.v1`.
  final apiVersion = MonerooVersion.v1;

  late final _dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $apiKey',
      },
    ),
  );

  /// Initializes a payment on Moneroo.
  ///
  /// This method creates a new payment transaction and returns a [MonerooPayment]
  /// object containing the checkout URL and payment ID. The checkout URL can be
  /// used to redirect users to the Moneroo payment interface.
  ///
  /// Parameters:
  /// - [amount]: The payment amount in the smallest currency unit (e.g., cents)
  /// - [customer]: Customer information (name, email, etc.)
  /// - [currency]: The currency for the payment (default: XOF)
  /// - [description]: A description of what the payment is for
  /// - [callbackUrl]: URL where the user will be redirected after payment
  /// - [metadata]: Additional data to store with the payment
  /// - [methods]: Specific payment methods to enable for this transaction
  ///
  /// Throws [MonerooException] if the request fails or if amount is negative.
  ///
  /// Example:
  /// ```dart
  /// final payment = await api.initPayment(
  ///   amount: 5000,
  ///   customer: MonerooCustomer(
  ///     email: 'customer@example.com',
  ///     firstName: 'John',
  ///     lastName: 'Doe',
  ///   ),
  ///   description: 'Premium subscription',
  /// );
  ///
  /// // Use the checkout URL
  /// final checkoutUrl = payment.checkoutUrl;
  /// ```
  Future<MonerooPayment> initPayment({
    required int amount,
    required MonerooCustomer customer,
    MonerooCurrency currency = MonerooCurrency.XOF,
    String? description,
    String? callbackUrl,
    Map<String, dynamic>? metadata,

    /// For custom methods
    List<MonerooMethod>? methods,
  }) async {
    if (amount < 0) {
      throw MonerooException(
        code: -1,
        message: 'Amount must be a positive integer',
      );
    }

    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '/${apiVersion.name}${Endpoints.payments}${Endpoints.init}',
        data: {
          'amount': amount,
          'currency': currency.name,
          'description': description ?? 'From Moneroo Flutter package',
          'customer': customer.toJson(),
          'return_url': callbackUrl ?? 'https://example.com',
          'metadata': metadata,
          'methods': methods?.map<String>((method) => method.name).toList(),
        },
      );

      final apiResponse = MonerooApiResponse.fromJson(res.data!);

      return MonerooPayment.fromJson(
        apiResponse.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      if (e.response == null) throw ServiceUnavailableException();

      final error = MonerooException(
        code: e.response!.statusCode,
        errors: (e.response?.data as Map<String, dynamic>)['errors'],
        message:
            (e.response?.data as Map<String, dynamic>)['message'] as String,
      );

      throw error;
    }
  }

  /// Retrieves detailed information about a payment by its ID.
  ///
  /// This method fetches the current state of a payment, including its status
  /// (initiated, pending, success, failed, or cancelled), amount, currency,
  /// and other relevant details.
  ///
  /// Parameters:
  /// - [paymentId]: The unique identifier of the payment to retrieve
  ///
  /// Returns a [MonerooPaymentInfos] object containing payment details.
  ///
  /// Throws [MonerooException] if the request fails or the payment is not found.
  /// Throws [ServiceUnavailableException] if the Moneroo service is unavailable.
  ///
  /// Example:
  /// ```dart
  /// final paymentInfo = await api.getMonerooPaymentInfos(
  ///   paymentId: 'payment_123456789',
  /// );
  ///
  /// if (paymentInfo.status == MonerooStatus.success) {
  ///   // Payment was successful
  /// }
  /// ```
  Future<MonerooPaymentInfos> getMonerooPaymentInfos({
    required String paymentId,
  }) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '/${apiVersion.name}${Endpoints.payments}/$paymentId${Endpoints.verify}',
      );

      final apiResponse = MonerooApiResponse.fromJson(res.data!);

      return MonerooPaymentInfos.fromJson(
        apiResponse.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      if (e.response == null) throw ServiceUnavailableException();

      final error = MonerooException(
        code: e.response!.statusCode,
        errors: (e.response?.data as Map<String, dynamic>)['errors'],
        message:
            (e.response?.data as Map<String, dynamic>)['message'] as String,
      );

      throw error;
    }
  }

  /// Retrieves all available payment methods supported by Moneroo.
  ///
  /// This method returns a list of payment methods that can be used with
  /// Moneroo, including their names, descriptions, and other properties.
  ///
  /// Returns a list of [MonerooRemoteMethod] objects representing available
  /// payment methods.
  ///
  /// Throws [MonerooException] if the request fails.
  /// Throws [ServiceUnavailableException] if the Moneroo service is unavailable.
  ///
  /// Example:
  /// ```dart
  /// final methods = await api.getMonerooPaymentMethods();
  ///
  /// // Display available payment methods to the user
  /// for (final method in methods) {
  ///   print('${method.name}: ${method.description}');
  /// }
  /// ```
  Future<List<MonerooRemoteMethod>> getMonerooPaymentMethods() async {
    final methods = <MonerooRemoteMethod>[];

    try {
      final res = await _dio.get<Map<String, dynamic>>(
        Endpoints.methods,
      );

      final apiResponse = MonerooApiResponse.fromJson(res.data!);

      for (final data in apiResponse.data as List<dynamic>) {
        methods.add(
          MonerooRemoteMethod.fromJson(
            data as Map<String, dynamic>,
          ),
        );
      }

      return methods;
    } on DioException catch (e) {
      if (e.response == null) throw ServiceUnavailableException();

      final error = MonerooException(
        code: e.response!.statusCode,
        errors: (e.response?.data as Map<String, dynamic>)['errors'],
        message:
            (e.response?.data as Map<String, dynamic>)['message'] as String,
      );

      throw error;
    }
  }
}
