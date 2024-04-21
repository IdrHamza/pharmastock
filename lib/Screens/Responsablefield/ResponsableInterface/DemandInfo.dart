import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmastock/Models/DemandSupplier.dart';
import 'package:pharmastock/Models/Demands.dart';
import 'package:pharmastock/Services/OtherServices.dart';

import '../../../Services/Crud.dart';

class DemandInfo extends StatefulWidget {
  late String? demid;
  DemandInfo({Key? key, required this.demid}) : super(key: key);

  @override
  State<DemandInfo> createState() => _DemandInfoState();
}

class _DemandInfoState extends State<DemandInfo> {
  Crud crud = Crud();
  late Future<DocumentSnapshot> doc;
  Demands? demand;
  TextEditingController name = TextEditingController();
  TextEditingController quantity = TextEditingController();
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  late Stream<List<DemSupp>> demsupp;
  final _formKey = GlobalKey<FormState>();
  others other=others();
  var number;

  Demands? demandinfo;
  void initState() {
    super.initState();
    getDataAndTransform();
    demsupp = crud.getDMSP(widget.demid);

  }

  Future<void> _refreshList() async {
    // Fetch new data or update the UI here
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      demsupp = crud.getDMSP(widget.demid);
    });
  }

  @override
  void getDataAndTransform() async {
    DocumentSnapshot doc = await crud.getdata("Demands", widget.demid);
    setState(() {
      demand = Demands.fromFirestore(doc);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator or placeholder widget
    return Scaffold(
      backgroundColor: Color(0xFFEEEFF5),
      appBar: AppBar(title: Text( "Des information sur la demande"),backgroundColor: Colors.teal,),
      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: StreamBuilder<List<DemSupp>>(
            stream: demsupp,
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
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      final docid = data.dfid;
                      return Dismissible(
                        onDismissed: (direction) {
                          if(demand?.statut==' '){
                          crud.deleteDmspData(data.dfid);}
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
                            onTap: () {if(demand?.statut==' ') {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    String? id = data.demandid;
                                    return AlertDialog(
                                        actions: <Widget>[ Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Form(
                                                  key: _formKey, //key for form
                                                  child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: 20),
                                                        Container(
                                                          margin: EdgeInsets.only(left:10,right:10),

                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                color:Theme.of(context).primaryColor ,
                                                                fontWeight:FontWeight.bold ,
                                                                fontSize:18
                                                            ),

                                                            decoration: InputDecoration(
                                                              enabledBorder:OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(20),
                                                                borderSide: BorderSide(color: Colors.green ,width:1,),

                                                              ),floatingLabelBehavior: FloatingLabelBehavior.always,
                                                              labelText: "name",
                                                              hintText: data.name,
                                                              labelStyle: TextStyle(color: Colors.green,fontSize: 18),
                                                              focusedBorder:OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(20),
                                                                  borderSide: BorderSide(color: Colors.green ,width:1,)),
                                                            ),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Enter name ";
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            controller: name,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(margin: EdgeInsets.only(left:10,right:10),

                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                color:Theme.of(context).primaryColor ,
                                                                fontWeight:FontWeight.bold ,
                                                                fontSize:18
                                                            ),

                                                            decoration: InputDecoration(
                                                              enabledBorder:OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(20),
                                                                borderSide: BorderSide(color: Colors.green ,width:1,),

                                                              ),floatingLabelBehavior: FloatingLabelBehavior.always,
                                                              labelText: "quantity",
                                                              hintText: data.quantity,
                                                              labelStyle: TextStyle(color: Colors.green,fontSize: 18),
                                                              focusedBorder:OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(20),
                                                                  borderSide: BorderSide(color: Colors.green ,width:1,)),
                                                            ),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "enter quantity";
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            controller: quantity,
                                                          ),
                                                        ),
                                                      ])),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: <Widget>[
                                                  Expanded(
                                                      child: TextButton(
                                                          onPressed: () async {if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
                                                            DemSupp med = DemSupp(
                                                                demandid: widget
                                                                    .demid
                                                                    .toString(),
                                                                uid: user?.uid,
                                                                dfid: data.dfid,
                                                                name: name.text,
                                                                quantity: quantity
                                                                    .text);

                                                            // The email exists in the Supplier collection
                                                            // Call the function to add the respfourdata
                                                            crud.updateDMSP(
                                                                med);

                                                            Navigator.pop(
                                                                context);}
                                                          },
                                                          child: Text(
                                                            "Confirm ",
                                                          ))),
                                                  Expanded(
                                                      child: TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                              "Cancel")))
                                                ],
                                              )
                                            ]
                                        )
                                        ]
                                    );
                                  })
                              ;
                            } },

                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                title: Text(snapshot.data![index].name.toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
                                subtitle:Text(snapshot.data![index].quantity.toString(),style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500),) ,

                                trailing: Icon(
                                  Icons.arrow_right_sharp,
                                  color: Colors.white,
                                ),
                                leading:Icon(Icons.medical_services,color: Colors.white,) ,
                              ),
                            ),

                        )
    )
    );
              });


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
                        Form(
                            key: _formKey, //key for form
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Container(
                                    margin: EdgeInsets.only(left:10,right:10),

                                    child: TextFormField(
                                      style: TextStyle(
                                          color:Theme.of(context).primaryColor ,
                                          fontWeight:FontWeight.bold ,
                                          fontSize:18
                                      ),

                                      decoration: InputDecoration(
                                        enabledBorder:OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(color: Colors.green ,width:1,),

                                        ),floatingLabelBehavior: FloatingLabelBehavior.always,
                                        labelText: "name",
                                        labelStyle: TextStyle(color: Colors.green,fontSize: 18),
                                        focusedBorder:OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(color: Colors.green ,width:1,)),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter name ";
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: name,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left:10,right:10),

                                    child: TextFormField(
                                      style: TextStyle(
                                          color:Theme.of(context).primaryColor ,
                                          fontWeight:FontWeight.bold ,
                                          fontSize:18
                                      ),

                                      decoration: InputDecoration(
                                        enabledBorder:OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(color: Colors.green ,width:1,),

                                        ),floatingLabelBehavior: FloatingLabelBehavior.always,
                                        labelText: "quantity",
                                        labelStyle: TextStyle(color: Colors.green,fontSize: 18),
                                        focusedBorder:OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(color: Colors.green ,width:1,)),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "enter quantity";
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: quantity,
                                    ),
                                  ),
                                ])),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: TextButton(
                                    onPressed: () async {if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                                      DemSupp med = DemSupp(
                                          demandid: widget.demid.toString(),
                                          uid: user?.uid,
                                          dfid: '',
                                          name: name.text,
                                          quantity: quantity.text);

                                      // The email exists in the Supplier collection
                                      // Call the function to add the respfourdata
                                      crud.addDMSP(med);

                                      Navigator.pop(context);}
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
    );
  }
}
