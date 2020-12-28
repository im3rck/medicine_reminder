import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medicine_reminder/Authentication/GoogleSignUp.dart';
import 'package:medicine_reminder/Enhancements/LanguageConfig/AppLocalizations.dart';
import 'package:medicine_reminder/Enhancements/SplashScreen/SplashScreen.dart';
import 'package:medicine_reminder/LaunchScreen/gooey_edge.dart';
import 'package:medicine_reminder/MiddleOnboarding/Onboarding.dart';
import 'package:medicine_reminder/PatientController/PatientAddPage.dart';
import 'package:medicine_reminder/PatientList/FullPatientDetails/AddMedicine/AddMedicine.dart';
import 'package:medicine_reminder/PatientList/FullPatientDetails/PatientLog/mainLog.dart';
import 'package:medicine_reminder/PatientList/PhasePage.dart';
import 'package:medicine_reminder/StoreLocator/models/place.dart';
import 'package:medicine_reminder/StoreLocator/services/geolocator_service.dart';
import 'package:medicine_reminder/StoreLocator/services/places_service.dart';
import 'package:provider/provider.dart';
import 'package:medicine_reminder/LaunchScreen/demo.dart';
import 'PatientScreen/MedicineCard.dart';
import 'package:medicine_reminder/Authentication/Login/login.dart';
import 'package:flutter/services.dart';
import 'package:medicine_reminder/AlarmManager/AlarmManager.dart';
import 'package:medicine_reminder/Enhancements/FadeAnimation/FadeAnimation.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

alarmTest(){
  AlarmManager _AL = AlarmManager();
  DateTime dT = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,DateTime.now().hour,16);
  _AL.scheduleNotification(5000, 'title', 'body', dT);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final int helloAlarmID = 0;
  //alarmTest();
  // await AndroidAlarmManager.initialize();
  await Firebase.initializeApp();
  Paint.enableDithering = true;
  String token = await FirebaseMessaging().getToken();
  print('Token : $token');
  print(DateTime.tuesday.toString());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp()); });
  // await AndroidAlarmManager.periodic(const Duration(minutes: 1), helloAlarmID, setNotifications);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging _fcm = FirebaseMessaging();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
    var initializationSettingsAndroid =
        AndroidInitializationSettings('applogo');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => PhasePage()),
    );
  }

  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        FutureProvider(create: (context) {
          ImageConfiguration configuration =
              createLocalImageConfiguration(context);
          return BitmapDescriptor.fromAssetImage(
              configuration, 'assets/images/maps.png');
        }),
        ProxyProvider2<Position, BitmapDescriptor, Future<List<Place>>>(
          update: (context, position, icon, places) {
            return (position != null)
                ? placesService.getPlaces(
                    position.latitude, position.longitude, icon)
                : null;
          },
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Digital Medical Assistant',
          supportedLocales: [
            Locale('en', 'US'),
            Locale('hi', 'IN'),
            Locale('ml', 'IN')
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          home: MedicineCard('alalalalldldlaslalsalsllsllaslsd')),
    );
  }
}
