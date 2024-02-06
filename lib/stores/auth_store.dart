import 'package:goresy/data/network/apis/auth_api.dart';
import 'package:goresy/data/repository.dart';
import 'package:goresy/utils/extensions/future_extensions.dart';
import 'package:goresy/utils/logger.dart';

export 'package:goresy/dependency-injections/components/service_locator.dart';

part 'auth_store.g.dart';

enum AuthStoreState {
  INITIALIZING,
  READY,
  FAILED,
}

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  // repository instance
  final Repository _repository;
  final AuthApi _api;

  // constructor:---------------------------------------------------------------
  _AuthStore(Repository repository, AuthApi api)
      : _repository = repository,
        _api = api {
    // setting up disposers
    _setupDisposers();

    init();
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

  init() async {
    try {
      setStoreState(AuthStoreState.INITIALIZING);

      if (_repository.accessToken != null) {
        _isLoggedIn = true;
      }

      setStoreState(AuthStoreState.READY);
    } catch (e, stackTrace) {
      Log.e(e, stackTrace: stackTrace);
      setStoreState(AuthStoreState.FAILED);
    }
  }

  // store variables:-----------------------------------------------------------
  @observable
  AuthStoreState _storeState = AuthStoreState.INITIALIZING;

  @computed
  AuthStoreState get storeState => _storeState;

  @action
  setStoreState(AuthStoreState val) {
    _storeState = val;
  }

  @observable
  bool _isLoggedIn = false;

  @computed
  bool get isLoggedIn => _isLoggedIn;

  @computed
  bool get sessionReady => _isLoggedIn;

  // ---- SignIn - SignOut ---------------------
  @observable
  ObservableFuture<bool>? signInFuture;

  @action
  Future<bool> onClickSignIn(String username, String password) {
    return signInFuture = _repository
        .login(username, password)
        .then((value) => _isLoggedIn = value)
        .asObservable()
        .delayedOnError(
            (future) => future == signInFuture ? signInFuture = null : null);
  }

  @action
  Future<bool> onClickSignOut() async {
    var success = await _repository.logout();

    if (success) {
      signInFuture = null;
      _isLoggedIn = false;
    }

    return success;
  }
}
