// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:moneroo_flutter_sdk/moneroo_flutter_sdk.dart';
import 'package:moneroo_flutter_sdk/src/models/methods.dart';

void main() {
  final api = MonerooApi(
    apiKey: 'YOUR-API-KEY',
  );

  group('MonerooApi', () {
    late String paymentId;

    setUpAll(() {
      paymentId = '';
    });

    test('can get all payment methods', () async {
      final paymentMethods = await api.getMonerooPaymentMethods();

      expect(paymentMethods, isNotEmpty);
      expect(paymentMethods[0], isA<MonerooRemoteMethod>());
    });

    test('can initialize payment with minimum required fields', () async {
      final payment = await api.initPayment(
        amount: 100,
        customer: MonerooCustomer(
          email: 'test@example.com',
          firstName: 'Test',
          lastName: 'User',
        ),
      );

      expect(payment, isNotNull);
      expect(payment.id, isNotEmpty);
      paymentId = payment.id;
    });

    test('can initialize payment with metadata', () async {
      final payment = await api.initPayment(
        amount: 200,
        customer: MonerooCustomer(
          email: 'test@example.com',
          firstName: 'Test',
          lastName: 'User',
        ),
        metadata: {
          'order_id': '1234567890',
          'customer_id': 'cust_123',
        },
      );

      expect(payment, isNotNull);
      expect(payment.id, isNotEmpty);
    });

    test('can verify transaction status', () async {
      if (paymentId.isEmpty) {
        fail('Payment ID is empty. Please run initialization test first.');
      }

      final paymentInfos = await api.getMonerooPaymentInfos(
        paymentId: paymentId,
      );

      expect(paymentInfos, isNotNull);
      expect(paymentInfos.status, isA<MonerooStatus>());
    });

    test('can handle invalid API key', () async {
      final invalidApi = MonerooApi(
        apiKey: 'INVALID-API-KEY',
      );

      expect(
        () => invalidApi.initPayment(
          amount: 100,
          customer: MonerooCustomer(
            email: 'test@example.com',
            firstName: 'Test',
            lastName: 'User',
          ),
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('can handle invalid amount', () async {
      expect(
        () => api.initPayment(
          amount: -100, // Negative amount
          customer: MonerooCustomer(
            email: 'test@example.com',
            firstName: 'Test',
            lastName: 'User',
          ),
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('can handle invalid customer information', () async {
      expect(
        () => api.initPayment(
          amount: 100,
          customer: MonerooCustomer(
            email: 'invalid-email', // Invalid email format
            firstName: 'Test',
            lastName: 'User',
          ),
        ),
        throwsA(isA<Exception>()),
      );

      expect(
        () => api.initPayment(
          amount: 100,
          customer: MonerooCustomer(
            email: 'test@example.com',
            firstName: '', // Empty first name
            lastName: 'User',
          ),
        ),
        throwsA(isA<Exception>()),
      );

      expect(
        () => api.initPayment(
          amount: 100,
          customer: MonerooCustomer(
            email: 'test@example.com',
            firstName: 'Test',
            lastName: '', // Empty last name
          ),
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('can handle missing metadata', () async {
      final payment = await api.initPayment(
        amount: 100,
        customer: MonerooCustomer(
          email: 'test@example.com',
          firstName: 'Test',
          lastName: 'User',
        ),
      );

      expect(payment, isNotNull);
      expect(payment.id, isNotEmpty);
    });

    test('can handle empty metadata', () async {
      final payment = await api.initPayment(
        amount: 100,
        customer: MonerooCustomer(
          email: 'test@example.com',
          firstName: 'Test',
          lastName: 'User',
        ),
        metadata: {},
      );

      expect(payment, isNotNull);
      expect(payment.id, isNotEmpty);
    });
  });
}
