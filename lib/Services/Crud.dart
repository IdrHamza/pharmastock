import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:pharmastock/Models/Pharmacie.dart';
import 'package:pharmastock/Models/Responsible.dart';

import '../Models/DemandSupplier.dart';
import '../Models/Demands.dart';
import '../Models/Inventory.dart';
import '../Models/Medicament.dart';
import '../Models/Respfour.dart';
import '../Models/Stock_medicaments.dart';
import '../Models/delivery.dart';
import '../Models/fourresp.dart';
import '../Models/supplier.dart';

class Crud {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  Future<void> addResponsible(Responsible ResponsibleData) async {
    final docuser = _db.collection("Responsible").doc();
   ResponsibleData.docid = docuser.id;
    docuser.set(ResponsibleData.toMap());
  }
  upadateResponsible(Responsible ResponsibleData) async {
    final docid = await _db
        .collection("Responsible")
        .doc(ResponsibleData.docid)
        .update(ResponsibleData.toMap());
  }

  Future<void> deleteEmployee(String documentId) async {
    await _db.collection("Responsible").doc(documentId).delete();
  }

  Future<List<Responsible>> retrieveResponsible(String? email) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Responsible")
        .where('email', isEqualTo: email)
        .get();
    return snapshot.docs
        .map((docSnapshot) => Responsible.fromDocumentsSnapshot(docSnapshot))
        .toList();
  }

  Future<String?> addMedicament(Medicament MedicamentData) async {
    final docuser = _db.collection("Medicament").doc();
    MedicamentData.mid = docuser.id;
    docuser.set(MedicamentData.toMap());
  }

  upadateMedicament(Medicament MedicamentData) async {
    await _db
        .collection("Medicament")
        .doc(MedicamentData.mid)
        .update(MedicamentData.toMap());
  }

  Future<void> deleteMedicament(String documentId) async {
    await _db.collection("Medicament").doc(documentId).delete();
  }

  Stream<List<Medicament>> getMedicaData() {
    return _db
        .collection('Medicament')
        .where("uid", isEqualTo: user?.uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Medicament.fromFirestore(doc)).toList());
  }

  Future<List<Medicament>> retrieveMedicament() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Medicament").where('uid',isEqualTo: user?.uid).get();
    return snapshot.docs
        .map((docSnapshot) => Medicament.fromDocumentsSnapshot(docSnapshot))
        .toList();
  }

  addinventory(Inventory InventoryData) async {
    final docuser = _db.collection("Inventory").doc();
    InventoryData.Invenid = docuser.id;
    docuser.set(InventoryData.toMap());
  }

  upadateInventory(Inventory InventoryData) async {
    await _db
        .collection("Inventory")
        .doc(InventoryData.Invenid)
        .update(InventoryData.toMap());
  }

  Future<void> deleteInventory(String documentId) async {
    await _db.collection("Inventory").doc(documentId).delete();
  }

  Stream<List<Inventory>> getData() {
    return _db
        .collection('Inventory')
        .where("uid", isEqualTo: user?.uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Inventory.fromFirestore(doc)).toList());
  }

  addSupplier(Supplier SupplierData) async {
    final docuser = _db.collection("Supplier").doc();
    SupplierData.docid = docuser.id;
    docuser.set(SupplierData.toMap());
  }

  upadateSupplier(Supplier SupplierData) async {
    await _db
        .collection("Supplier")
        .doc(SupplierData.docid)
        .update(SupplierData.toMap());
  }

  Future<void> deleteSupplier(String documentId) async {
    await _db.collection("Supplier").doc(documentId).delete();
  }

  Future<List<Supplier>> retrieveSupplier() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = (await _db
        .collection("Supplier")) as QuerySnapshot<Map<String, dynamic>>;
    return snapshot.docs
        .map((docSnapshot) => Supplier.fromDocumentsSnapshot(docSnapshot))
        .toList();
  }

  Stream<List<Supplier>> getSupplierData() {
    return _db.collection('Supplier').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Supplier.fromFirestore(doc)).toList());
  }

  Future<List<Supplier>> getSuppliers() async {
    QuerySnapshot snapshot = await _db.collection('Supplier').get();
    return snapshot.docs.map((doc) => Supplier.fromFirestore(doc)).toList();
  }

  addDemand(Demands DemandsData) async {
    final docuser = _db.collection("Demands").doc();
    DemandsData.demandid = docuser.id;
    docuser.set(DemandsData.toMap());
  }

  upadateDemand(Demands DemandsData) async {
    await _db
        .collection("Demands")
        .doc(DemandsData.demandid)
        .update(DemandsData.toMap());
  }

  Future<void> deleteDemand(String? documentId) async {
    await _db.collection("Demands").doc(documentId).delete();
  }

  Future<List<Demands>> retrieveDemands(String? mid) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Demands").where("demid", isEqualTo: mid).get();
    return snapshot.docs
        .map((docSnapshot) => Demands.fromDocumentsSnapshot(docSnapshot))
        .toList();
  }

  Stream<List<Demands>> getDemands() {
    return _db
        .collection('Demands')
        .where('uid', isEqualTo: user?.uid)
        .where('statut', isEqualTo: ' ')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Demands.fromFirestore(doc)).toList());
  }

  Stream<List<Demands>> getfourDemands() {
    return _db
        .collection('Demands')
        .where('email', isEqualTo: user?.email)
        .where('statut', isEqualTo: ' ')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Demands.fromFirestore(doc)).toList());
  }

  Stream<List<Demands>> getfourDemandsacc() {
    return _db
        .collection('Demands')
        .where('email', isEqualTo: user?.email)
        .where('statut', isEqualTo: 'Delivred')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Demands.fromFirestore(doc)).toList());
  }

  Stream<List<Demands>> getrespDemandsacc() {
    return _db
        .collection('Demands')
        .where('uid', isEqualTo: user?.uid)
        .where('statut', isEqualTo: 'Delivred')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Demands.fromFirestore(doc)).toList());
  }

  Stream<List<Demands>> getreceivedDemand() {
    return _db
        .collection('Demands')
        .where('uid', isEqualTo: user?.uid)
        .where('statut', isEqualTo: 'received')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Demands.fromFirestore(doc)).toList());
  }

  adddelivery(delivery deliveryData) async {
    final docuser = _db.collection("Delivery").doc();
    deliveryData.lid = docuser.id;
    docuser.set(deliveryData.toMap());
  }

  upadatedelivery(delivery deliveryData) async {
    await _db
        .collection("delivery")
        .doc(deliveryData.lid)
        .update(deliveryData.toMap());
  }

  Future<void> deletedelivery(String documentId) async {
    await _db.collection("delivery").doc(documentId).delete();
  }

  Future<List<delivery>> retrievedelivery() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("delivery").get();
    return snapshot.docs
        .map((docSnapshot) => delivery.fromDocumentsSnapshot(docSnapshot))
        .toList();
  }

  addStockmed(Stockmed StockmedData) async {
    final docuser = _db.collection("Stockmed").doc();
    StockmedData.sid = docuser.id;
    docuser.set(StockmedData.toMap());
  }

  upadatStockmed(Stockmed StockmedData) async {
    await _db
        .collection("Stockmed")
        .doc(StockmedData.sid)
        .update(StockmedData.toMap());
  }

  Future<void> deletedeStockmed(String documentId) async {
    await _db.collection("Stockmed").doc(documentId).delete();
  }

  Stream<List<Stockmed>> getStockmedData(String numstock) {
    return _db
        .collection('Stockmed')
        .where("invenid", isEqualTo: numstock)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Stockmed.fromFirestore(doc)).toList());
  }

  addRespfour(Respfour RespfourData) async {
    final docuser = _db.collection("Respfour").doc();
    RespfourData.Respfourid = docuser.id;
    docuser.set(RespfourData.toMap());
  }

  upadateRespfour(Respfour RespfourData) async {
    await _db
        .collection("Respfour")
        .doc(RespfourData.Respfourid)
        .update(RespfourData.toMap());
  }

  Future<void> deletederespfour(String documentId) async {
    await _db.collection("Respfour").doc(documentId).delete();
  }

  Stream<List<Respfour>> getRespfourData() {
    return _db.collection('Respfour').where("uid",isEqualTo: user?.uid).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Respfour.fromFirestore(doc)).toList());
  }
  Future<List<Respfour>> getRespfour() async {
    QuerySnapshot snapshot = await _db.collection('Respfour').get();
    return snapshot.docs.map((doc) => Respfour.fromFirestore(doc)).toList();
  }

  addFourresp(Fourresp FourrespData) async {
    final docuser = _db.collection("Fourresp").doc();
    FourrespData.fourrespid = docuser.id;
    docuser.set(FourrespData.toMap());
  }

  upadateFourresp(Fourresp FourrespData) async {
    await _db
        .collection("Fourresp")
        .doc(FourrespData.fourrespid)
        .update(FourrespData.toMap());
  }

  Future<void> deletedeFourresp(String documentId) async {
    await _db.collection("Fourresp").doc(documentId).delete();
  }

  Stream<List<Supplier>> getFourrespDatawhere(String email) {
    return _db
        .collection('Supplier')
        .where('email', isEqualTo: email)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Supplier.fromFirestore(doc)).toList());
  }

  Stream<List<Fourresp>> getFourrespData() {
    return _db.collection('Fourresp').where('fid',isEqualTo: user?.uid).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Fourresp.fromFirestore(doc)).toList());
  }

  addPharma(Pharmacie Pharmaciedata) async {
    final docuser = _db.collection("Pharmacie").doc();
    Pharmaciedata.phid = docuser.id;
    docuser.set(Pharmaciedata.toMap());
  }

  upadatePharmacie(Pharmacie PharmacieData) async {
    await _db
        .collection("Pharmacie")
        .doc(PharmacieData.phid)
        .update(PharmacieData.toMap());
  }

  Future<void> deletePharmacie(String documentId) async {
    await _db.collection("Pharmacie").doc(documentId).delete();
  }

  Stream<List<Pharmacie>> getPharmacie() {
    return _db
        .collection('Pharmacie')
        .where('fid', isEqualTo: user?.uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Pharmacie.fromFirestore(doc)).toList());
  }

  addDMSP(DemSupp dmspData) async {
    final docuser = _db.collection("DemSupp").doc();
    dmspData.dfid = docuser.id;
    docuser.set(dmspData.toMap());
  }

  Future<void> updateDMSP(DemSupp dmspData) async {
    try {
      final docRef = _db.collection("DemSupp").doc(dmspData.dfid);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.update(dmspData.toMap());
        print('Document successfully updated.');
      } else {
        print('Document not found. Cannot update.');
      }
    } catch (error) {
      print('Error updating document: $error');
    }
  }

  Future<void> deleteDmspData(String? documentId) async {
    try {
      await _db.collection("DemSupp").doc(documentId).delete();
      print('Document successfully deleted.');
    } catch (error) {
      print('Error deleting document: $error');
    }
  }

  Stream<List<DemSupp>> getDMSP(String? demid) {
    return _db
        .collection('DemSupp')
        .where("demandid", isEqualTo: demid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => DemSupp.fromFirestore(doc)).toList());
  }

  Future<List<Pharmacie>> getPharmacielist() async {
    QuerySnapshot snapshot = await _db.collection('Pharmacie').get();
    return snapshot.docs.map((doc) => Pharmacie.fromFirestore(doc)).toList();
  }

  Future<DocumentSnapshot> getdata(String collection, String? id) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection(collection).doc(id).get();
    return documentSnapshot;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDocument(String? uid) {
    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // Create a query to get the document using the user's UID
    Query<Map<String, dynamic>> query =
        firestore.collection('Pharmacie').where("uid", isEqualTo: uid).limit(1);

    // Return a stream of the first document snapshot
    return query.snapshots().map((querySnapshot) => querySnapshot.docs.first);
  }
  Stream<Pharmacie> getDocumentPharmacie(String? uid) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> query = firestore
        .collection('Pharmacie')
        .where("uid", isEqualTo: uid)
        .limit(1);

    return query.snapshots().map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> docSnapshot =
            querySnapshot.docs.first;
        return Pharmacie.fromFirestore(docSnapshot);
      } else {
        throw Exception('Pharmacie not found');
      }
    });
  }


  Stream<DocumentSnapshot<Map<String, dynamic>>> getResponsable(String? uid) {
    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // Create a query to get the document using the user's UID
    Query<Map<String, dynamic>> query =
    firestore.collection('Responsible').where("uid", isEqualTo: uid).limit(1);

    // Return a stream of the first document snapshot
    return query.snapshots().map((querySnapshot) => querySnapshot.docs.first);
  }
  Stream<DocumentSnapshot<Map<String, dynamic>>> getFournisseur(String? uid) {
    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // Create a query to get the document using the user's UID
    Query<Map<String, dynamic>> query =
    firestore.collection('Responsible').where("fid", isEqualTo: uid).limit(1);

    // Return a stream of the first document snapshot
    return query.snapshots().map((querySnapshot) => querySnapshot.docs.first);
  }
}
