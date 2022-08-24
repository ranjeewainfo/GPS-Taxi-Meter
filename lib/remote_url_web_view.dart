import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';

import 'home_view.dart';

class RemoteURLWebView extends StatefulWidget {
  String url;
  RemoteURLWebView({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<RemoteURLWebView> createState() => _RemoteURLWebViewState();
}

class _RemoteURLWebViewState extends State<RemoteURLWebView> {
  bool isPageLoaded = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(HomeView());
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('GPS Taxi Meter'),
            centerTitle: true,
          ),
          body: WebviewScaffold(
            url: widget.url,
            geolocationEnabled: true,
            allowFileURLs: true,
            withJavascript: true,
            displayZoomControls: false,
            scrollBar: false,
          )),
    );
  }
}
