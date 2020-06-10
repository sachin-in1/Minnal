import 'dart:async';
import 'package:Minnal/database/database.dart';
import 'package:Minnal/Screens/Stats.dart';
import 'package:Minnal/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';



 class MyHomePage extends StatefulWidget {
   MyHomePage({Key key, this.title}) : super(key: key);
   final String title;

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
     var contents= await readCounter();
     contents = contents + counter.toString()+ ":";
     // Write the file.
     print('content : $contents');
     return file.writeAsString('$contents');
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

   void dispose() {
     _timer.cancel();
//     super.dispose();
   }

   @override

   Widget build(BuildContext context) {
//     print(_counter);
     return Scaffold(
       appBar: AppBar(
         elevation: 0,
         backgroundColor: Theme.of(context).backgroundColor,
         leading: Image.asset('assets/drawer.png'),
       ),
       drawer: Drawer(
         child: Stats(),
       ),
     backgroundColor: Theme.of(context).backgroundColor,
     
       body: 
      //  Center(
        //  child: 
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Expanded(
               flex: 1,
               child: Text(
                 'Location',style: Theme.of(context).textTheme.headline2,
               ),
             ),
             RaisedButton(onPressed: () async{
               final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
               _lat = position.latitude.toString();
               _long = position.longitude.toString();
              //  print(position.altitude);
             },
             child: Text("Add Location"),
             ),
             Spacer(
               flex: 1,
 //              child:Text("")
             ),
             Expanded(
               flex: 1,
               child: Text(
                 'Minnal',style: Theme.of(context).textTheme.headline2,
               ),
             ),
             _counter%2==0?Expanded(child:Text((time*344/1000000).toString()+" Kilometers Away")):
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
                         onPressed: (){
                           setState(() {
                           _counter++;
                           startTimer(_counter);
                           if(_counter==2){
                             _counter=0;
                             if(_long == null || _lat == null){
                              Expanded(child:Text("Please add your location"));
                              print("ividee");
                             }
                             else{
                               var distance=time*344/1000000;
//                               writeCounter('');
                               writeCounter('$_lat,$_long,$distance Km');
//                               addInfo(_lat,_long,(time*344/1000000).toString());
                             }

                            //  print(time*344/100000);
                           }
                           print(time);
//                           else{
//                             startTimer(_counter);
//                           }
                         });
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