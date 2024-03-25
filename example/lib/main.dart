import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moneroo_flutter_sdk/moneroo_flutter_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moneroo Flutter SDK Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Pay me nowwww'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Moneroo(
                  amount: 1,
                  apiKey: 'YOUR_API_KEY',
                  currency: MonerooCurency.XOF,
                  customer: MonerooCustomer(
                    email: 'email@gmail.com',
                    firstName: 'firstname',
                    lastName: 'lastname',
                  ),
                  description: 'This is a description',
                  onPaymentCompleted: (infos, context) {
                    if (infos.status == MonerooStatus.success) {
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'We were not able to perform the payment correctly !',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  onError: (error, context) {
                    log(error.toJson().toString());

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'An error occured !',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
