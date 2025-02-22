/// Base class to handle API response
class MonerooApiResponse {
  ///
  MonerooApiResponse({
    //  required this.success,
    required this.message,
    required this.data,
  });

  ///
  MonerooApiResponse.fromJson(Map<String, dynamic> json) {
    // success = json['success'] as bool;
    message = json['message'] as String?;
    data = json['data'] as dynamic;
    errors = json['errors'] as Map<String, dynamic>?;
    pagination = json['pagination'] as Map<String, dynamic>?;
  }

  ///
  late String? message;

  ///
  late dynamic data;

  ///
  late Map<String, dynamic>? errors;

  ///
  late Map<String, dynamic>? pagination;

  ///
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = data;
    data['pagination'] = pagination;
    data['errors'] = errors;

    return data;
  }
}
