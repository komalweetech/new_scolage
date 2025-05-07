import 'package:app_links/app_links.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:new_scolage/splash_screen.dart';
import 'package:new_scolage/utils/size/app_sizing.dart';
import 'package:new_scolage/module/dashboard/view/screen/dashboard_screen.dart';
import 'dart:convert';

String? scannedCollegeId;
bool isFromQrScan = false; // Global flag to track QR scan

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
  }

  void _initDeepLinkListener() async {
    try {
      // Handle app opened via dynamic link
      final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks
          .instance.getInitialLink();
      if (initialLink?.link != null) {
        print("Initial dynamic link: ${initialLink!.link}");
        _handleDeepLink(initialLink.link);
      }

      // Listen for background/opened while running links
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
        print("Dynamic link while app running: ${dynamicLinkData.link}");
        _handleDeepLink(dynamicLinkData.link);
      }).onError((error) {
        print('Dynamic Link Failed: $error');
      });
    } catch (e) {
      print("Deep link error: $e");
    }
  }


  void _handleDeepLink(Uri uri) {
    try {
      String? id = uri.queryParameters['collegeId'];

      if (id == null || id.isEmpty) {
        final path = uri.path;
        if (path.contains('{') && path.contains('}')) {
          final jsonStr = Uri.decodeFull(path);
          final Map<String, dynamic> data = json.decode(jsonStr);
          id = data['collegeid'];
        }
      }

      if (id != null && id.isNotEmpty) {
        scannedCollegeId = id;
        isFromQrScan = true; // Set flag to true for QR scan
        print(
            "Extracted collegeId: $scannedCollegeId, isFromQrScan: $isFromQrScan");

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAll(() =>
              DashboardScreen(
                scannedCollegeId: scannedCollegeId,
                isFromQrScan: isFromQrScan,
              ));
        });
      }
    } catch (e) {
      print("Error handling deep link: $e");
    }
  }


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
            title: 'Scolage',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              useMaterial3: true,
              fontFamily: "SegoeUI",
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen(
              collegeId: scannedCollegeId,
              isFromQrScan: isFromQrScan, // Pass the flag to SplashScreen
            ),
          );
        }
    );
  }
}
