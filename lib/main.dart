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
import 'module/auth/controller/AuthController.dart';
import 'module/auth/services/databaseHelper.dart';
import 'module/auth/view/screen/login_screen.dart';
import 'module/dashboard/view/screen/dashboard_screen.dart';
import 'myApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // Initialize Firebase first
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize other dependencies
  await DatabaseHelper.instance.database;
  await InitFunction.initBasicConfiguration();

  // Create AuthController after Firebase is initialized
  Get.put(AuthController());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

