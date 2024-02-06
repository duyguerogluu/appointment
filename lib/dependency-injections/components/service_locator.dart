import 'package:goresy/data/network/apis/auth_api.dart';
import 'package:goresy/data/network/apis/constants_api.dart';
import 'package:goresy/data/network/apis/partners_api.dart';
import 'package:goresy/data/network/dio_client.dart';
import 'package:goresy/data/network/rest_client.dart';
import 'package:goresy/data/repository.dart';
import 'package:goresy/data/app_shared_preferences.dart';
import 'package:goresy/dependency-injections/module/local_module.dart';
import 'package:goresy/dependency-injections/module/network_module.dart';
import 'package:goresy/router/app_router.dart';
import 'package:goresy/stores/constants_store.dart';
import 'package:goresy/stores/language_store.dart';
import 'package:goresy/stores/theme_store.dart';
import 'package:goresy/stores/auth_store.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../stores/partner_store.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(
      () => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(
      AppSharedPreferences(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(
      NetworkModule.provideDio(getIt<AppSharedPreferences>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(AuthApi(getIt<DioClient>()));
  getIt.registerSingleton(PartnersApi(getIt<DioClient>()));
  getIt.registerSingleton(ConstantsApi(getIt<DioClient>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(
    Repository(
      getIt<AuthApi>(),
      getIt<AppSharedPreferences>(),
    ),
  );

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));
  getIt.registerSingleton(AuthStore(getIt<Repository>(), getIt<AuthApi>()));
  getIt.registerSingleton(ConstantsStore(getIt<ConstantsApi>()));
  getIt.registerSingleton(PartnerStore(getIt<PartnersApi>()));

  getIt.registerSingleton(AppRouter());
}
