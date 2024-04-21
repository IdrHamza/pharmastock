import 'package:cloud_firestore/cloud_firestore.dart';

class Fourresp{
  late  String fourrespid;
  late  String fid;
  late  String email;
  Fourresp({required this.fourrespid,required this.fid, required this.email});
  Map<String,dynamic> toMap(){
    return {
      "fourrespid": fourrespid,
      "fid": fid,
      "email": email,
    };
  }
  factory Fourresp.fromFirestore(DocumentSnapshot doc){
    Map data=doc.data()  as Map<String,dynamic>;
    return Fourresp(
      fourrespid:doc.id ?? '',
      fid: data['fid'] ?? '',
      email: data['email'] ?? '',


    );

  }





}