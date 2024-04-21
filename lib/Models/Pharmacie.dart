import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Pharmacie{
  late String? uid;
  late String phid;
  late String name;
  late String adress;
  late String fid;
  late String image;
  Pharmacie({required this.uid ,required this.phid  , required this.name, required this.adress , required this.fid,required this.image});
  Map<String,dynamic>toMap(){
    return {
      'uid':this.uid,
      'phid':phid,
      'name':name,
      'adress':adress,
    'fid':fid,
      'image':image,
    };


  }
  factory Pharmacie.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Pharmacie(
      uid: data['uid'] ?? '',
      phid: doc.id ?? '',
      name: data['name'] ?? '',
      adress: data['adress'] ?? '',
      fid:data['fid'] ?? '',
      image: data['image'] ?? '',
    );
  }
  factory Pharmacie.fromMap(Map<String, dynamic> map) {
    return Pharmacie(
      uid: map['uid'],
      phid: map['phid'],
      name: map['name'],
      adress: map['adress'],
      fid: map['fid'],
      image: map['image'],

    );
  }
}