import 'package:Minnal/Screens/Home.dart';
import 'package:Minnal/Screens/Stats.dart';
import 'package:Minnal/shared/constants.dart';
//import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case statsRoute:
        return MaterialPageRoute(builder: (_) => Stats(settings.arguments));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}