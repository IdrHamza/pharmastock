import 'package:pharmastock/Models/Responsible.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Medicament {
  late String? uid;
  late String? mid;
  late String? name;
  late String? DatedePreremption;
  late String? supplieremail;

  Medicament({required this.uid ,required this.mid,required this.name,required this.DatedePreremption,required this.supplieremail});
  Map<String,dynamic>toMap() {
    return {
      'uid': uid,
      'mid': mid,
      'name': name,
      'DatedePreremption': DatedePreremption,
      'supplieremail': supplieremail
    };
  }

  factory Medicament.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Medicament(
      uid: data['uid'] ?? '',
      mid: doc.id ?? '',
      name: data['name'] ?? '',
      DatedePreremption:data['DatedePreremption'] ?? '',
      supplieremail:data['supplieremail'] ?? '',

    );
  }
  Medicament.fromDocumentsSnapshot(DocumentSnapshot<Map<String,dynamic>>doc){
    uid=doc.data()!["uid"];
    mid=doc.data()!["mid"];
    name=doc.data()!["name"];
    DatedePreremption=doc.data()!["DatedePreremption"];
    supplieremail=doc.data()!["supplieremail"];


  }



}