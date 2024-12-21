import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_scolage/splash_screen.dart';
import 'package:new_scolage/utils/size/app_sizing.dart';

import 'core/functions/init_function.dart';
import 'firebase_options.dart';
import 'module/auth/services/databaseHelper.dart';
import 'module/auth/view/screen/login_screen.dart';
import 'module/dashboard/view/screen/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;

  await InitFunction.initBasicConfiguration();
  // await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //? CHANGE THIS AS PER FIGMA
        designSize: const Size(kFigmaWidth, kFigmaHeight),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            builder: (context, child) {
              final MediaQueryData data = MediaQuery.of(context);

              // BELOW STATEMENT MUST BE EXECUTE EXACTLY ONE TIME ONLY ( connect firebase )
              // FirebaseCrashlytics.instance.crash();
              return MediaQuery(
                data: data.copyWith(textScaleFactor: .92),
                child: child!,
              );
            },
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              useMaterial3: true,
              fontFamily: "SegoeUI",
              primarySwatch: Colors.blue,
            ),
            home:  SplashScreen(),
          );
        }
    );
  }
}
