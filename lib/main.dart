import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import './random_words.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/foundation.dart' show TargetPlatform;

void main() => runApp(MyMainApp());

class MyMainApp extends StatefulWidget {
  @override
  MyApp createState() => MyApp();
}

class MyApp extends State<MyMainApp> {
  String _appSecret = 'Unknown';
  String _installId = 'Unknown';
  bool _areAnalyticsEnabled = false, _areCrashesEnabled = false;

  MyApp() {
    final ios = defaultTargetPlatform == TargetPlatform.iOS;
    _appSecret = ios
        ? "40f17c96-1911-4b2b-8933-6a3c61200156"
        : "737fc290-7e3e-4099-9625-e1e812dd2442";
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    await AppCenter.start(
        _appSecret, [AppCenterAnalytics.id, AppCenterCrashes.id]);

    await AppCenter.setEnabled(true); // global
    await AppCenterAnalytics.setEnabled(true); // just a service
    await AppCenterCrashes.setEnabled(true); // just a service

    print('initState is called.');
    if (!mounted) return;

    var installId = await AppCenter.installId;

    var areAnalyticsEnabled = await AppCenterAnalytics.isEnabled;
    var areCrashesEnabled = await AppCenterCrashes.isEnabled;

    setState(() {
      _installId = installId;
      _areAnalyticsEnabled = areAnalyticsEnabled;
      _areCrashesEnabled = areCrashesEnabled;
    });
  }

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple[900]),
        home: RandomWords());
  }
}




// final ios = defaultTargetPlatform == TargetPlatform.iOS;
// var app_secret = ios ? "40f17c96-1911-4b2b-8933-6a3c61200156" : "737fc290-7e3e-4099-9625-e1e812dd2442";

// await AppCenter.start(app_secret, [AppCenterAnalytics.id, AppCenterCrashes.id]);

// await AppCenter.setEnabled(false); // global
// await AppCenterAnalytics.setEnabled(false); // just a service
// await AppCenterCrashes.setEnabled(false); // just a service