import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/supplier.dart';
import '../Services/Crud.dart';
import '../Services/OtherServices.dart';

class UserPage extends StatefulWidget {

  const UserPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final formKey = GlobalKey<FormState>(); //key for form
  String name = "";
  Crud crud = Crud();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController Phonenum = TextEditingController();
  TextEditingController _passwords = TextEditingController();
  others service = others();
  var doc;
  Supplier? usernow;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final User? user=FirebaseAuth.instance.currentUser;
  String imageUrl='';

  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    doc = await service.getDocumentSupplier(user?.uid);
    setState(() {
      if (doc != null) {
        usernow = Supplier.fromDocumentsSnapshot(doc);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: formKey, //key for form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.04),
                Center(
                  child: Text(
                    "Update your information",style:TextStyle(fontSize: 25,color: Colors.deepPurple,fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    usernow?.fname ?? '',
                    style:TextStyle(fontSize: 25,color: Colors.deepPurple,fontWeight: FontWeight.bold),),

                ),
                SizedBox(height: height * 0.05),

                  SizedBox(height: 50,),
                Container(
                  margin: EdgeInsets.only(left:10,right:10),

                  child: TextFormField(
                    style: TextStyle(
                        color:Colors.deepPurple ,
                        fontWeight:FontWeight.bold ,
                        fontSize:18

                    ),



                    decoration: InputDecoration(
                      enabledBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.deepPurple ,width:1,),

                      ),floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(color: Colors.deepPurple,fontSize: 18),

                      focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.deepPurple ,width:1,)),

                      hintText: usernow?.lname ?? '',
                      labelText: "last name",
                    ),
                    controller: lname,
                  ),
                ),
                SizedBox(height: height * 0.05),
                Container(margin: EdgeInsets.only(left:10,right:10),

                  child: TextFormField(
                    style: TextStyle(
                        color:Colors.deepPurple ,
                        fontWeight:FontWeight.bold ,
                        fontSize:18
                    ),

                    decoration: InputDecoration(
                      enabledBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.deepPurple ,width:1,),

                      ),floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "first name",
                      labelStyle: TextStyle(color: Colors.deepPurple,fontSize: 18),
                      focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.deepPurple ,width:1,)),

                      hintText: usernow?.fname,
                    ),
                    controller: fname,
                  ),
                ),
                SizedBox(height: height * 0.05),
                Container(margin: EdgeInsets.only(left:10,right:10),

                  child: TextFormField(
                    style: TextStyle(
                        color:Colors.deepPurple ,
                        fontWeight:FontWeight.bold ,
                        fontSize:18
                    ),

                    decoration: InputDecoration(
                      enabledBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.deepPurple ,width:1,),

                      ),floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "birthday",
                      labelStyle: TextStyle(color: Colors.deepPurple,fontSize: 18),
                      focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.deepPurple ,width:1,)),

                      hintText: usernow?.birthday ?? '',
                    ),
                    controller: birthday,
                  ),
                ),
                SizedBox(height: 40),

                Container(margin: EdgeInsets.only(left:10,right:10),

                  child: TextFormField(
                    style: TextStyle(
                        color:Colors.deepPurple ,
                        fontWeight:FontWeight.bold ,
                        fontSize:18
                    ),

                    decoration: InputDecoration(
                      enabledBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.deepPurple ,width:1,),

                      ),floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Phone number",
                      labelStyle: TextStyle(color: Colors.deepPurple,fontSize: 18),
                      focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.deepPurple ,width:1,)),

                      hintText: usernow?.Phonenum ?? '',
                    ),
                    controller: Phonenum,
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          if (usernow != null) {
                            Supplier resp = Supplier(
                              fid: usernow!.fid,
                              fname: getNonNullText(fname, usernow!.fname).toString(),
                              lname: getNonNullText(lname, usernow!.lname).toString(),
                              email: usernow!.email,
                              birthday: getNonNullText(birthday, usernow!.birthday).toString(),
                              Phonenum: getNonNullText(Phonenum, usernow!.Phonenum).toString(),
                              docid: usernow!.docid, image: "", typeacc: 'su',
                            );
                            crud.upadateSupplier(resp);
                            setState(() {
                              lname.text='';
                              fname.text='';
                              birthday.text='';
                              Phonenum.text='';
                            });


                            fetchData();
                            final snackBar = SnackBar(content: Text('Submitting form'));
                            _scaffoldKey.currentState;
                            print('Updating Responsible data:');
                            print('UID: ${resp.fid}');
                            print('First Name: ${resp.fname}');
                            print('Last Name: ${resp.lname}');
                              print('Last Name: ${resp.fid}');

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
