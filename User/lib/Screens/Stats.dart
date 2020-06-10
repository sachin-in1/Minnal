import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';



Future<String> get _localPath async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  //     final directory = await getApplicationDocumentsDirectory();
//
  return appDocPath;
}
Future<File> get _localFile async {
  final path = await _localPath;
//     print('$path');
  return File('$path/counter.txt');
}
Future<String> readCounter() async {
  try {
    final file = await _localFile;

    // Read the file.
    String contents = await file.readAsString();
    return '$contents';
  } catch (e) {
    // If encountering an error, return 0.
    return "";
  }
}

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.green,
    body: Text("contents in future")
    );
  }
}
