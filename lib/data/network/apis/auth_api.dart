import 'package:dio/dio.dart';
import 'package:goresy/data/network/apis/models/responses/login_response.dart';
import 'package:goresy/data/network/constants/endpoints.dart';
import 'package:goresy/data/network/dio_client.dart';

class AuthApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  AuthApi(this._dioClient);

  Future<LoginResponse> login(String username, String password) async {
    final baseRes = await _dioClient.post(
      Endpoints.authorize,
      data: "grant_type=password&username=$username&password=$password",
      options: Options(
        headers: <String, dynamic>{
          "Authorization":
              "Basic Z29yZXN5UHJvamVjdENsaWVudDpnb3Jlc3lQcm9qZWN0T2F1dGhTZWNyZXQyMDIyLg==",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      ),
    );
    return LoginResponse.fromJson(baseRes.data);
  }
}
