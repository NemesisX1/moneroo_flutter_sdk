// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:moneroo_flutter_sdk/moneroo_flutter_sdk.dart';

void main() {
  final api = MonerooApi(
    apiKey: 'pvk_za37ys|01JMPE1VE9WCY3J0ZFNFX47C2T',
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
        metadata: {
          'key': 'order_id',
          'value': '1234567890',
        },
      );

      paymentId = payment.id;

      expect(
        payment,
        isNotNull,
      );
    });

    test('can verify a transaction', () async {
      final paymentInfos = await api.getMonerooPaymentInfos(
        paymentId: paymentId,
      );

      expect(
        paymentInfos,
        isNotNull,
      );
    });
  });
}
