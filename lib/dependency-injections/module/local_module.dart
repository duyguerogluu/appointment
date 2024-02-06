import 'dart:async';

import 'package:goresy/data/local/constants/db_constants.dart';
import 'package:goresy/utils/encryption/xxtea.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalModule {
  static Future<SharedPreferences> provideSharedPreferences() {
    return SharedPreferences.getInstance();
  }

  static Future<Database> provideDatabase() async {
    // Key for encryption
    var encryptionKey = "";

    final appDocumentDir = await getApplicationDocumentsDirectory();

    final dbPath = join(appDocumentDir.path, DBConstants.DB_NAME);

    var database;
    if (encryptionKey.isNotEmpty) {
      var codec = getXXTeaCodec(password: encryptionKey);
      database = await databaseFactoryIo.openDatabase(dbPath, codec: codec);
    } else {
      database = await databaseFactoryIo.openDatabase(dbPath);
    }

    return database;
  }
}
