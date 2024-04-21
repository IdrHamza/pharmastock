import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmastock/Models/Respfour.dart';
import 'package:pharmastock/Models/supplier.dart';
import 'package:pharmastock/Screens/Responsablefield/Signin/InputField.dart';
import 'package:pharmastock/Services/Crud.dart';
import 'package:pharmastock/Services/OtherServices.dart';

import '../../../Models/Medicament.dart';

class Supplierpage extends StatefulWidget {
  @override
  _SupplierpageState createState() => _SupplierpageState();
}

class _SupplierpageState extends State<Supplierpage> {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final Crud crud = Crud();
  late Stream<List<Respfour>> supplier;
  Supplier? selectedSupplier;
  List<Supplier> suppliers = [];
  others other=others();
  late Stream<int>count;

  TextEditingController _email = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
    supplier = crud.getRespfourData();
    count=other.getDemandCollectionCounta("Respfour");
    
    fetchData();
  }

  Future<void> fetchData() async {
    List<Supplier> supplierList = await crud.getSuppliers();
    setState(() {
      suppliers = supplierList;
    });
  }

  Future<void> _refreshList() async {
    // Fetch new data or update the UI here
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      supplier = crud.getRespfourData();
      count=other.getDemandCollectionCounta("Respfour");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Scaffold(
        backgroundColor: Color(0xFFEEEFF5),
        body: RefreshIndicator(
          onRefresh: _refreshList,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: StreamBuilder<List<Respfour>>(
              stream: supplier,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text('Loading...');
                  default:
                    if (!snapshot.hasData) {
                      return Text('No data found.');
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  margin:
                                  EdgeInsets.only(top: 30, bottom: 30, left: 10),
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Colors.teal.withOpacity(0.1), width: 2.0),
                                    borderRadius: BorderRadius.circular(
                                      20.0,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.teal.shade100,
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.topLeft,


                                  child: Center(
                                    child: Text(
                                      "Fournisseurs",
                                      style: TextStyle(
                                          fontSize: 25, fontWeight: FontWeight.w500,),
                                    ),
                                  )),
                            ),
                            SizedBox(width: 30,),
                            StreamBuilder<int>(
                                stream: count,
                                builder: (context, snapshot) {

                                  if(snapshot.hasData){
                                    int y=snapshot.data!;

                                    return Expanded(
                                      child: Container(
                                          height: 150,
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: Colors.teal.withOpacity(0.1), width: 2.0),
                                            borderRadius: BorderRadius.circular(
                                              20.0,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.teal.shade100,
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          margin:
                                          EdgeInsets.only(top: 30, bottom: 30, left: 10),
                                          child: Center(
                                            child: Text(
                                              y.toString(),
                                              style: TextStyle(
                                                  fontSize: 30, fontWeight: FontWeight.w500,color: Colors.black),
                                            ),
                                          )),
                                    );}else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }
                                  return CircularProgressIndicator();
                                }
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data![index];
                              final fid = data.fid;
                              final docid = data.fid;
                              return Dismissible(
                                onDismissed: (direction) {
                                  crud.deletederespfour(data.Respfourid);
                                },
                                key: Key(UniqueKey().toString()),
                                background: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(

                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],

                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      title: Text(
                                        data.email.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_right_sharp,
                                        color: Colors.white,
                                      ),
                                      leading: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: SingleChildScrollView(
                      child: Dialog(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: DropdownButtonFormField<Supplier>(
                              value: selectedSupplier,
                              items: suppliers.map((Supplier supplier) {
                                return DropdownMenuItem<Supplier>(
                                  value: supplier,
                                  child: Text(supplier.email),
                                );
                              }).toList(),
                              onChanged: (Supplier? newValue) {
                                setState(() {
                                  selectedSupplier = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: 'Select Supplier',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  labelStyle: TextStyle(
                                      color: Colors.green, fontSize: 20)),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: TextButton(
                                      onPressed: () async {
                                        Respfour respfourdata = Respfour(
                                            Respfourid: ' ',
                                            uid: user?.uid,
                                            fid: ' ',
                                            email: selectedSupplier?.email);

                                        // The email exists in the Supplier collection
                                        // Call the function to add the respfourdata
                                        crud.addRespfour(respfourdata);

                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Confirm ",
                                      ))),
                              Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel")))
                            ],
                          )
                        ],
                      )),
                    ),
                  );
                });
          }),
          tooltip: 'add',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
