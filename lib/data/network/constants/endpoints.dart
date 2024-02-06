class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://";
  static const String baseAuthUrl = "https://dev-oauth.";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(seconds: 10);

  // connectTimeout
  static const Duration connectionTimeout = Duration(seconds: 20);

  static const String authorize = "$baseAuthUrl/oauth/token";

  static const String createAppointment = "$baseUrl/appointment";

  static const String partners = "$baseUrl/partners";
  static const String partner = "$baseUrl/partner/{pid}";
}
