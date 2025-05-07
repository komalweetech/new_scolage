import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_scolage/utils/nevigation/Navigation_utils.dart';
import 'module/auth/controller/AuthController.dart';
import 'module/auth/view/screen/login_screen.dart';
import 'module/dashboard/view/screen/dashboard_screen.dart';
import '../controllers/college_controller.dart';
import 'module/college/view/screen/college_detail_screen.dart';

class SplashScreen extends StatefulWidget {
  final String? collegeId; // ID from direct QR scan
  final bool isFromQrScan; // Flag to indicate if from QR scan
  
  const SplashScreen({
    super.key, 
    this.collegeId,
    this.isFromQrScan = false,
  });

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authController = Get.find<AuthController>();
  final collegeController = Get.put(CollegeController());
  bool _navigationHandled = false; // Flag to prevent multiple navigations

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Ensure this runs only once
    if (_navigationHandled) return;

    // Fetch data first
    await collegeController.fetchAllData();
    if (!mounted || _navigationHandled) return; // Check mounted status and flag

    // --- Handle Direct QR Scan ID (Highest Priority) ---
    if (widget.collegeId != null && widget.isFromQrScan) {
      print("Direct QR ID detected: ${widget.collegeId}, isFromQrScan: ${widget.isFromQrScan}");
      _navigationHandled = true;
      
      // First navigate to DashboardScreen
      Get.offAll(() => DashboardScreen(
        scannedCollegeId: widget.collegeId,
        isFromQrScan: widget.isFromQrScan,
      ));
      
      // Then navigate to CollegeDetailScreen
      Future.delayed(Duration(milliseconds: 100), () {
        if (mounted) {
          Get.to(() => CollegeDetailScreen(
            clgId: widget.collegeId!,
            clgName: "College", // This will be updated with actual data
            clgImage: "assets/image/default.jpg",
          ));
        }
      });
      return; // Exit initialization early
    }

    // --- Handle Dynamic Links (Second Priority) ---
    if (!_navigationHandled) {
      print("Checking for dynamic links...");
      await handleDynamicLink();
      if (!mounted || _navigationHandled) return; // Check again
    }

    // --- Check Login Status (Lowest Priority) ---
    if (!_navigationHandled) {
      print("Checking login status...");
      await checkLoginStatus();
    }
  }

  Future<void> handleDynamicLink() async {
    try {
      // Check for initial link first
      final PendingDynamicLinkData? initialLink =
          await FirebaseDynamicLinks.instance.getInitialLink();
      if (await _handleDeepLink(initialLink)) {
        print("Handled initial dynamic link.");
        return; // Stop if initial link was handled
      }

      // Listen for incoming links if no initial link was handled
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
        print("Received dynamic link via listener.");
        await _handleDeepLink(dynamicLinkData);
      }).onError((error) {
        print('Dynamic Link Listener Failed: $error');
      });
    } catch (e) {
      print('Error handling dynamic link: $e');
    }
  }

  // Returns true if a navigation occurred, false otherwise
  Future<bool> _handleDeepLink(PendingDynamicLinkData? data) async {
    // Check if already handled to prevent race conditions
    if (_navigationHandled) return true;

    final Uri? deepLink = data?.link;
    print("Processing deep link: $deepLink");

    if (deepLink != null) {
      final collegeId = deepLink.queryParameters['collegeId'];
      if (collegeId != null) {
        print("Dynamic link collegeId found: $collegeId");
        _navigationHandled = true;
        // Navigate to Dashboard with the college ID and QR scan flag
        Get.offAll(() => DashboardScreen(
          scannedCollegeId: collegeId,
          isFromQrScan: true, // Set to true for dynamic links
        ));
        return true; // Navigation was handled
      }
    }
    print("No collegeId found in deep link or deep link is null.");
    return false; // No navigation occurred
  }

  Future<void> checkLoginStatus() async {
    if (_navigationHandled) return; // Don't check if navigation already happened

    try {
      await authController.checkLoginStatus();
      if (!mounted || _navigationHandled) return;

      if (authController.isAuthenticated.value) {
        print("User authenticated, navigating to Dashboard.");
        _navigationHandled = true;
        Get.offAll(() => DashboardScreen(isFromQrScan: false)); // Normal app start
      } else {
        print("User not authenticated, navigating to Login.");
        _navigationHandled = true;
        Get.offAll(() => LoginScreen());
      }
    } catch (e) {
      print('Error checking login status: $e');
      if (mounted && !_navigationHandled) { // Check mounted and flag
         print("Error during login check, navigating to Login.");
         _navigationHandled = true;
         Get.offAll(() => LoginScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // The build method should just show the loading/error state
    // The navigation logic is handled by _initialize and postFrameCallbacks
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (collegeController.isLoading.value && !_navigationHandled) {
             print("Displaying loading indicator (isLoading=true, navigationHandled=false)");
            return const CircularProgressIndicator();
          }
          if (collegeController.error.isNotEmpty && !_navigationHandled) {
             print("Displaying error message: ${collegeController.error.value}");
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error: ${collegeController.error.value}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                     print("Retry button pressed.");
                     _navigationHandled = false; // Reset flag on retry
                     collegeController.error.value = ''; // Reset error state directly
                     _initialize(); // Re-run initialization
                  },
                  child: const Text('Retry'),
                ),
              ],
            );
          }
          // If navigation has been handled or loading is done but no error,
          // show a progress indicator briefly until the navigation completes.
          print("Displaying final loading indicator (navigation likely pending/complete)");
          return const CircularProgressIndicator();
        }),
      ),
    );
  }
}
