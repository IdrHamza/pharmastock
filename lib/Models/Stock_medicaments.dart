import 'package:cloud_firestore/cloud_firestore.dart';


class Stockmed{
  late  String sid;
  late  String invenid;
  late  String quantity;
  late  String? medicament;
  Stockmed({required this.sid,required this.invenid,required this.quantity, required this.medicament});
  Map<String,dynamic>toMap(){
    return {
      'sid': this.sid,
      'invenid': invenid,
      'quantity': quantity,
      'medicament':medicament,
    };}
  factory Stockmed.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Stockmed(
      sid: doc.id ?? '',
      invenid: data['invenid'] ?? '',
      quantity: data['quantity'] ?? '',
      medicament: data['medicament'] ?? '',
    );
  }






}