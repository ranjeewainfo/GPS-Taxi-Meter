import 'package:flutter/material.dart';
import 'package:gps_taxi_meter/home_view.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  checkPermission() async {
    if (await Permission.location.request().isGranted &&
        await Permission.mediaLibrary.request().isGranted) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeView()));
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.mediaLibrary,
      ].request();
      if (statuses[Permission.location]!.isGranted &&
          statuses[Permission.mediaLibrary]!.isGranted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeView()));
      } else {
        showPermissionDialog(context);
      }
    }
  }

  showPermissionDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        openAppSettings();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Need Permission"),
      content: Text(
          "You have to grant necessary permissions to access the application"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Text('GPS Taximeter'),
      )),
    );
  }
}
