
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../utils/commonWidget/common_sub_screen_app_bar.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final String url = 'https://sites.google.com/weetechsolution.com/scolage/home';

  final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.disabled)
  ..loadRequest(Uri.parse('https://sites.google.com/weetechsolution.com/scolage/home'));
  // https://sites.google.com/view/ppsllp-emp-privacy-policy/home

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CommonSubScreenAppBar(),
      body:WebViewWidget(controller: controller,)


    );
  }
}
