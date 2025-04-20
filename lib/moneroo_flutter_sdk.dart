/// Moneroo Flutter SDK - A Flutter package for integrating Moneroo payment services.
///
/// This SDK provides a comprehensive set of tools to integrate Moneroo payment
/// processing capabilities into Flutter applications. It includes API wrappers,
/// data models, and ready-to-use widgets to handle payment flows.
///
/// The SDK supports various payment methods across multiple African countries
/// and currencies, making it ideal for applications targeting the African market.
///
/// Main components:
/// - API wrapper: For direct interaction with Moneroo's payment API
/// - Widget: Ready-to-use UI component for payment processing
/// - Models: Data structures for customers, payments, and payment information
/// - Enums: Predefined constants for currencies, payment methods, and statuses
library;

export 'src/api/moneroo_api_wrapper.dart';
export 'src/commons/enums.dart';
export 'src/models/customer.dart';
export 'src/models/payment.dart';
export 'src/models/payment_infos.dart';
export 'src/widgets/moneroo_flutter.dart';
