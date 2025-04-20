// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moneroo_flutter_sdk/src/api/moneroo_api_wrapper.dart';
import 'package:moneroo_flutter_sdk/src/commons/enums.dart';
import 'package:moneroo_flutter_sdk/src/commons/exceptions.dart';
import 'package:moneroo_flutter_sdk/src/models/customer.dart';
import 'package:moneroo_flutter_sdk/src/models/payment_infos.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

/// A Flutter widget that provides a complete payment flow using Moneroo services.
///
/// This widget handles the entire payment process, including:
/// 1. Initializing a payment transaction with Moneroo
/// 2. Displaying a WebView with Moneroo's payment interface
/// 3. Monitoring the payment status
/// 4. Providing callbacks for payment completion or errors
///
/// The widget automatically manages the payment flow and redirects the user
/// back to your app when the payment is completed (whether successful or not).
///
/// Usage example:
/// ```dart
/// Moneroo(
///   apiKey: 'your_api_key',
///   amount: 5000,
///   currency: MonerooCurrency.XOF,
///   customer: MonerooCustomer(
///     email: 'customer@example.com',
///     firstName: 'John',
///     lastName: 'Doe',
///   ),
///   description: 'Premium subscription',
///   onPaymentCompleted: (infos, context) {
///     if (infos.status == MonerooStatus.success) {
///       // Handle successful payment
///     } else {
///       // Handle failed or cancelled payment
///     }
///   },
///   onError: (error, context) {
///     // Handle error
///   },
/// )
/// ```
class Moneroo extends StatefulWidget {
  /// Creates a Moneroo payment widget.
  ///
  /// Most parameters are required to initialize the payment process.
  const Moneroo({
    required this.amount,
    required this.apiKey,
    required this.currency,
    required this.customer,
    required this.description,
    required this.onPaymentCompleted,
    required this.onError,
    super.key,
    this.displayDebugLog = false,
    this.sandbox = false,
    this.callbackUrl,
    this.metadata,
    this.methods,
  });

  /// Your Moneroo API key used for authentication with the Moneroo API.
  ///
  /// This key is required to initialize payments and verify their status.
  final String apiKey;

  /// Determines whether to use the sandbox (testing) environment.
  ///
  /// Set to `true` for development and testing, and `false` for production.
  /// The default value is `false`.
  final bool sandbox;

  /// Enables debug logging for the payment process.
  ///
  /// When set to `true`, the widget will print detailed logs about WebView
  /// navigation, page loading progress, and errors to the console.
  /// Useful for troubleshooting but should be disabled in production.
  final bool displayDebugLog;

  /// The payment amount in the smallest currency unit (e.g., cents).
  ///
  /// For example, to charge 50 USD, set this to 5000 (50 dollars in cents).
  final int amount;

  /// The currency to use for the payment.
  ///
  /// Must be one of the supported currencies defined in [MonerooCurrency].
  /// Different currencies support different payment methods.
  final MonerooCurrency currency;

  /// Customer information for the payment.
  ///
  /// This must include at minimum the customer's email, first name, and last name.
  /// Additional fields like phone, address, etc. can be provided if available.
  final MonerooCustomer customer;

  /// A description of what the payment is for.
  ///
  /// This will be displayed to the customer during the payment process and
  /// included in payment records.
  final String description;

  /// The URL where the user will be redirected after completing the payment process.
  ///
  /// This URL is used to detect when the payment flow is complete. The widget
  /// monitors navigation to this URL to determine when to call [onPaymentCompleted].
  ///
  /// If not provided, defaults to 'https://example.com'.
  final String? callbackUrl;

  /// Additional data to store with the payment on Moneroo's servers.
  ///
  /// This can be any custom data you want to associate with the payment,
  /// such as order IDs, product information, or user details.
  /// The data will be returned when querying payment information.
  final Map<String, dynamic>? metadata;

  /// Specific payment methods to enable for this transaction.
  ///
  /// If provided, only these payment methods will be available to the customer.
  /// If not provided, all payment methods supported for the selected currency
  /// will be available.
  ///
  /// See [MonerooMethod] for available payment methods.
  final List<MonerooMethod>? methods;

  /// A callback function called when the payment process is completed.
  ///
  /// This is called regardless of whether the payment succeeded, failed, or was cancelled.
  /// The [MonerooPaymentInfos] parameter contains details about the payment status
  /// and other relevant information.
  ///
  /// You should check `infos.status` to determine the payment outcome:
  /// - [MonerooStatus.success]: Payment was successful
  /// - [MonerooStatus.failed]: Payment failed
  /// - [MonerooStatus.cancelled]: Payment was cancelled by the user
  /// - [MonerooStatus.pending]: Payment is still being processed
  /// - [MonerooStatus.initiated]: Payment was just initiated
  final void Function(MonerooPaymentInfos infos, BuildContext context)
      onPaymentCompleted;

  /// A callback function to handle errors that occur during the payment process.
  ///
  /// This is called when there's an error initializing the payment, loading the
  /// payment interface, or processing the payment. The error parameter contains
  /// details about what went wrong.
  ///
  /// Common errors include:
  /// - [MonerooException]: API errors from Moneroo
  /// - [WebResourceError]: Errors loading the payment interface
  /// - [ServiceUnavailableException]: Moneroo service is unavailable
  final void Function(dynamic error, BuildContext context) onError;

  @override
  // ignore: library_private_types_in_public_api
  _MonerooState createState() => _MonerooState();
}

class _MonerooState extends State<Moneroo> {
  late final WebViewController _controller;
  String? _checkoutUrl;
  String? _paymentId;
  late final MonerooApi _api;

  bool hadGetCheckoutUrl = false;

  @override
  void initState() {
    super.initState();

    /// Init webview
    late final PlatformWebViewControllerCreationParams params;

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final controller = WebViewController.fromPlatformCreationParams(params);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));

    /// Run payment
    _api = MonerooApi(
      apiKey: widget.apiKey,
      sandbox: widget.sandbox,
    );

    initMonerooStandardPayment(context);
  }

  Future<void> initMonerooStandardPayment(BuildContext context) async {
    try {
      final res = await _api.initPayment(
        amount: widget.amount,
        customer: widget.customer,
        currency: widget.currency,
        description: widget.description,
        callbackUrl: widget.callbackUrl,
        metadata: widget.metadata,
        methods: widget.methods,
      );

      setState(() {
        _checkoutUrl = res.checkoutUrl;
        _paymentId = res.id;
      });
    } on MonerooException catch (e) {
      if (!context.mounted) return;

      widget.onError(e, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (value, _) async {
        if (_paymentId != null) {
          await handlePaymentCallback(context);
        }
      },
      child: Scaffold(
        body: _checkoutUrl == null
            ? const Center(
                child: SpinKitRing(
                  color: Color(0xff3b82f6),
                ),
              )
            : Builder(
                builder: (context) {
                  _controller
                    ..setUserAgent(
                      'Moneroo Flutter SDK',
                    )
                    ..loadRequest(Uri.parse(_checkoutUrl!))
                    ..setNavigationDelegate(
                      NavigationDelegate(
                        onProgress: (int progress) {
                          if (widget.displayDebugLog) {
                            debugPrint(
                              'WebView is loading (progress : $progress%)',
                            );
                          }
                        },
                        onPageStarted: (String url) {
                          if (widget.displayDebugLog) {
                            debugPrint('Page started loading: $url');
                          }
                        },
                        onPageFinished: (String url) {
                          if (widget.displayDebugLog) {
                            debugPrint('Page finished loading: $url');
                          }
                        },
                        onWebResourceError: (WebResourceError error) {
                          if (widget.displayDebugLog) {
                            debugPrint('''
              Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
              ''');
                          }

                          widget.onError(error, context);
                        },
                        onUrlChange: (UrlChange change) {
                          if (!change.url!.contains('moneroo')) {
                            handlePaymentCallback(context);
                          }
                        },
                      ),
                    );

                  return WebViewWidget(
                    controller: _controller,
                  );
                },
              ),
      ),
    );
  }

  Future<void> handlePaymentCallback(BuildContext context) async {
    try {
      final paymentInfos = await _api.getMonerooPaymentInfos(
        paymentId: _paymentId!,
      );

      if (!context.mounted) return;

      widget.onPaymentCompleted(paymentInfos, context);
    } on MonerooException catch (e) {
      widget.onError(e, context);
    }
  }
}
