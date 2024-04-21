import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmastock/Models/DemandSupplier.dart';
import 'package:pharmastock/Models/Demands.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:pharmastock/Models/Respfour.dart';
import 'package:pharmastock/Screens/Responsablefield/ResponsableInterface/DemandInfo.dart';
import 'package:pharmastock/Screens/Responsablefield/ResponsableInterface/MedicamentInfo.dart';
import 'package:pharmastock/Services/OtherServices.dart';

import '../../../Models/supplier.dart';
import '../../../Services/Crud.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  Crud crud = Crud();
  late Stream<List<Demands>> demands;
  TextEditingController name = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController email = TextEditingController();
  get docid => docid;
  late Future<List<Respfour>> supplier;
  final db = FirebaseFirestore.instance;
  List<Respfour> suppliers = [];
  final _formKey = GlobalKey<FormState>();
  others other=others();
  late Stream<int> count;
  late Stream<Supplier> supplierinfo;

  Respfour? selectedSupplier;
  TextEditingController statut = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    demands = crud.getDemands();
    count=other.getDemandCollectionCounta("Demands");
    fetchData();
  }

  Future<void> fetchData() async {
    List<Respfour>  supplierList = await crud.getRespfour();
    setState(() {
      suppliers = supplierList;
      
    });
  }

  Future<void> _refreshList() async {
    // Fetch new data or update the UI here
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      demands = crud.getDemands();
      supplier = crud.getRespfour();
      count=other.getDemandCollectionCounta("Demands");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      backgroundColor: Color(0xFFEEEFF5),




      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: StreamBuilder<List<Demands>>(
            stream: demands,
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
                    child: Expanded(
                      child: Text(
                      "Demandes",
                      style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w500,color: Colors.black),
                      ),
                    ),
                    )),
                  ),SizedBox(width: 30,),
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
                            final docid = data.mid;
                            return Dismissible(
                              onDismissed: (direction) {
                                crud.deleteDemand(data.demandid);
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
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        String? id = data.demandid;
                                        return AlertDialog(
                                          actions: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                SizedBox(height: 30),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child:
                                                      DropdownButtonFormField<
                                                          Respfour>(
                                                    value: selectedSupplier,
                                                    items: suppliers.map(
                                                        (Respfour supplier) {
                                                      return DropdownMenuItem<
                                                          Respfour>(
                                                        value: supplier,
                                                        child: Text(
                                                            supplier.email.toString()),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (Respfour? newValue) {
                                                      setState(() {
                                                        if (selectedSupplier ==
                                                            null) {
                                                          selectedSupplier
                                                                  ?.email =
                                                              data.email!;
                                                        } else {
                                                          selectedSupplier =
                                                              newValue;
                                                        }
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Select Supplier',
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    20),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .green)),
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    20),
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .green)),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(20),
                                                            borderSide: BorderSide(color: Colors.green)),
                                                        labelStyle: TextStyle(color: Colors.green, fontSize: 20)),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                        child: TextButton(
                                                            onPressed:
                                                                () async {
                                                              String emails =
                                                                  email.text;
                                                              final CollectionReference
                                                                  suppliersCollection =
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'Supplier');
                                                              final QuerySnapshot
                                                                  snapshot =
                                                                  await suppliersCollection
                                                                      .where(
                                                                          'email',
                                                                          isEqualTo:
                                                                              email.text)
                                                                      .get();

                                                              late Demands demandsdata = Demands(
                                                                  uid:
                                                                      user?.uid,
                                                                  mid: ' ',
                                                                  demandid: id,
                                                                  demanddate: DateTime
                                                                          .now()
                                                                      .toString(),
                                                                  deliverydate:
                                                                      ' ',
                                                                  statut: ' ',
                                                                  email: selectedSupplier
                                                                      ?.email);

                                                              crud.upadateDemand(
                                                                  demandsdata);
                                                              name.text = '';
                                                              quantity.text =
                                                                  '';

                                                              selectedSupplier =
                                                                  null;

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                                "Confirm ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green)))),
                                                    Expanded(
                                                        child: TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                            )))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => DemandInfo(
                                                demid: data.demandid)));
                                  },
                                  child: StreamBuilder<Supplier>(
                                    stream: other.getDocumentSupplierByEmail(data.email),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final supplier = snapshot.data!;
                                        return Container(
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
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            title: Text(
                                              supplier.lname + ' ' + supplier.lname,
                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color:Colors.white),
                                            ),
                                            subtitle: Text(
                                              supplier.email,
                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color: Colors.white),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_right_sharp,
                                              color: Colors.white,
                                            ),
                                            leading: Icon(Icons.medication,color:Colors.white
                                      )));
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        return CircularProgressIndicator(); // Display a loading indicator
                                      }
                                    },
                                  )
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
        heroTag: "3",
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
                        SizedBox(height: 30),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButtonFormField<Respfour>(
                                value: selectedSupplier,
                                items: suppliers.map((Respfour supplier) {
                                  return DropdownMenuItem<Respfour>(
                                    value: supplier,
                                    child: Text(supplier.email.toString()),
                                  );
                                }).toList(),
                                onChanged: (Respfour? newValue) {
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
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Hero(
                              tag: "1",
                              child: Expanded(
                                  child: TextButton(
                                      onPressed: () async {
                                        String emails = email.text;
                                        final CollectionReference
                                            suppliersCollection =
                                            FirebaseFirestore.instance
                                                .collection('Supplier');
                                        final QuerySnapshot snapshot =
                                            await suppliersCollection
                                                .where('email',
                                                    isEqualTo: email.text)
                                                .get();

                                        late Demands demandsdata = Demands(
                                            uid: user?.uid,
                                            mid: ' ',
                                            demandid: '',
                                            demanddate:
                                                DateTime.now().toString(),
                                            deliverydate: ' ',
                                            statut: ' ',
                                            email: selectedSupplier?.email);
                                        crud.addDemand(demandsdata);
                                        QuerySnapshot querySnapshot =
                                            await FirebaseFirestore.instance
                                                .collection('Demands')
                                                .where('email',
                                                    isEqualTo:
                                                        selectedSupplier?.email)
                                                .limit(1)
                                                .get();
                                        QuerySnapshot supp =
                                            await FirebaseFirestore
                                                .instance
                                                .collection('Supplier')
                                                .where(
                                                    'email',
                                                    isEqualTo:
                                                        selectedSupplier?.email)
                                                .limit(1)
                                                .get();
                                        DocumentSnapshot demand =
                                            querySnapshot.docs.first;
                                        DocumentSnapshot suppid =
                                            supp.docs.first;
                                        name.text = '';
                                        quantity.text = '';

                                        selectedSupplier = null;
                                        ;

                                        Navigator.pop(context);
                                      },
                                      child: Text("Confirm ",
                                          style:
                                              TextStyle(color: Colors.green)))),
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Hero(
                              tag: "2",
                              child: Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        name.text = '';
                                        quantity.text = '';

                                        selectedSupplier = null;
                                        ;
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.green),
                                      ))),
                            )
                          ],
                        )
                      ],
                    )),
                  ),
                );
              });
        }),
        tooltip: 'add',
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
