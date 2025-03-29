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

/// This widget is responsible of performing the full payment part
/// on Moneroo. Fistly, based on the given data, it will retrieve
/// a payment link.This link will be used to display a webview where
/// the user will perform its payments.
class Moneroo extends StatefulWidget {
  ///
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

  /// The Moneroo API key
  final String apiKey;

  /// Defined whether or not Moneroo is in sandbox mode. The Default value
  /// is false
  final bool sandbox;

  /// Allow debug display for log purpose
  final bool displayDebugLog;

  ///. The payment's amount
  final int amount;

  ///. The payment's currency
  final MonerooCurrency currency;

  ///. The payment's customer
  final MonerooCustomer customer;

  ///. The payment's description
  final String description;

  /// The payment's callback URL where the user will be redirected after the
  /// payment. The basic one is https://example.com.
  final String? callbackUrl;

  /// Some metadata that you want to store about the payment on Moneroo
  final Map<String, dynamic>? metadata;

  /// You can specify the payment methods that will be use with the payment link
  final List<MonerooMethod>? methods;

  /// A callback function that is called once the payment is processed wheiter
  /// or not it succeed. You can have infos about that using the infos parameter
  final void Function(MonerooPaymentInfos infos, BuildContext context)
      onPaymentCompleted;

  /// A callback function to handle errors that will occur
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
