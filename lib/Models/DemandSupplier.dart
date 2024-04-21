import 'package:cloud_firestore/cloud_firestore.dart';

class DemSupp{
  late  String demandid;
  late   String? uid;
  late  String? dfid;
  late String? name;
  late String? quantity;
  DemSupp({required this.demandid,required this.uid, required this.dfid,required this.name,required this.quantity});
  Map<String,dynamic> toMap(){
    return {
      "demandid": demandid,
      "uid": uid,
      "dfid":dfid,
      "name": name,
      "quantity": quantity,
    };
  }
  factory DemSupp.fromFirestore(DocumentSnapshot doc){
    Map data=doc.data()  as Map<String,dynamic>;
    return DemSupp(
      demandid:doc.id ?? '',
      uid: data['uid'] ?? '',
      dfid:data['dfid'] ?? '',
      name: data['name'] ?? '',
        quantity: data['quantity'] ?? ''




    );}}

