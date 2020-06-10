import 'package:flutter/material.dart';

import 'services/download.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: () async {
            DownloadService().downloadLogs();
            showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
        title: Text('The file is downloaded'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('check Downloads(file_name.csv)'),
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
          },
          child: Text('Download'),
        ),
      ),
    );
  }
}
