// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserFriendlyException implements Exception {
  String? header;
  String message;
  int? statusCode;

  UserFriendlyException(this.message, {this.header, this.statusCode});

  @override
  String toString() =>
      'UserFriendlyException(statusCode: $statusCode, header: $header, message: $message)';
}
