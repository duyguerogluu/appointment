import 'package:goresy/data/network/constants/endpoints.dart';
import 'package:goresy/data/network/dio_client.dart';
import 'package:goresy/models/partner.dart';

class PartnersApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  PartnersApi(this._dioClient);

  Future<List<Partner>> partners() async {
    final baseRes = await _dioClient.get(
      "${Endpoints.partners}?sort=vatRate,desc&sort=voteCount,desc",
    );
    return (baseRes.data as List<dynamic>)
        .map((e) => Partner.fromJson(e))
        .toList();
  }

  Future<Partner> partner(String pid) async {
    final baseRes = await _dioClient.get(
      Endpoints.partner.replaceAll("{pid}", pid),
    );
    return Partner.fromJson(baseRes.data);
  }
}
