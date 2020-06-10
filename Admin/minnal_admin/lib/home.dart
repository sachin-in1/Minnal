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
          },
          child: Text('Download'),
        ),
      ),
    );
  }
}
