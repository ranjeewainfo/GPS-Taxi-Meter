import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get.dart';

import 'home_view.dart';

class RemoteURLWebView extends StatefulWidget {
  String? url;
  bool shouldGoHome;

  RemoteURLWebView({Key? key, required this.url, this.shouldGoHome = false})
      : super(key: key);

  @override
  State<RemoteURLWebView> createState() => _RemoteURLWebViewState();
}

class _RemoteURLWebViewState extends State<RemoteURLWebView> {
  bool isPageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.shouldGoHome) {
          Get.offAll(HomeView());
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Notification'),
          centerTitle: true,
        ),
         body: Builder(builder: (BuildContext context) {
            return WebView(
              initialUrl: widget.url,
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
          })
        /*body: WebviewScaffold(
          url: widget.url!,
          geolocationEnabled: true,
          allowFileURLs: true,
          withJavascript: true,
          displayZoomControls: false,
          scrollBar: false,
        ),*/
      ),
    );
  }
}
