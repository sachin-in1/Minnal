import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class DownloadService {
  DownloadService();
  final CollectionReference infoCollection =
      Firestore.instance.collection('info');
  downloadLogs() async {
    QuerySnapshot q = await _fetchLogs();
    List<List> rows = _convertToList(q);
    // rows.forEach((element) {
    //   print(element);
    // });
    if (await Permission.storage.request().isGranted) {
      String dir = '/storage/emulated/0/download/';
      String file = "$dir";
      File f = new File(file + "filename.csv");

// convert rows to String and write as csv file

      String csv = const ListToCsvConverter().convert(rows);
      f.writeAsString(csv);
      
    }
  }

  List<List> _convertToList(QuerySnapshot q) {
    List<List> rows = [];
    rows.add(["Distance", "Latitude", "Longitude", "Time"]);
    q.documents.forEach((element) {
      List<String> row = [];
      row.add(element.data["dist"]);
      row.add(element.data["lat"]);
      row.add(element.data["long"]);
      row.add(element.data["time"].toString());
      rows.add(row);
    });
    return rows;
  }

  Future<QuerySnapshot> _fetchLogs() async {
    return infoCollection.getDocuments();
  }
}
