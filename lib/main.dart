import 'package:flutter/material.dart';
import 'package:lifemap_betav1/pages/homeScreen/homePage.dart';
import 'package:lifemap_betav1/pages/setUpScreens/createStrength.dart';
import 'package:lifemap_betav1/pages/setUpScreens/createUser.dart';
import 'package:lifemap_betav1/pages/setUpScreens/createWeak.dart';
import 'package:lifemap_betav1/pages/setUpScreens/surplusScreen.dart';
import 'package:lifemap_betav1/screens/userInfoScreen.dart';
import 'package:lifemap_betav1/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => surplusScreen(),
        // 'home': (BuildContext context) => wrapper(),
      },
    );
  }
}
