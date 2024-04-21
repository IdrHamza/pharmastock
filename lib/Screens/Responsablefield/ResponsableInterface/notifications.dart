import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmastock/Models/Pharmacie.dart';
import 'package:pharmastock/Services/OtherServices.dart';
import '../../../Models/Responsible.dart';
import '../../../Services/Crud.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final formKey = GlobalKey<FormState>(); // key for form
  String name = "";
  Crud crud = Crud();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController _emails = TextEditingController();
  TextEditingController _passwords = TextEditingController();
  TextEditingController phonenum=TextEditingController();
  others service = others();
  var doc;
  Responsible? usernow;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  String imageUrl = '';
  var pharmacy;
  Pharmacie? phar;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage;
  bool _isUploading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    doc = await service.getDocument(user?.uid);
    setState(() {
      pharmacy = crud.getDocument(user?.uid);
      if (doc != null && pharmacy != null) {
        usernow = Responsible.fromDocumentsSnapshot(doc);
        phar = Pharmacie.fromFirestore(pharmacy);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: formKey, // key for form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.04),
                Center(
                  child: Text(
                    "Update your informations",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    usernow?.fname ?? '',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.05),

                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green, width: 1),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green, width: 1),
                      ),
                      hintText: usernow?.lname ?? '',
                      labelText: "last name",
                      labelStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                    controller: lname,
                  ),
                ),
                SizedBox(height: height * 0.05),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green, width: 1),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "first name",
                      labelStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green, width: 1),
                      ),
                      hintText: usernow?.fname ?? '',
                    ),
                    controller: fname,
                  ),
                ),
                SizedBox(height: height * 0.05),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green, width: 1),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "birthday",
                      labelStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green, width: 1),
                      ),
                      hintText: usernow?.birthday ?? '',
                    ),
                    controller: birthday,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green, width: 1),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Phone number",
                      labelStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green, width: 1),
                      ),
                      hintText: usernow?.phonenum ?? '',
                    ),
                    controller: phonenum,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          if (usernow != null) {
                            Responsible resp = Responsible(
                              uid: usernow!.uid,
                              fname: getNonNullText(fname, usernow!.fname)
                                  .toString(),
                              lname: getNonNullText(lname, usernow!.lname)
                                  .toString(),
                              email: usernow!.email,
                              birthday:
                                  getNonNullText(birthday, usernow!.birthday)
                                      .toString(),
                              docid: usernow!.docid,
                              typeacc: 'resp', phonenum:  getNonNullText(phonenum, usernow!.phonenum).toString(),
                            );

                            crud.upadateResponsible(resp);

                            fetchData();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Submitting form')),
                            );
                            print('Updating Responsible data:');
                            print('UID: ${resp.uid}');
                            print('First Name: ${resp.fname}');
                            print('Last Name: ${resp.lname}');
                            // ... print other fields if necessary
                          }
                        },
                        icon: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? getNonNullText(TextEditingController controller, String? fallback) {
    final text = controller.text;
    return text.isEmpty ? fallback : text;
  }
}
