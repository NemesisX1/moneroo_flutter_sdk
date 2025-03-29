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

/// An API wrapper for the Moneroo API
class MonerooApi {
  ///
  MonerooApi({
    required this.apiKey,
    this.sandbox = false,
  });

  /// Your app's API key
  final String apiKey;

  ///
  final bool sandbox;

  ///
  final apiVersion = MonerooVersion.v1;

  late final _dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $apiKey',
      },
    ),
  );

  /// Initialize a payment on Moneroo. The main goal of this function is to
  /// give you the checkout URL that will be used as a payment URL. The payment
  /// URL is responsible of the payment interface.
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

  /// Allow you to retrieve data about a payment given its paymentID. Can be
  /// helpful to get the current status of a payment.
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

  /// Retrive all the available methods on Moneroo
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
