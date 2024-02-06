/*import 'package:goresy/data/app_shared_preferences.dart';
import 'package:goresy/dependency-injections/components/service_locator.dart';
import 'package:goresy/dependency-injections/module/local_module.dart';
import 'package:goresy/utils/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Firebase Test Request:

/*

DATA='{"notification": {"body": "Test Message","title": "Test Message"}, "priority": "high", "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id":"1", "status": "done"}, "to": "eAR90x0hSqKUD5velLFNu8:APA91bGKLBbWdhd7O8qTyZOPGLkoujO5BCRImBfXt7vvlsLMlQ0Av_f5ThEnsd6lcnoZcEu-qf6lVH_b9VMQrvg_EO75YoYddYFv4jLzvL6H0HYYWYP3Fm9y5Jhv0n9jSidr_DyGViNL"}'
curl https://fcm.googleapis.com/fcm/send -H "Content-Type:application/json" -X POST -d "$DATA" -H "Authorization: key=AAAAxL__F5c:APA91bH-NhM7bAOJc3Sm005RtqrgCKXp8hwhqK9UJDCDFQOEJS4r-u_v3L9ecbfFZrFmGH6Cah947f2Tezi4vK1Dx4uwWnARBybKEGy8I0Zz18qKuPpImRQFNNjPgD94YrG1mad0EenJ"

*/

typedef FirebaseMessagingListener = Function(
    String, String, List<String>, dynamic data);

abstract class FirebaseMessagingService {
  FirebaseMessagingService._();

  static Future<AppSharedPreferences> _appPreferences() async =>
      getIt.isRegistered<AppSharedPreferences>()
          ? getIt<AppSharedPreferences>()
          : AppSharedPreferences(await LocalModule.provideSharedPreferences());

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin()
        ..resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestPermission();

  static final List<FirebaseMessagingListener> listeners = [];

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    Log.wtf(
        'FirebaseMessagingService.firebaseMessagingBackgroundHandler called!');
    /*await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );*/

    await FirebaseMessagingService.handleMessage(message);
  }

  @pragma('vm:entry-point')
  static void onDidReceiveNotificationResponse(NotificationResponse details) {
    Log.wtf(
        'FirebaseMessagingService.onDidReceiveNotificationResponse: $details');
  }

  static Future<void> showLocalNotification(String title, String body) {
    const notificationDetailsAndroid = AndroidNotificationDetails(
      'fcm_default_channel',
      'fcm_default_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const notificationDetailsIOS = DarwinNotificationDetails();
    const notificationDetails = const NotificationDetails(
      android: notificationDetailsAndroid,
      iOS: notificationDetailsIOS,
    );
    return _plugin.show(0, title, body, notificationDetails,
        payload: 'Notification clicked !!');
  }

  static Future<void> handleMessage(RemoteMessage message,
      {List<FirebaseMessagingListener> listeners = const []}) {
    Log.wtf('FirebaseMessagingService.handleMessage: $message');
    String title = message.notification?.title ?? "";
    String contentMessage = message.notification?.body ?? "";

    return showLocalNotification(title, contentMessage);
  }

  static void _onTokenChanged(String token) {
    Log.wtf("FirebaseMessagingService._onTokenChanged: $token");
    _appPreferences()
        .then((appPreferences) => appPreferences.fcmToken.set(token));
  }

  static void darwinOnDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page

    Log.wtf(
        'FirebaseMessagingService.darwinOnDidReceiveLocalNotification called!');
    /*showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondScreen(payload),
              ),
            );
          },
        )
      ],
    ),
  );*/
  }

  static Future<void> initialize() async {
    /*await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );*/

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    final initializationSettingsAndroid =
        AndroidInitializationSettings("ic_appicon");
    final initializationSettingsDarwin = DarwinInitializationSettings(
        onDidReceiveLocalNotification:
            FirebaseMessagingService.darwinOnDidReceiveLocalNotification);
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );

    await _plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveNotificationResponse,
    );

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    Log.wtf('FirebaseMessagingService.initialize: User granted permission: '
        '${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((remoteMessage) {
      Log.wtf('FirebaseMessagingService.onMessage: $remoteMessage');

      FirebaseMessagingService.handleMessage(remoteMessage,
          listeners: listeners);
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      _onTokenChanged(token);
    });

    FirebaseMessaging.instance.getToken().then((token) {
      if (token != null) _onTokenChanged(token);
    });

    // firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     _myMessageHandler(message, listeners: _listeners);
    //   },
    //   onBackgroundMessage: _myMessageHandler,
    //   onLaunch: (Map<String, dynamic> message) async {
    //     //showLocalNotification("onLaunch", message.toString());
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     //showLocalNotification("onResume", message.toString());
    //   },
    // );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(
    //         sound: true, badge: true, alert: true, provisional: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });
    // _firebaseMessaging.getToken().then((String token) {
    //   Storage.getInstance().then((value) {
    //     Storage.putString("firebaseToken", token);
    //   });
    // });
  }
}
*/