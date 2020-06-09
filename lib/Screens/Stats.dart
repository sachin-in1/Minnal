import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';



class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.green,
    body: Center(child: RaisedButton(onPressed: () async{
      final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position.altitude);  
    },),),
    );
  }
}
