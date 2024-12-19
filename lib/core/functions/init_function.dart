import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../firebase_options.dart';

abstract class InitFunction {
  static Future<void> initBasicConfiguration() async {
    //FLUTTER WIDGET BINDING
    WidgetsFlutterBinding.ensureInitialized();

    //CONFIGURE FIREBASE OPTIONS
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    //FOR RECORD CRASHES & ANALYTICS
    if (kReleaseMode) {
      FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
    } else {
      FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    }

    //SET APP ORIENTATION TO POTRAIT
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
  }
}
