import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
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
        body: const WebviewScaffold(
          url: 'https://athalanga.lk/apps/gpsmeter/',
          geolocationEnabled: true,
          allowFileURLs: true,
          withJavascript: true,
          displayZoomControls: false,
          scrollBar: false,
        ));
  }
}
