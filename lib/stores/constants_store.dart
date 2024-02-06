import 'package:goresy/data/network/apis/constants_api.dart';
import 'package:goresy/utils/extensions/future_extensions.dart';
import 'package:goresy/utils/logger.dart';

export 'package:goresy/dependency-injections/components/service_locator.dart';

part 'constants_store.g.dart';

enum ConstantsStoreState {
  INITIALIZING,
  READY,
  FAILED,
}

class ConstantsStore = _ConstantsStore with _$ConstantsStore;

abstract class _ConstantsStore with Store {
  final ConstantsApi _api;

  // disposers
  late List<ReactionDisposer> _disposers;

  // constructor:---------------------------------------------------------------
  _ConstantsStore(ConstantsApi constantsApi) : this._api = constantsApi {
    init();
  }

  init() async {
    try {
      setStoreState(ConstantsStoreState.INITIALIZING);
      var result = await fetchConstants();

      if (result) {
        setStoreState(ConstantsStoreState.READY);
      } else {
        setStoreState(ConstantsStoreState.FAILED);
      }
    } catch (e, stackTrace) {
      Log.e(e, stackTrace: stackTrace);
      setStoreState(ConstantsStoreState.FAILED);
    }
  }

  @action
  dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  @observable
  ConstantsStoreState _storeState = ConstantsStoreState.INITIALIZING;

  @computed
  ConstantsStoreState get storeState => _storeState;

  @action
  setStoreState(ConstantsStoreState val) {
    _storeState = val;
  }

  @observable
  bool _enumsReady = false;

  @action
  _setEnumsReady() {
    _enumsReady = true;
  }

  @action
  Future<bool> fetchConstants() {
    return Future.wait([Future.value(true)]).then((values) {
      bool result = true;
      values.forEach((val) => result = result && val);
      return result;
    });
  }
}
