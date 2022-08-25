import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:gps_taxi_meter/app_constants.dart';
import 'package:gps_taxi_meter/remote_url_web_view.dart';
import 'package:wakelock/wakelock.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isPageLoaded = false;

  @override
  void initState() {
    Wakelock.enable();
    super.initState();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('GPS Taxi Meter'),
        centerTitle: true,
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: 'https://athalanga.lk/apps/gpsmeter/',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {

          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
          geolocationEnabled: true,
        );
      }),
      /*body: WebviewScaffold(
        url: 'https://athalanga.lk/apps/gpsmeter/',
        geolocationEnabled: true,
        allowFileURLs: true,
        withJavascript: true,
        displayZoomControls: false,
        scrollBar: false,
        withOverviewMode: true,
        supportMultipleWindows: true,
      ),*/
    );
  }
}
