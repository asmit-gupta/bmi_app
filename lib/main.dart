import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mainpage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //this is done to lock the orientation of the app so that it doesn't rotate when device is rotated.
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}
