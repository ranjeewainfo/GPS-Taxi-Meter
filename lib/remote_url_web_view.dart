import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
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
        body: Container(color: Colors.white,
        child: Center(child: Text(widget.url!),),),
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
