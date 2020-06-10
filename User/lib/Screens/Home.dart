import 'dart:async';
import 'package:Minnal/database/database.dart';
import 'package:Minnal/Screens/Stats.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';



 class MyHomePage extends StatefulWidget {
   MyHomePage({Key key, this.title}) : super(key: key);
   final String title;
   final String content="";

   @override
   _MyHomePageState createState() => _MyHomePageState();
 }

 class _MyHomePageState extends State<MyHomePage> {
   int _counter = 0;
    String _lat;
    String _long;
   Timer _timer;
   int time=0;
   int _start = 0;
   String content="";

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



   Widget build(BuildContext context) {

     return Scaffold(
       appBar: AppBar(
         elevation: 0,
         backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.blue),
       ),
       drawer: Drawer(

           child:Stats(content)),
    //  backgroundColor: Theme.of(context).backgroundColor,
    backgroundColor: Colors.blue,
     
       body: 
      //  Center(
        //  child: 
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             _long == null || _lat == null?Expanded(
               flex: 1,
               child: Text(
                 'Location',style: Theme.of(context).textTheme.headline1,
               ),
             ):Spacer(),
             _long == null || _lat == null ?RaisedButton(onPressed: () async{
               final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
               _lat = position.latitude.toString();
               _long = position.longitude.toString();
               print(position.altitude);
             },
             child: Text("Add Location"),
             ):
             Spacer(),
             Expanded(
               flex: 1,
               child: Text(
                 'Lightning',style: Theme.of(context).textTheme.headline2,
               ),
             ),
             _counter%2==0?Expanded(child:Text((time*344/1000000).toString()+" Kilometers Away",style: Theme.of(context).textTheme.headline6,)):
             Expanded(child:Text("Click The Button When You Hear Thunder")),
//                                                299792458).toString()+" Kilometers Away")):Spacer(),
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
                             Image.asset('assets/minnal.png')
                                 :
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.stretch,
                               children: [
                                 Image.asset('assets/idi.png',fit: BoxFit.cover,),
                               ],
                             ),
                           ),
                         ),
                         onPressed: () async {
                           if(_long != null && _lat != null && _counter%2==0){
                             var contents = await readCounter();
                             setState(() {
                               content=contents;
                             });
                             print('$_counter: , $content');}
                           setState(() {
                           _counter++;
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
            child: Text('Home'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
      });
      //                        AlertDialog(
      //   title: Text('AlertDialog Title'),
      //   content: SingleChildScrollView(
      //     child: ListBody(
      //       children: <Widget>[
      //         Text('This is a demo alert dialog.'),
      //         Text('Would you like to approve of this message?'),
      //       ],
      //     ),
      //   ),
      //   actions: <Widget>[
      //     FlatButton(
      //       child: Text('Approve'),
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //   ],
      // );
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
                               writeCounter('$distance,$day,$datee,$timefull');
//                               print("bleh");
                               addInfo(_lat,_long,(time*344/1000000).toString());

                             }
                            //  print(time*344/100000);

                           }
                         });
                           if(_counter%2==0){
                         }
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