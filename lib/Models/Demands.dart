import 'package:pharmastock/Models/Responsible.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Demands{
  late String? uid;
  late  String? mid;
  String? demandid;
  late  String demanddate;
  late  String deliverydate;
  late  String statut;


  late  String? email;
  Demands({required this.uid ,required this.mid,required this.demandid,required this.demanddate,required this.deliverydate,required this.statut,required this.email,});
  Map<String,dynamic>toMap(){
    return{
      'uid':uid,
      'mid':mid,
      'demandid':demandid,
      'demanddate':demanddate,
      'deliverydate':deliverydate,
      'statut':statut,


      'email':email

    };


  }
  Demands.fromDocumentsSnapshot(DocumentSnapshot<Map<String,dynamic>>doc){
    uid=doc.data()!["uid"];
    mid=doc.data()!["mid"];
    demandid=doc.data()!["demandid"];
    demanddate=doc.data()!["demanddate"];
    deliverydate=doc.data()!["deliverydate"];
    statut=doc.data()!["statut"];
    email=doc.data()!["email"];


  }
  factory Demands.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Demands(
      uid:data['uid']?? '',
      mid: data['mid']?? '',
      demandid: data['demandid'],
      demanddate: data['demanddate'] ?? '',
      deliverydate:data['deliverydate']?? '',
      statut: data['statut'] ?? '',
      email:data['email'] ?? '',

    );
  }
}




