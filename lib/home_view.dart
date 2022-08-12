import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isPageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('GPD Taxi Meter'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const WebviewScaffold(
            url: 'https://athalanga.lk/apps/gpsmeter/',
            geolocationEnabled: true,
            allowFileURLs: true,
            withJavascript: true,
            displayZoomControls: false,
            scrollBar: false,
          ),
          /*InAppWebView(
            initialUrlRequest: URLRequest(
                url: Uri.parse('https://athalanga.lk/apps/gpsmeter/')),
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                  useShouldOverrideUrlLoading: true,
                  mediaPlaybackRequiresUserGesture: false,
                  verticalScrollBarEnabled: false,
                  javaScriptEnabled: true,
                  javaScriptCanOpenWindowsAutomatically: true,
                  supportZoom: false),
              android: AndroidInAppWebViewOptions(
                useHybridComposition: true,
                allowFileAccess: true,
                allowContentAccess: true,
                geolocationEnabled: true,
              ),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
              ),
            ),
            onLoadStop: (c, uri) {
              setState(() {
                isPageLoaded = true;
              });
            },
          ),*/
          /*isPageLoaded
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: double.infinity,
                  child: const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                )*/
        ],
      ),
    );
  }
}
