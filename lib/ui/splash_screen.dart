import 'package:goresy/constants/assets.dart';
import 'package:goresy/router/app_router.dart';
import 'package:goresy/stores/auth_store.dart';
import 'package:goresy/stores/constants_store.dart';
import 'package:goresy/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthStore _userStore = getIt<AuthStore>();
  final ConstantsStore _constantsStore = getIt<ConstantsStore>();

  @override
  void initState() {
    super.initState();
    //navigate();
  }

  Widget _buildAppIcon(BuildContext context) {
    //getting screen size
    var size = MediaQuery.of(context).size;

    //calculating container width
    double imageSize;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      imageSize = (size.width * 0.20);
    } else {
      imageSize = (size.height * 0.20);
    }

    return Image.asset(
      Assets.appLogo,
      height: imageSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAppIcon(context),
          SizedBox(
            height: 24,
          ),
          Observer(builder: (context) {
            if (_userStore.storeState == AuthStoreState.READY &&
                _constantsStore.storeState == ConstantsStoreState.READY)
              _navigate();
            return _userStore.storeState == AuthStoreState.FAILED ||
                    _constantsStore.storeState == ConstantsStoreState.FAILED
                ? _buildForFailed()
                : CircularProgressIndicator();
          }),
        ],
      ),
    );
  }

  _navigate() {
    Future.microtask(() {
      late String route;
      if (_userStore.sessionReady)
        route = AppRouter.initialLocationWithSession;
      else
        route = AppRouter.initialLocationWithoutSession;

      if (LnRouter.of(context).location != route)
        context.go(route, addToHistory: false);
    });

    return Icon(
      Icons.check_rounded,
      size: 20,
    );
  }

  Widget _buildForFailed() {
    return CustomError.somethingWentWrong(
      context: context,
      onPressRetry: () {
        if (_userStore.storeState == AuthStoreState.FAILED) {
          _userStore.init();
        }

        if (_constantsStore.storeState == ConstantsStoreState.FAILED) {
          _constantsStore.init();
        }
      },
    );
  }
}
