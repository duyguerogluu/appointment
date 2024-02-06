import 'package:goresy/constants/constants.dart';
import 'package:goresy/router/app_router.dart';
import 'package:goresy/stores/language_store.dart';
import 'package:goresy/stores/auth_store.dart';
import 'package:goresy/stores/theme_store.dart';
import 'package:goresy/ui/settings/application_settings_screen.dart';
import 'package:goresy/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SessionWrapper extends StatefulWidget {
  final String? initialRoute;
  final Widget child;
  const SessionWrapper({super.key, this.initialRoute, required this.child});

  @override
  State<SessionWrapper> createState() => _SessionWrapperState();
}

class _SessionWrapperState extends State<SessionWrapper> {
  late final LanguageStore _languageStore;
  late final ThemeStore _themeStore;
  late final AuthStore _userStore;

  final _drawerKey = new GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late final List<CustomDrawerItem> drawerItems;

  @override
  void initState() {
    super.initState();

    drawerItems = <CustomDrawerItem>[
      CustomDrawerItem(
        icon: Icons.view_list_rounded,
        titleBuilder: (context) => S.of(context).drawerItemPartners,
        routePath: "/partners",
      ),
      CustomDrawerItem(
        icon: Icons.person_rounded,
        titleBuilder: (context) => S.of(context).drawerItemMyProfile,
        routePath: "/settings/my-profile",
      ),
      CustomDrawerItem(
        icon: Icons.app_settings_alt_outlined,
        titleBuilder: (context) => S.of(context).drawerItemApplicationSettings,
        routePath: "/settings/application",
      ),
      CustomDrawerItem(
        icon: Icons.logout_rounded,
        titleBuilder: (context) => S.of(context).settingsLogout,
        onTap: (item) =>
            ApplicationSettingsScreenState.logout(context, _userStore),
      ),
    ];

    _languageStore = getIt<LanguageStore>();
    _themeStore = getIt<ThemeStore>();
    _userStore = getIt<AuthStore>();
  }

  /*Future<bool> _onWillPop() async {
    /*if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else */
    if (context.canPop()) {
      context.pop();
    } else {
      var result = await context.showConfirmationDialog(
        message: S.of(context).areYouSureYouWantToExit,
      );

      if (!result) context.pop();
    }

    return Future.value(false);
  }*/

  CustomDrawerItem? _getDrawerItemByRoute(String route) {
    CustomDrawerItem? matchedItem;
    for (var item in drawerItems) {
      final itemRoute = item.routePath;
      // if route matched
      if (itemRoute != null && route.startsWith(itemRoute)) {
        // if this route longer than a previous one
        if (matchedItem == null ||
            matchedItem.routePath!.length < itemRoute.length) {
          matchedItem = item;
        }
      }
    }

    return matchedItem;
  }

  DrawerHeader _buildDrawerHeader() {
    final foregroundColor = Colors.black.withOpacity(0.8);

    return DrawerHeader(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.loginBg01,
          ),
          alignment: Alignment.topLeft,
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: 160,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.appLogo),
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              isAntiAlias: true,
              colorFilter: ColorFilter.mode(
                foregroundColor,
                BlendMode.modulate,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, CustomDrawerItem? activeItem) {
    return CustomDrawer(
      key: _drawerKey,
      items: drawerItems,
      selectedItem: activeItem,
      onItemTap: (CustomDrawerItem item) {
        if (item.routePath != null) {
          context.go(item.routePath!);
        }
      },
      header: _buildDrawerHeader(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String title) {
    return DraggableAppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        IconButton(
          onPressed: () {
            var anotherLocale = _languageStore.supportedLocales.firstWhere(
                (loc) =>
                    loc.languageCode != _languageStore.locale.languageCode);
            _languageStore.changeLanguage(anotherLocale);
          },
          icon: Text(
            _languageStore.locale.countryCode ??
                _languageStore.locale.languageCode,
            style: TextStyle(
              color: Theme.of(context).appBarTheme.foregroundColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            _themeStore.toggleDarkMode(!_themeStore.computedDarkMode);
          },
          icon: Icon(Icons.settings_brightness_outlined),
        ),
        IconButton(
          onPressed: () {
            _themeStore.changeThemeNo(
                (_themeStore.themeNo % AppThemeData.lightThemes.length) + 1);
          },
          icon: Icon(Icons.color_lens_outlined),
        ),
        if (Dimens.isMobileLayout(context) && !_themeStore.menuSideIsLeft)
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Icon(Icons.menu),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = LnRouter.of(context).location;
    final activeDrawerItem = _getDrawerItemByRoute(currentLocation);
    final appBarTitle = activeDrawerItem?.titleBuilder(context) ?? "";

    final isMobile = Dimens.isMobileLayout(context);
    final drawer = _buildDrawer(context, activeDrawerItem);

    Widget mainView = Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context, appBarTitle),
      body: widget.child,
      drawer: isMobile && _themeStore.menuSideIsLeft ? drawer : null,
      endDrawer: isMobile && !_themeStore.menuSideIsLeft ? drawer : null,
    );

    if (!isMobile) {
      final children = [
        SizedBox(
          width: Dimens.drawerWidth,
          child: drawer,
        ),
        VerticalDivider(width: 0.5),
        Expanded(child: mainView),
      ];

      mainView = Scaffold(
        body: Row(
          children: _themeStore.menuSideIsLeft
              ? children
              : children.reversed.toList(),
        ),
      );
    }

    return new AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
      ),
      child: mainView,
    );
  }
}
