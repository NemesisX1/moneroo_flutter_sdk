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

## Overview

Moneroo Flutter SDK provides a simple and reliable way to integrate payment processing into your Flutter applications, with support for various payment methods across multiple African countries. The SDK offers both a ready-to-use payment widget and a flexible API wrapper for custom implementations.

### Features

- 🌍 **Multi-currency support** - Process payments in XOF, XAF, NGN, GHS, and many other African currencies
- 🔌 **Multiple payment methods** - Support for mobile money, bank transfers, cards, and more
- 🛡️ **Secure transactions** - PCI-compliant payment processing
- 📱 **Ready-to-use UI** - Pre-built payment widget for quick integration
- 🔧 **Flexible API** - Direct API access for custom implementations
- 🧪 **Sandbox mode** - Test your integration without real transactions

## Requirements

**❗ In order to start using Moneroo Flutter you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

- Flutter SDK 2.5.0 or higher
- Dart 2.14.0 or higher
- A Moneroo account and API key (get yours at [moneroo.io](https://moneroo.io))

## Installation

### Via Flutter CLI

Install via `flutter pub add`:

```sh
flutter pub add moneroo_flutter_sdk
```

### Via pubspec.yaml

Alternatively, add the dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  moneroo_flutter_sdk: ^0.3.4  # Use the latest version
```

Then run:

```sh
flutter pub get
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

This README provides basic usage information. For more detailed documentation:

- **Example App**: Check out the complete example [here](example/lib/main.dart)
- **API Reference**: Comprehensive API documentation is available in the code
- **Official Docs**: Visit [docs.moneroo.io](https://docs.moneroo.io/) for the official Moneroo documentation

The SDK offers two main ways to integrate payments:

1. **Using the Moneroo Widget** - A pre-built UI component that handles the entire payment flow
2. **Using the MonerooApi class** - Direct API access for custom implementations

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

## Using the API Wrapper Directly

While the Moneroo widget provides a complete payment flow with UI, you can also use the `MonerooApi` class directly for more customized payment processing. This is useful when you want to implement your own UI or integrate Moneroo payments into an existing flow.

### Initializing the API

```dart
final api = MonerooApi(
  apiKey: 'YOUR_API_KEY',
  sandbox: false, // Set to true for testing
);
```

### Creating a Payment

```dart
final payment = await api.initPayment(
  amount: 5000, // Amount in smallest currency unit (e.g., cents)
  customer: MonerooCustomer(
    email: 'customer@example.com',
    firstName: 'John',
    lastName: 'Doe',
    phone: '+1234567890', // Optional
    country: 'US', // Optional
  ),
  currency: MonerooCurrency.XOF,
  description: 'Premium subscription',
  callbackUrl: 'https://your-app.com/payment-callback', // Optional
  metadata: { 'orderId': '12345' }, // Optional
);

// The checkout URL can be used in a WebView or browser
final checkoutUrl = payment.checkoutUrl;
// Store the payment ID for later verification
final paymentId = payment.id;
```

### Checking Payment Status

```dart
final paymentInfo = await api.getMonerooPaymentInfos(
  paymentId: 'payment_123456789',
);

switch (paymentInfo.status) {
  case MonerooStatus.success:
    print('Payment was successful!');
    // Handle successful payment
    break;
  case MonerooStatus.pending:
    print('Payment is still being processed...');
    // Maybe show a waiting screen
    break;
  case MonerooStatus.failed:
    print('Payment failed.');
    // Handle failed payment
    break;
  case MonerooStatus.cancelled:
    print('Payment was cancelled.');
    // Handle cancelled payment
    break;
  case MonerooStatus.initiated:
    print('Payment has been initiated but not yet processed.');
    // Maybe redirect to payment page
    break;
}
```

### Getting Available Payment Methods

```dart
final methods = await api.getMonerooPaymentMethods();

// Display available payment methods to the user
for (final method in methods) {
  print('${method.name}: ${method.description}');
}
```

### Error Handling

```dart
try {
  final payment = await api.initPayment(
    amount: 5000,
    customer: customer,
    currency: MonerooCurrency.XOF,
    description: 'Premium subscription',
  );
  // Process payment
} on MonerooException catch (e) {
  // Handle Moneroo API errors
  print('Error code: ${e.code}');
  print('Error message: ${e.message}');
  if (e.errors != null) {
    print('Detailed errors: ${e.errors}');
  }
} on ServiceUnavailableException {
  // Handle service unavailable errors (e.g., network issues)
  print('Service is currently unavailable. Please try again later.');
} catch (e) {
  // Handle other errors
  print('An unexpected error occurred: $e');
}
```

## Development

## Development Mode

### Sandbox Testing

Moneroo provides a sandbox environment for testing your integration without making real transactions. To use the sandbox mode:

```dart
// When using the widget
Moneroo(
  apiKey: 'YOUR_API_KEY',
  sandbox: true,  // Enable sandbox mode
  // other parameters...
);

// When using the API directly
final api = MonerooApi(
  apiKey: 'YOUR_API_KEY',
  sandbox: true,  // Enable sandbox mode
);
```

In sandbox mode, you can use test cards and payment methods to simulate different payment scenarios. For more information on testing, visit the [Moneroo Testing Documentation](https://docs.moneroo.io/payments/testing).

## Handling Errors

### Exception Types 🐛

The SDK throws the following exceptions that you should handle in your code:

- **MonerooException**: Thrown when an error occurs during API communication. Contains:
  - `code`: HTTP status code or custom error code
  - `message`: Human-readable error message
  - `errors`: Detailed error information (if available)

- **ServiceUnavailableException**: Thrown when the SDK cannot reach the Moneroo servers, typically due to network issues.

### Best Practices for Error Handling

```dart
try {
  // Moneroo API call
} on MonerooException catch (e) {
  // Log the error details
  print('Moneroo Error: ${e.message} (Code: ${e.code})');
  
  // Show appropriate message to the user
  if (e.code == 401) {
    // Authentication error
  } else if (e.code == 400) {
    // Invalid request
  }
} on ServiceUnavailableException {
  // Handle connectivity issues
  print('Cannot connect to Moneroo. Please check your internet connection.');
} catch (e) {
  // Handle other unexpected errors
  print('Unexpected error: $e');
}
```

## Frequently Asked Questions

### Is the SDK compatible with Flutter Web?

Currently, the SDK is optimized for mobile platforms (Android and iOS). Flutter Web support is planned for future releases.

### How do I handle payment webhooks?

Moneroo can send webhook notifications to your server when payment status changes. Configure your webhook URL in the Moneroo dashboard and implement an endpoint on your server to process these notifications.

### Can I customize the payment UI?

If you need a custom UI, use the `MonerooApi` class directly instead of the pre-built widget. This gives you full control over the payment flow and UI.

## Contributing

Contributions are welcome! If you'd like to contribute to the Moneroo Flutter SDK:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Security Vulnerabilities

If you discover a security vulnerability within Moneroo Flutter SDK, please send an e-mail to Moneroo Security via [hello@moneroo.io](mailto:security@moneroo.io). All security vulnerabilities will be promptly addressed.

## Support

For support, questions, or feedback:

- 📧 Email: [support@moneroo.io](mailto:support@moneroo.io)
- 📝 Issues: [GitHub Issues](https://github.com/MonerooHQ/moneroo_flutter/issues)
- 📚 Documentation: [docs.moneroo.io](https://docs.moneroo.io)

## License

The Moneroo Flutter SDK is open-sourced software licensed under the [MIT license](LICENSE.md).

---

<div align="center">
Powered by <a href="https://moneroo.io">Moneroo</a> - The Payment Stack for Africa
</div>
