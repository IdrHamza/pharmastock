
import 'package:cloud_firestore/cloud_firestore.dart';

class Responsible{
  late  String? uid;
  late  String fname;
  late  String lname;
  late  String email;
  late  String birthday;
  late String? docid;
  late String  typeacc;
  late String phonenum;

  Responsible({   required this.uid,required this.fname,required this.lname,required this.email,required this.birthday,required this.docid,required this.typeacc,required this.phonenum});
  Map<String,dynamic>toMap(){
    return {
      'uid':this.uid,
    'fname':fname,
    'lname':lname,
    'email':email,
    'birthday':birthday,
    'docid':docid,
      'typeacc':typeacc,
      'phonenum':phonenum

    };


}
 Responsible.fromDocumentsSnapshot(DocumentSnapshot<Map<String,dynamic>>doc){
    uid=doc.data()!["uid"];
    fname=doc.data()!["fname"];
   lname=doc.data()!["lname"];
   email=doc.data()!["email"];
   birthday=doc.data()!["birthday"];
   docid=doc.data()!["docid"];
    typeacc=doc.data()!["typeacc"];
    phonenum=doc.data()!["phonenum"];



 }
  factory Responsible.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Responsible(
      uid: data['uid'],
      fname: data['fname'],
      lname: data['lname'] ?? '',
      email: data['email'] ?? '',
      birthday: data['birthday'] ?? '',
      docid: data['docid'] ?? '',
      typeacc: data['typeacc'] ?? '',
      phonenum: data['phonenum'] ?? '',


    );
  }
}
