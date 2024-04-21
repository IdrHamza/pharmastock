import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/supplier.dart';
class others{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final User? user=FirebaseAuth.instance.currentUser;
Future<int>  getDemandCollectionCount(String collection) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(collection).where('uid',isEqualTo: user?.uid)
      .get();

  int count = querySnapshot.size;
  return count;

}


  Stream<int> getDemandCollectionCounti(String collection) {
    return FirebaseFirestore.instance
        .collection(collection)
        .where('uid', isEqualTo: user?.uid).where('statut',isEqualTo: ' ')
        .snapshots()
        .map((querySnapshot) => querySnapshot.size);
  }

  Stream<int> getDemandCollectionCounta(String collection) {
    return FirebaseFirestore.instance
        .collection(collection)
        .where('uid', isEqualTo: user?.uid)
        .snapshots()
        .map((querySnapshot) => querySnapshot.size);
  }
  Stream<int> getDeliveredCount() {
    return FirebaseFirestore.instance
        .collection("Demands")
        .where('uid', isEqualTo: user?.uid).where('statut',isEqualTo: "Delivred" )
        .snapshots()
        .map((querySnapshot) => querySnapshot.size);
  }
  Stream<int> getReceivedCount() {
    return FirebaseFirestore.instance
        .collection("Demands")
        .where('uid', isEqualTo: user?.uid).where('statut',isEqualTo: "received" )
        .snapshots()
        .map((querySnapshot) => querySnapshot.size);
  }
  Stream<int> getfournisseursDemand() {
    return FirebaseFirestore.instance
        .collection("Demands")
        .where('email', isEqualTo: user?.email)
        .snapshots()
        .map((querySnapshot) => querySnapshot.size);
  }
  Stream<int> getDeliveredCountfour() {
    return FirebaseFirestore.instance
        .collection("Demands")
        .where('email', isEqualTo: user?.email).where('statut',isEqualTo: "Delivred")
        .snapshots()
        .map((querySnapshot) => querySnapshot.size);}
  Stream<int> getfourresp() {
    return FirebaseFirestore.instance
        .collection("Fourresp")
        .where('fid', isEqualTo: user?.uid)
        .snapshots()
        .map((querySnapshot) => querySnapshot.size);}





  Stream<double> calculateTotalQuantity(String? invenid) {
    // Reference to the collection
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('Stockmed');

    // Create a query that filters the documents where 'invenid' attribute is equal to the specified value
    Query query = collectionRef.where('invenid', isEqualTo: invenid);

    // Return the stream of snapshots from the query
    return query.snapshots().map((QuerySnapshot querySnapshot) {
      double totalQuantity = 0;

      // Iterate through the documents and calculate the total quantity
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        // Perform a null check on the document data before accessing the 'quantity' field
        Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          String? quantityString = data['quantity'];

          // Convert the quantity string to a numeric value
          double quantity = double.tryParse(quantityString ?? '') ?? 0;

          // Add the quantity to the total
          totalQuantity += quantity;
        }
      }

      return totalQuantity;
    });
  }
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(String? id) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("Responsible")
        .where('uid', isEqualTo: id)
        .limit(1)
        .get();

    return snapshot.docs.first;
  }
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocumentSupplier(String? id) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("Supplier")
        .where('fid', isEqualTo: id)
        .limit(1)
        .get();

    return snapshot.docs.first;
  }
  Stream<Supplier> getDocumentSupplierByEmail(String? email) {
    return FirebaseFirestore.instance
        .collection("Supplier")
        .where('email', isEqualTo: email)
        .limit(1)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      final doc = snapshot.docs.first;
      return Supplier.fromFirestore(doc);
    });
  }



}