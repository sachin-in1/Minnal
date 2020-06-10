import 'package:Minnal/shared/constants.dart';
import 'package:flutter/material.dart';

import 'package:Minnal/Router/Router.dart';
//import 'Screens/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Router.generateRoute,
      initialRoute: homeRoute,
      theme: ThemeData(
//        primarySwatch: Colors.yellow,
          backgroundColor: Color(0xFFF4F66E),
          visualDensity: VisualDensity.adaptivePlatformDensity,
//        colorScheme: ColorScheme(background: Color(0xFFF4F66E),primary: Color(0xFFF4F66E),primaryVariant: Colors.white,secondary: Colors.white,secondaryVariant: Colors.white,surface: Colors.white,error: Colors.red,onPrimary: Colors.white,onBackground: Colors.white,onError: Colors.red,onSecondary: Colors.white,onSurface: Colors.white,brightness:Brightness.light),
          textTheme: TextTheme(
            headline1: TextStyle(
                color: Colors.white,
                letterSpacing: 4,
                fontSize: 40,
                fontWeight: FontWeight.w300),
            headline2: TextStyle(
                color: Colors.black,
                letterSpacing: 4,
                fontSize: 40,
                fontWeight: FontWeight.w300),
            headline3: TextStyle(color: Colors.white),
            headline4: TextStyle(
                color: Colors.black,
                letterSpacing: 2,
                fontWeight: FontWeight.w500),
          )),
//      home: MyHomePage(
//          title: 'Flutter Demo Home Page'
//      ),
    );
  }
}
