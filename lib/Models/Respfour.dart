import 'package:cloud_firestore/cloud_firestore.dart';

class Respfour{
  late  String Respfourid;
  late   String? uid;
  late  String? fid;
  late  String? email;
Respfour({required this.Respfourid,required this.uid, required this.fid,required this.email});
  Map<String,dynamic> toMap(){
    return {
      "fourrespid": Respfourid,
      "uid": uid,
      "fid":fid,
      "email": email,
    };
  }
  factory Respfour.fromFirestore(DocumentSnapshot doc){
    Map data=doc.data()  as Map<String,dynamic>;
    return Respfour(
      Respfourid:doc.id ?? '',
      uid: data['uid'] ?? '',
      fid:data['fid'] ?? '',
      email: data['email'] ?? '',


    );}
  Respfour.fromDocumentsSnapshot(DocumentSnapshot<Map<String,dynamic>>doc){

  Respfourid=doc.id ?? '';
    uid=doc.data()!['uid'];
    fid=doc.data()!['fid'];
    email=doc.data()!['email'];}



  }