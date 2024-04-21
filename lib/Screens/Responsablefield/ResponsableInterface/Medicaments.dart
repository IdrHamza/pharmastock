import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmastock/Screens/Responsablefield/Signin/InputField.dart';
import 'package:pharmastock/Services/Crud.dart';
import 'package:pharmastock/Services/OtherServices.dart';

import '../../../Models/Medicament.dart';
import '../../../Models/supplier.dart';
import 'MedicamentInfo.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final Crud crud = Crud();
  late Stream<List<Medicament>> _medicament;
  TextEditingController name = TextEditingController();
  TextEditingController Datedepreremption = TextEditingController();
  get docid => docid;
  final _formKey = GlobalKey<FormState>();
  Supplier? selectedSupplier;
  List<Supplier> suppliers = [];
  late Stream<int> count;
  others other = others();
  TextEditingController email = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _medicament = crud.getMedicaData();
    count = other.getDemandCollectionCounta("Medicament");
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
      _medicament = crud.getMedicaData();
      count = other.getDemandCollectionCounta("Medicament");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEFF5),
      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: StreamBuilder<List<Medicament>>(
            stream: _medicament,
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
                                  border: Border.all(
                                      color: Colors.teal.withOpacity(0.1),
                                      width: 2.0),
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
                                margin: EdgeInsets.only(
                                    top: 30, bottom: 30, left: 10),
                                child: Center(
                                  child: Text(
                                    "Medicaments",
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width:30,
                          ),
                          StreamBuilder<int>(
                              stream: count,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  int y = snapshot.data!;

                                  return Expanded(
                                    child: Container(
                                        height: 150,
                                        width: 150,
                                        alignment: Alignment.topLeft,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.teal.withOpacity(0.1),
                                              width: 2.0),
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
                                        margin: EdgeInsets.only(
                                            top: 30, bottom: 30, left: 10),
                                        child: Center(
                                          child: Text(
                                            y.toString(),
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                        )),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                return CircularProgressIndicator();
                              }),
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
                                crud.deleteMedicament(data.mid.toString());
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
                                  onDoubleTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        String? id = data.mid;
                                        return Dialog(
                                            backgroundColor: Colors.white70,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Container(
                                                padding: EdgeInsets.zero,
                                                child: Container(
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Text(
                                                                  "Update Information",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .greenAccent))
                                                            ],
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Form(
                                                            key: _formKey,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  child:
                                                                      TextFormField(
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            18),
                                                                    decoration: InputDecoration(
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.green,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                        labelText: "name",
                                                                        labelStyle: TextStyle(color: Colors.green, fontSize: 18),
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(20),
                                                                            borderSide: BorderSide(
                                                                              color: Colors.green,
                                                                              width: 1,
                                                                            )),
                                                                        hintText: data.name),
                                                                    controller:
                                                                        name,
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return "Please enter name";
                                                                      }
                                                                      return null;
                                                                    },
                                                                    onSaved: (value) =>
                                                                        name.text =
                                                                            value.toString(),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  child:
                                                                      TextFormField(
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            18),
                                                                    decoration: InputDecoration(
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.green,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                        labelText: "Date de preremption",
                                                                        labelStyle: TextStyle(color: Colors.green, fontSize: 18),
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(20),
                                                                            borderSide: BorderSide(
                                                                              color: Colors.green,
                                                                              width: 1,
                                                                            )),
                                                                        hintText: data.DatedePreremption),
                                                                    controller:
                                                                        Datedepreremption,
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return "Please enter date de preremption";
                                                                      }
                                                                      return null;
                                                                    },
                                                                    onSaved: (value) =>
                                                                        Datedepreremption.text =
                                                                            value.toString(),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 30),
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    right: 10),
                                                            child: DropdownButtonFormField<
                                                                    Supplier>(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                value:
                                                                    selectedSupplier,
                                                                items: suppliers
                                                                    .map((Supplier
                                                                        supplier) {
                                                                  return DropdownMenuItem<
                                                                      Supplier>(
                                                                    value:
                                                                        supplier,
                                                                    child: Text(
                                                                        supplier
                                                                            .email),
                                                                  );
                                                                }).toList(),
                                                                onChanged:
                                                                    (Supplier?
                                                                        newValue) {
                                                                  setState(() {
                                                                    selectedSupplier =
                                                                        newValue;
                                                                    email.text =
                                                                        newValue?.email ??
                                                                            '';
                                                                  });
                                                                },
                                                                decoration: InputDecoration(
                                                                    labelText:
                                                                        'Select Supplier',
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        borderSide: BorderSide(color: Colors.green)),
                                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.green)),
                                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.green)),
                                                                    labelStyle: TextStyle(color: Colors.green, fontSize: 20)))),
                                                        SizedBox(height: 16.0),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          if (_formKey
                                                                              .currentState!
                                                                              .validate()) {
                                                                            _formKey.currentState!.save();
                                                                            late Medicament medicamentsdata = Medicament(
                                                                                uid: user?.uid,
                                                                                mid: id,
                                                                                name: name.text,
                                                                                DatedePreremption: Datedepreremption.text,
                                                                                supplieremail: selectedSupplier?.email);
                                                                            crud.upadateMedicament(medicamentsdata);

                                                                            Navigator.pop(context);
                                                                          }
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Confirm ",
                                                                        ))),
                                                            Expanded(
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                            "Cancel")))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )));
                                      },
                                    );
                                  },
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MedicamentInfo(mid: data.mid)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      title: Text(snapshot.data![index].name
                                          .toString(),style:  TextStyle(color:Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
                                      trailing: Icon(
                                        Icons.arrow_right_sharp,
                                        color: Colors.white,
                                      ),
                                      leading: Icon(
                                        Icons.local_pharmacy,
                                        color: Colors.white,
                                      ),
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
                        child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                          color: Colors.green,
                                          width: 1,
                                        ),
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: "name",
                                      labelStyle: TextStyle(
                                          color: Colors.green, fontSize: 18),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: Colors.green,
                                            width: 1,
                                          )),
                                    ),
                                    controller: name,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter nom de medicament";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) =>
                                        name.text = value.toString(),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: Colors.green,
                                            width: 1,
                                          ),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: "Date de péremption",
                                        labelStyle: TextStyle(
                                            color: Colors.green, fontSize: 18),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              color: Colors.green,
                                              width: 1,
                                            ))),
                                    controller: Datedepreremption,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter date de preremption";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => Datedepreremption.text =
                                        value.toString(),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide:
                                              BorderSide(color: Colors.green)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide:
                                              BorderSide(color: Colors.green)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide:
                                              BorderSide(color: Colors.green)),
                                      labelStyle: TextStyle(
                                          color: Colors.green, fontSize: 20)))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: TextButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          late Medicament Medicamentdata =
                                              Medicament(
                                                  uid: user?.uid,
                                                  mid: ' ',
                                                  name: name.text,
                                                  DatedePreremption:
                                                      Datedepreremption.text,
                                                  supplieremail:
                                                      selectedSupplier?.email);
                                          crud.addMedicament(Medicamentdata);
                                          Navigator.pop(context);
                                        }
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
                      ),
                    )),
                  ),
                );
              });
        }),
        tooltip: 'add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
