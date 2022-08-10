import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
      body: Stack(
        children: [
          InAppWebView(
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
              ),
              android: AndroidInAppWebViewOptions(
                useHybridComposition: true,
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
          ),
          isPageLoaded
              ? SizedBox.shrink()
              : Center(
                  child: CircularProgressIndicator(),
                )
        ],
      ),
    );
  }
}
