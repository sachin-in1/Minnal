 import 'dart:async';

import 'package:Minnal/shared/constants.dart';
 import 'package:flutter/cupertino.dart';
 import 'package:flutter/material.dart';



 class MyHomePage extends StatefulWidget {
   MyHomePage({Key key, this.title}) : super(key: key);
   final String title;

   @override
   _MyHomePageState createState() => _MyHomePageState();
 }

 class _MyHomePageState extends State<MyHomePage> {
   int _counter = 0;

//   void changeImage() {
//     setState(() {
//       _counter++;
//     });
//   }
   Timer _timer;
   int time=0;
   int _start = 0;

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
   void dispose() {
     _timer.cancel();
//     super.dispose();
   }

   @override

   Widget build(BuildContext context) {
//     print(_counter);
     return Scaffold(
     backgroundColor: Theme.of(context).backgroundColor,
       appBar: AppBar(
       leading: MaterialButton(
 //        color: Colors.transparent,
 //        splashColor: null,
         elevation: 0,
 //        child:
 //          Container(color:Colors.transparent,
             child: Image.asset("assets/drawer.png",fit: BoxFit.fill,height: 100,width: 100,),
 //          ),
         onPressed: (){
           Navigator.pushNamed(context, statsRoute);
         },
       ),
 //        title: Text('Home',style: Theme.of(context).textTheme.headline4,),
         elevation: 0,
         backgroundColor: Colors.transparent,
       ),
 //      drawer: Drawer(),
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Spacer(
               flex: 2,
 //              child:Text("")
             ),
             Expanded(
               flex: 1,
               child: Text(
                 'Minnal',style: Theme.of(context).textTheme.headline2,
               ),
             ),
             _counter%2==0?Expanded(child:Text((time*340/1000000).toString()+" Kilometers Away")):
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
       ),
     );
   }
 }