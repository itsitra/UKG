import 'dart:async';
import 'prereq.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

var log;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //await Firebase.initializeApp();
  // Wait for SharedPreferences.getString() to complete
  log = await getStringFromPreferences();
  print(log);
  runApp(MyApp());
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    if (Platform.isAndroid) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  });
}

Future<String> getStringFromPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.remove('Logged');
  return prefs.getString('Logged').toString();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return log == "Y"
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Prereq(),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Wel(),
          );
  }
}
