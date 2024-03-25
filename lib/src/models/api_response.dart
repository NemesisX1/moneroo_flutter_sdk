/// Base class to handle API response
class ApiResponse {
  ///
  ApiResponse({
    //  required this.success,
    required this.message,
    required this.data,
  });

  ///
  ApiResponse.fromJson(Map<String, dynamic> json) {
    // success = json['success'] as bool;
    message = json['message'] as String;
    data = json['data'] as Map<String, dynamic>;
    errors = json['errors'] as Map<String, dynamic>?;
  }

  ///
  late String message;

  ///
  late Map<String, dynamic> data;

  ///
  late Map<String, dynamic>? errors;

  ///
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = data;
    data['errors'] = errors;

    return data;
  }
}
