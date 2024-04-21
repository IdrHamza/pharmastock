import 'package:cloud_firestore/cloud_firestore.dart';


class Inventory{
  late  String? uid;
  late  String Invenid;
  late  String numstock;
  Inventory({required this.uid,required this.Invenid,required this.numstock});
  Map<String,dynamic>toMap(){
    return {
      'uid': this.uid,
      'Invenid': Invenid,
      'numstock': numstock,
    };}
  factory Inventory.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Inventory(
      uid: data['uid'],
      Invenid: doc.id ?? '',
      numstock: data['numstock'] ?? '',
    );
  }






  }