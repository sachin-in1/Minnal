import 'dart:async';
import 'dart:ui';
import 'package:Minnal/database/database.dart';
import 'package:Minnal/Screens/Stats.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
final location = Location();

Future _checkGps() async {
if(!await location.serviceEnabled()){
   location.requestService();
  }
}
 class MyHomePage extends StatefulWidget {
   MyHomePage({Key key, this.title}) : super(key: key);
   final String title;
   final String content="";

   @override
   _MyHomePageState createState() => _MyHomePageState();
 }

 class _MyHomePageState extends State<MyHomePage> {
   AudioCache _audioCache;
   int _counter = 0;
    String _lat;
    String _long;
   Timer _timer;
   int time=0;
   int _start = 0;
   String content="";
   bool clicked;

  void playAudioo(){
    _audioCache.play('1.mp3');
  }

  void addInfo(String lat,String long,String dist) async{
        await DatabaseService().addInfo(lat,long,dist);
  }

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

   Future<File> writeCounter(String counter) async {
     final file = await _localFile;
     var contents = await readCounter(
     );
     if (counter != "") {
       contents = contents + counter.toString(
       ) + "/";
       // Write the file.
       return file.writeAsString('$contents');
     }
   }

   void startTimer(int _counter) {
     if(_counter%2!=0){
     const oneMilSec = Duration(milliseconds: 1);
     _timer = Timer.periodic(
       oneMilSec,
           (Timer timer) => setState(
             () {
             _start = _start + 1;
         },
       ),
     );
     }
     else{
       setState(() {
         time=_start;
       });
       _start=0;
       _timer.cancel();
     }
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

//   void dispose() {
//     _timer.cancel();
////     super.dispose();
//   }

   @override

   void initState() {
     readCounter().then((value){
//      print(content);
       setState(() {
         content= value;
       });

       print(content);
     });
     clicked = false;
     super.initState();
     _checkGps();
     _audioCache = AudioCache(prefix: "audio/", fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
   }


   Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
     return Scaffold(
       appBar: AppBar(
         elevation: 0,
         backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
       ),
       drawer: Drawer(

           child:_counter==0?Stats(content):
           Container(
             decoration: BoxDecoration(
                 gradient: LinearGradient(
                     begin: Alignment.topRight,
                     end: Alignment.bottomLeft,
                     colors: [Color(0xfff2d229), Colors.cyan])),
             child:Center(
               child: Wrap(
                 crossAxisAlignment: WrapCrossAlignment.center,
                 children: <Widget>[Padding(
                   padding: const EdgeInsets.all(18.0),
                   child: Text("Don't Forget to Click The Previous Button",style: TextStyle(color: Colors.white,letterSpacing: 2,fontSize: 20,fontWeight: FontWeight.bold),),
                 )],
               ),
             ),)
       ),
      backgroundColor: Theme.of(context).backgroundColor,
//    backgroundColor: Colors.blue,
     
       body: 
      //  Center(
        //  child: 
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Spacer(
               flex: 1,
             ),
             Expanded(
               flex: 1,
               child: Text(
                 'Lightning',style: Theme.of(context).textTheme.headline2,
               ),
             ),
             _long == null || _lat == null?Expanded(
               flex: 1,
               child: Text(
                 'Enable Location',style: Theme.of(context).textTheme.headline6,
               ),
             ):clicked==true?_counter%2==0?
             Expanded(
                 child:Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Column(
                   children: [
//                     Spacer(),
                     SizedBox(height: 8,),
                     Text("It Was  ",style: TextStyle(color:Colors.black, fontSize: 18,letterSpacing: 1.5)),
                     Spacer()
                   ],
                 ),
                 Text((time*344/1000000).toStringAsFixed(3),style: TextStyle( fontSize: 26,fontWeight: FontWeight.bold),),
                 Column(
                   children: [
//                     Spacer(),
                     SizedBox(height: 8,),
                     Text("  kms Away",style: TextStyle(color:Colors.black, fontSize: 18,letterSpacing: 1.5)),
                     Spacer()
                   ],
                 )
               ],
             ))
                 :
             Expanded(child:Text("Click The Button When You Hear Thunder",style: TextStyle(height: 2, fontSize: 18))):Expanded(child:Text("Click The Button When You See Lighting",style: TextStyle(height: 2, fontSize: 18),)),
             _long == null || _lat == null ?
             Expanded(
               flex: 4,
//               child: Container(
                 child: Row(
                     mainAxisAlignment: MainAxisAlignment.center
                     ,
                     children: [
                 Container(
                 width: MediaQuery.of(context).size.width*0.8,
               height: MediaQuery.of(context).size.width*0.8,
                     child: RaisedButton(elevation: 10,
                       child:Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Center(
                           child:
//                           _counter%2==0?
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Image.asset('assets/map.png',height: MediaQuery.of(context).size.width*0.35,),
                               SizedBox(height:MediaQuery.of(context).size.width*0.15,
                               child: Text(""),)
                             ],
                           )
                           ),
//                         ),
                       ),
                       onPressed: () async{
                        var status = await Permission.location.request();
                        print(status);
                      //  final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);4
                      final position = await location.getLocation();
                      print(position);
                       setState(() {
                         _lat = position.latitude.toString();
                         _long = position.longitude.toString();

                       });
                      //  print(position.altitude);
                       playAudioo();
                     },
                         color: Colors.black,
                            shape : RoundedRectangleBorder(
                         borderRadius:BorderRadius.circular(MediaQuery.of(context).size.width*0.8),
     )
                     ),

                 )
                   ],
                 ),

                 ):
             Expanded(
               flex: 4,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center
                 ,
                 children: [
                   Container(
                     width: MediaQuery.of(context).size.width*0.8,
                     height: MediaQuery.of(context).size.width*0.8,
                     child: RaisedButton(
                         animationDuration: Duration(milliseconds: 10),
                         elevation: 10,
                         child:Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Center(
                             child: _counter%2==0?
                             Image.asset('assets/minnal.png',height: MediaQuery.of(context).size.width*0.6,)
                                 :
                                 Image.asset('assets/idi.png',height: MediaQuery.of(context).size.width*0.6,),
                           ),
                         ),
                         onPressed: () async {
                           playAudioo();
                           setState(() {
                           _counter++;
                           clicked=true;
                           startTimer(_counter);
                           if(_counter%2==0){
                             _counter=0;
                             if(_long == null || _lat == null){
                              // Expanded(child:Text("Please Turn on your location"));

                              print("evidee");
                              showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
        title: Text('Location Not Added'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Please add a location'),
              // Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
      });
                             }
                             else{
                               var distance=time*344/1000000;

                               var timenow =DateTime.now();

                               var dat = timenow.day;
                               var date = dat>9?'$dat':'0$dat';
                               var days=['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
                               var day = days[timenow.weekday];
                               var mont = timenow.month;
                               var month = mont>9?'$mont':'0$mont';
                               var year = timenow.year;
                               var datee = '$date.$month.$year';
                               var hou = timenow.hour > 12?timenow.hour-12:timenow.hour;
                               var hour=hou>9?hou.toString():'0$hou';
                               var ampm = timenow.hour > 12? 'PM': 'AM';
                               var minutes = timenow.minute;
                               var timm = (minutes > 9)?'$minutes':'0$minutes';
                               var timefull = hour +":" +timm+" " + ampm;
//                               writeCounter('');
                               writeCounter('${distance.toStringAsFixed(3)},$day,$datee,$timefull');
//                               print("bleh");
                              _audioCache.play('1.mp3');
                               addInfo(_lat,_long,(time*344/1000000).toString());

                             }
                            //  print(time*344/100000);

                           }
                         });
                           if(_long != null && _lat != null && _counter%2==0){
                             var contents = await readCounter();
                             setState(() {
                               content=contents;
                             });
                             print(content);
                           }
//                           if(_counter%2==0){
//                         }
                           },
                         color: Colors.black,
 //                  shape: BoxShape.circle,
                         shape: RoundedRectangleBorder(
                         borderRadius:BorderRadius.circular(MediaQuery.of(context).size.width*0.8),
                         )
                     ),
                   ),
 //                  Spacer()
                 ],
               )
             ),
             SizedBox(height: 10,),

           ],
         ),
      //  ),
      //  drawer: Drawer(),
     );
   }
 }