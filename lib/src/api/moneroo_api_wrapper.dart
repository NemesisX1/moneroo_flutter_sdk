import 'dart:io';
import 'package:dio/dio.dart';
import 'package:moneroo_flutter_sdk/src/api/endpoints.dart';
import 'package:moneroo_flutter_sdk/src/commons/enums.dart';
import 'package:moneroo_flutter_sdk/src/commons/exceptions.dart';
import 'package:moneroo_flutter_sdk/src/models/api_response.dart';
import 'package:moneroo_flutter_sdk/src/models/customer.dart';
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
    MonerooCurency currency = MonerooCurency.XOF,
    String? description,
    String? callbackUrl,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '/${apiVersion.name}${Endpoints.payments}${Endpoints.init}',
        data: {
          'amount': amount,
          'currency': currency.name,
          'description': description ?? 'From Moneroo Flutter package',
          'customer': customer.toJson(),
          'return_url': callbackUrl ?? 'https://example.com',
        },
      );

      final apiResponse = ApiResponse.fromJson(res.data!);

      return MonerooPayment.fromJson(apiResponse.data);
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
  Future<PaymentInfos> getPaymentInfos({
    required String paymentId,
  }) async {
    try {
      // ignore: inference_failure_on_function_invocation
      final res = await _dio.get<Map<String, dynamic>>(
        '/${apiVersion.name}${Endpoints.payments}/$paymentId${Endpoints.verify}',
      );

      final apiResponse = ApiResponse.fromJson(res.data!);

      return PaymentInfos.fromJson(apiResponse.data);
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

  ///
  // void handleException(DioException e) {
  //   if (e.response?.statusCode == 422) {
  //     throw InvalidPayloadException(
  //       errors: (e.response?.data as Map<String, dynamic>)['errors'],
  //       message:
  //           (e.response?.data as Map<String, dynamic>)['message'] as String,
  //     );
  //   }

  //   if (e.response?.statusCode == 401) {
  //     throw UnauthorizedException(
  //       errors: (e.response?.data as Map<String, dynamic>)['errors'],
  //       message:
  //           (e.response?.data as Map<String, dynamic>)['message'] as String,
  //     );
  //   }

  // }
}
