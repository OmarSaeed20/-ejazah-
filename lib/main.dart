import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/view/auth/choose_language_screen.dart';
import 'package:ejazah/view/home/home_screen.dart';
import 'package:ejazah/view/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'widgets/app_colors.dart';
import 'core/global.dart';
import 'database/local/cache_helper.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: message.hashCode,
      channelKey: "ejazah_key",
      title: message.data["title"],
      body: message.data["body"],
    ),
  );
  log('==================== Background ====================');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'ejazah_key',
      channelName: 'ejazah',
      channelDescription: 'ejazah app...',
      defaultColor: Colors.red[800],
      ledColor: Colors.red[800],
      channelShowBadge: true,
      importance: NotificationImportance.High,
      enableVibration: true,
      playSound: true,
      enableLights: true,
      // icon: 'assets/images/notification_icon.png',
      // channelGroupKey: 'basic_test',
      // soundSource: 'resource://raw/notification_sound',
    )
  ],);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await CacheHelper.init();
  firebaseAuthUser = FirebaseAuth.instance;
  CurrentUser.deviceToken = await FirebaseMessaging.instance.getToken();

  log(CurrentUser.deviceToken.toString());

  isUserDateSaved = CacheHelper.getData(key: 'isUserDateSaved') ?? false;
  onboard = CacheHelper.getData(key: 'onboard') ?? false;
  if (isUserDateSaved) {
    CurrentUser.getUserData();
    print(CurrentUser.image);
  }
  log("TOKEN ---> ${CurrentUser.token}");
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: message.notification.hashCode,
        channelKey: "ejazah_key",
        title: message.notification!.title,
        body: message.notification!.body,
      ),
    );
    log('==================== onMessage ====================');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: message.notification.hashCode,
        channelKey: "ejazah_key",
        title: message.notification!.title,
        body: message.notification!.body,
      ),
    );
    log('==================== onMessageOpenedApp ====================');
  });
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) {},
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Widget navigateToScreen() {
    if (isUserDateSaved) {
      return HomeScreen();
    }
    if (onboard) {
      return ChooseLanguageScreen();
    }
    return SplashScreen();
  }

  @override
  Widget build(BuildContext context) => Sizer(
        builder: (context, orientation, deviceType) {
          return ChangeNotifierProvider(
            create: (BuildContext context) {},
            child: GetMaterialApp(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const <Locale>[
                Locale('en'),
                Locale('ar'),
              ],
              title: 'Ejazah',
              locale: const Locale('ar'),
              fallbackLocale: Locale('ar'),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.light(
                  primary: AppColor.buttonColor,
                  onPrimary: Colors.white, // <-- SEE HERE
                  onSurface: AppColor.buttonColor, // <-- SEE HERE
                ),
                useMaterial3: false,
                fontFamily: 'Tajawal',
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: navigateToScreen(),
            ),
          );
        },
      );
}
// Finish Code
