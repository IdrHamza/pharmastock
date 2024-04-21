import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHeaderDrawerFournisseurs extends StatefulWidget {
  @override
  _MyHeaderDrawerFournisseursState createState() => _MyHeaderDrawerFournisseursState();
}

class _MyHeaderDrawerFournisseursState extends State<MyHeaderDrawerFournisseurs> {
  final FirebaseFirestore _db=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final User? user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
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
          ),
        ],
      ),
    );
  }
}