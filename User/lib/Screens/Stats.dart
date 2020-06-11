import 'package:flutter/cupertino.dart';
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

List MakeList(content){
  content=content.split('/');
  return content;
}
List MakeListfromList(content){
  content=content.split(',');
  return content;
}
class Stats extends StatefulWidget {
  String content;
  List Content;
  List FinalList=[];
  int itemCount;
  @override
  Stats(this.content);
  _StatsState createState() => _StatsState(this.content);
}

class _StatsState extends State<Stats> {
  String content;
  List Content;
  List FinalList=[];
  int itemCount;

  _StatsState(this.content);
  @override


  Widget build(BuildContext context) {
//    print()


    Content = MakeList(content);
    for(var i=0;i<Content.length-1;i++){
      print("blah");
      var temp = MakeListfromList(Content[i]);
      if(temp!=' '){
        FinalList= FinalList + temp;
      }
    }

    print(FinalList);
    itemCount = (FinalList.length/4).floor();
    FinalList=FinalList.reversed.toList();
    print(FinalList.length);

    if(itemCount>10)
      itemCount = 10;
    
    return Scaffold(backgroundColor: Color(0xff383838),
    body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xfff2d229), Colors.cyan])),
      child:
//    Text("hi ")
    ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, position) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Card(
//            color: Colors.blueAccent,
//            double.parse(FinalList[position*4+3])<1?Colors.red[(double.parse(FinalList[position*4+3])).floor()*100]:Colors.green[(1/double.parse(FinalList[position*4+3])).floor()*100],
            child: Padding(

              padding: const EdgeInsets.all(16.0),
              child: Flex(
                direction: Axis.horizontal,
                children:<Widget>[
                  Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(FinalList[position*4+3]+ " Km Away",
                              style: TextStyle(fontSize: 15.0),),]),
                    ),
                  ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child:Wrap(
//                            crossAxisAlignment: WrapCrossAlignment.end,
                            alignment: WrapAlignment.end,
                          children: <Widget>[
                                Text(FinalList[position*4], style: TextStyle(fontSize: 10.0),textAlign: TextAlign.right,),
                                SizedBox(height: 20,),
                                Text(FinalList[position*4+2], style: TextStyle(fontSize: 10.0),textAlign: TextAlign.right),
                                SizedBox(height: 20,),
                            Text(FinalList[position*4+1], style: TextStyle(fontSize: 10.0),textAlign: TextAlign.right),
                              ],
                            ),
                        ),
                      )
                    ],
              ),
            ),
        ),
        );
//        }
      },
    ),
    )
    );
  }
}
