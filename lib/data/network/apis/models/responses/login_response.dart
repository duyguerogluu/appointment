import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class LoginResponse {
  String accessToken;
  String tokenType;
  String refreshToken;
  int expiresIn;
  String scope;
  String jti;

  LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.expiresIn,
    required this.scope,
    required this.jti,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> map) {
    return _$LoginResponseFromJson(map);
  }
}
