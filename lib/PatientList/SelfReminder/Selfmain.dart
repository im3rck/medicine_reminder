import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medicine_reminder/Enhancements/LanguageConfig/AppLocalizations.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/Global_Bloc.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/UI/HomePage.dart';
import 'package:provider/provider.dart';

class MedicineReminder extends StatefulWidget {
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        /*theme: ThemeData(
          primarySwatch: Colors.black,
          brightness: Brightness.dark,
        ),*/
        supportedLocales: [
          Locale('en','US'),
          Locale('hi','IN'),
          Locale('ml','IN')
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}