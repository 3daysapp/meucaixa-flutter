import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meu_caixa_flutter/screens/login.dart';
import 'package:meu_caixa_flutter/utils/config.dart';

///
///
///
void main() async {
  bool debug = false;
  assert(debug = true);
  Config config = Config();
  config.debug = debug;

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  if (debug) {
    runApp(MeuCaixa());
  } else {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runZonedGuarded(
      () => runApp(MeuCaixa()),
      FirebaseCrashlytics.instance.recordError,
    );
  }
}

///
///
///
class MeuCaixa extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Caixa',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        accentColor: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
      navigatorObservers: <NavigatorObserver>[
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        const Locale('pt', 'BR'),
      ],
    );
  }
}
