import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'services/download.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(
        child: 
        Stack(children: <Widget>[
          InkWell(
          onTap: () async {
            DownloadService().downloadLogs();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Download Complete.'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            'Please Check Your Download Folder (report.csv)',
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          },
          child: Container(
            height: MediaQuery.of(context).size.width / 2,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(MediaQuery.of(context).size.width / 2),
              color: Colors.blueAccent,
            ),
            child: Center(
              child: Text(
                'Download'.toUpperCase(),
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        // SizedBox(height: 5,),
        // RaisedButton(onPressed: (){},),

        ],)
        
      ),
      floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: FloatingActionButton(child: Text("Delete"),
        onPressed: () async{
                final CollectionReference infoCollection =
      Firestore.instance.collection('info');
      // print(infoCollection.firestore.collection());
                infoCollection.firestore.collection('info').getDocuments().then((snapshot) {
                          for (DocumentSnapshot ds in snapshot.documents){
                                ds.reference.delete();
                                }
                  });
                  showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Deletion Complete'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          // Text(
                          //   'Please Check Your Download Folder (report.csv)',
                          // ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });

      },),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
