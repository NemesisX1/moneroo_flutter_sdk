// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:moneroo_flutter_sdk/moneroo_flutter_sdk.dart';

void main() {
  final api = MonerooApi(
    apiKey: 'YOUR_API_KEY',
  );

  group('MonerooApi', () {
    late String paymentId;

    test('can init payment', () async {
      final payment = await api.initPayment(
        amount: 1,
        customer: MonerooCustomer(
          email: 'junior.medehou00@gmail.com',
          firstName: 'Elikem',
          lastName: 'Medehou',
        ),
      );

      paymentId = payment.id;

      expect(
        payment,
        isNotNull,
      );
    });

    test('can verify a transaction', () async {
      final paymentInfos = await api.getPaymentInfos(
        paymentId: paymentId,
      );

      expect(
        paymentInfos,
        isNotNull,
      );
    });
  });
}
