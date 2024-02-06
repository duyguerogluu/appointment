import 'package:goresy/data/network/apis/partners_api.dart';
import 'package:goresy/models/partner.dart';
import 'package:goresy/utils/extensions/future_extensions.dart';

export 'package:goresy/dependency-injections/components/service_locator.dart';

part 'partner_store.g.dart';

class PartnerStore = _PartnerStore with _$PartnerStore;

abstract class _PartnerStore with Store {
  // repository instance
  final PartnersApi _api;

  // constructor:---------------------------------------------------------------
  _PartnerStore(PartnersApi api) : _api = api {
    _setupDisposers();
  }

  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  @observable
  bool _isLoggedIn = false;

  @computed
  bool get isLoggedIn => _isLoggedIn;

  @computed
  bool get sessionReady => _isLoggedIn;

  // ---- SignIn - SignOut ---------------------
  @observable
  ObservableFuture<List<Partner>>? partnersFuture;

  @action
  Future<List<Partner>> fetchPartners() {
    return partnersFuture = _api.partners().asObservable();
  }

  @action
  Future<Partner> fetchPartner(String pid) {
    return _api.partner(pid);
  }
}
