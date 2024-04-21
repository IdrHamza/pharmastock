import 'package:pharmastock/Models/Responsible.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class delivery{
  late final String uid;
  late final String fid;
  late final String lid;
  late final String demandid;
  late final String deliverydate;
  late final String statut;

  delivery({required this.uid ,required this.fid,required this.lid,required this.demandid,required this.deliverydate,required this.statut,});
  Map<String,dynamic>toMap(){
    return{
      'uid':uid,
      'fid':fid,
      'lid':lid,
      'demandid':demandid,
      'deliverydate':deliverydate,
      'statut':statut,

    };

  }
  delivery.fromDocumentsSnapshot(DocumentSnapshot<Map<String,dynamic>>doc){
    uid=doc.data()!["uid"];
    fid=doc.data()!["fid"];
    lid=doc.data()!["lid"];
    demandid=doc.data()!["demandid"];
    deliverydate=doc.data()!["deliverydate"];
    statut=doc.data()!["statut"];



  }



}