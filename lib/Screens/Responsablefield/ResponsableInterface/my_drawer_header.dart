import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmastock/Services/Crud.dart';

import '../../../Models/Pharmacie.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  final FirebaseFirestore _db=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final User? user=FirebaseAuth.instance.currentUser;
  var pharmacy;
  Crud crud=Crud();
  Pharmacie? phar;
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {

    setState(() {
      pharmacy = crud.getDocument(user?.uid);

        phar = Pharmacie.fromFirestore(pharmacy);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/image/logo.jpg'),
              ),
            ),
          ),
          Text(
            "pharmastock",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            user!.email.toString(),
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),

          ),SizedBox(height:20)

          ,StreamBuilder<DocumentSnapshot>(
    stream: crud.getDocument(user?.uid),
    builder: (context, snapshot) {
    if (snapshot.hasData && snapshot.data!.exists) {
    DocumentSnapshot document = snapshot.data!;
    Pharmacie phar = Pharmacie.fromFirestore(document);

    // Rest of your UI using the phar object

    return Container(
    child: Text(phar.name,style: TextStyle(color: Colors.white),),
    );
    } else if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
    } else {
    return CircularProgressIndicator();
    }
    },
    )


    ],
      ),
    );
  }
}