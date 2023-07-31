import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heal/pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[DeviceOrientation.portraitUp]);
    return const MaterialApp(
      title: "HEAL",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
