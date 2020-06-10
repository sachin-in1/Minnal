import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

final CollectionReference infoCollection = 
                          Firestore.instance.collection('info');


Future<void> addInfo(String long,String lat,String dist) async{
  await infoCollection.document().setData({
    'long': long,
    'lat': lat,
    'time': DateTime.now(),
    'dist': dist,
  });
  return true;
}


}