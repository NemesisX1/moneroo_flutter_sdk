<div align="center">
<a href="https://moneroo.io" title="Moneroo - Payment stack for Africa">
    <img src="https://raw.githubusercontent.com/NemesisX1/moneroo_flutter_sdk/main/art/cover.png" alt="Moneroo website">
</a>

# Moneroo Flutter SDK

<!-- Nav header - Start -->

<a href="https://join.slack.com/t/ballerine-oss/shared_invite/zt-1iu6otkok-OqBF3TrcpUmFd9oUjNs2iw">Slack</a>
·
<a href="https://www.moneroo.io/">Website</a>
·
<a href="https://www.moneroo.io/contact">Contact</a>
·
<a href="https://docs.moneroo.io/">Documentation</a>

<!-- Nav header - END -->

<!-- Badges - Start -->

<!-- Badges - END -->

</div>

## Requirements

**❗ In order to start using Moneroo Flutter you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

## Installation

Install via `flutter pub add`:

```sh
flutter pub add moneroo_flutter_sdk
```

---

### Configuration

#### Android

Add this line in your `AndroidManifest.xml`. This will help you to avoid an ERR_CLEAR_TEXT_NOT_PERMITTED error while processing a payment.

**Don't forget to allow internet access in your Android app ! Info [here](https://developer.android.com/develop/connectivity/network-ops/connecting) !**

```xml
<application
        ...
        android:usesCleartextTraffic="true"
        ...
        >
        ...
</application>
```

#### IOS

Add this line in your `Info.plist`. This will help you to avoid an ERR_CLEAR_TEXT_NOT_PERMITTED error while processing a payment.

```xml
<plist>
...
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
         <true/>
     </dict>
...
<plist>
```

## Documentation

You can a have a full example [here](example/lib/main.dart). You can also your the `MonerooApi` class to implement the payment yourself without using the Moneroo widget provided by this package.

## Example Usage

Here's a simple example of how to integrate the Moneroo payment widget in your Flutter app:

```dart
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
      title: 'Moneroo Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Pay Now'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Moneroo(
                  amount: 1, // Amount to charge
                  apiKey: 'YOUR_API_KEY', // Your Moneroo API key
                  currency: MonerooCurrency.XOF, // Currency code
                  customer: MonerooCustomer(
                    email: 'customer@example.com',
                    firstName: 'John',
                    lastName: 'Doe',
                  ),
                  description: 'Payment description',
                  onPaymentCompleted: (infos, context) {
                    if (infos.status == MonerooStatus.success) {
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Payment failed'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  onError: (error, context) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('An error occurred'),
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
```

### Key Components

1. **Moneroo Widget**: The main widget that handles the payment flow
2. **MonerooCustomer**: Customer information required for the payment
3. **MonerooCurrency**: Supported currency codes (e.g., XOF)
4. **MonerooStatus**: Payment status enumeration

### Required Parameters

- `amount`: The amount to charge
- `apiKey`: Your Moneroo API key
- `currency`: The currency code
- `customer`: Customer information
- `description`: Payment description
- `onPaymentCompleted`: Callback for payment completion
- `onError`: Callback for error handling

## Development

### DEV Mode

## Notes

### Exception Handling 🐛

- **MonerooException**: This exception is throw when an error occured in during the API calling. You can have more infos about the related error logging the class's attribute.
- **ServiceUnavailableException**: This exception is throw when the SDK was'nt able to send your request to the server. Maybe due to network issues.

## Security Vulnerabilities


If you discover a security vulnerability within Moneroo Flutter SDK, please send an e-mail to Moneroo Security via [hello@moneroo.io](mailto:security@moneroo.io). All security vulnerabilities will be promptly addressed.

## License

The Moneroo Flutter SDK is open-sourced software licensed under the [MIT license](LICENSE.md).
