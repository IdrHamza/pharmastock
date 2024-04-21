import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmastock/Services/OtherServices.dart';

import '../../../Models/Inventory.dart';
import '../../../Services/Crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../forms/invmed.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final Crud crud = Crud();
  TextEditingController numstock = TextEditingController();
  late Stream<List<Inventory>> _stream;
  final _formKey = GlobalKey<FormState>();
  late Stream<int>count;
  others other=others();
  String? _validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? _validateNumStock(String value) {
    if (value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = crud.getData();
    count=other.getDemandCollectionCounta("Inventory");
  }

  Future<void> _refreshList() async {
    // Fetch new data or update the UI here
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _stream = crud.getData();
      count=other.getDemandCollectionCounta("Inventory");

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
          child: StreamBuilder<List<Inventory>>(
            stream: _stream,
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
                                  child: Text(
                                    "Stocks",
                                    style: TextStyle(
                                        fontSize: 30, fontWeight: FontWeight.w500,color: Colors.black),
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
                            return Dismissible(
                              onDismissed: (direction) {
                                crud.deleteInventory(data.Invenid);
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
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: GestureDetector(
                                    onDoubleTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          String? id = data.Invenid;
                                          return AlertDialog(
                                            actions: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child:
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
                                                          labelText: "name",
                                                          labelStyle: TextStyle(color: Colors.green,fontSize: 18),
                                                          focusedBorder:OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(20),
                                                              borderSide: BorderSide(color: Colors.green ,width:1,)),
                                                        ),
                                                  ),)),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Expanded(
                                                          child: TextButton(
                                                              onPressed: () async {
                                                                late Inventory
                                                                    invendata =
                                                                    Inventory(
                                                                        uid:
                                                                            user?.uid,
                                                                        Invenid: id,
                                                                        numstock:
                                                                            numstock
                                                                                .text);
                                                                crud.upadateInventory(
                                                                    invendata);

                                                                Navigator.pop(
                                                                    context);
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
                                                              child: Text("Cancel")))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => invmed(
                                              numstock:
                                                  snapshot.data![index].Invenid,num: snapshot.data![index].numstock)));
                                    },
                                    child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),),
                                      title: Center(child: Text(snapshot.data![index].numstock,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                                      leading: Icon(Icons.inventory,color: Colors.white,),

                                      trailing: Icon(
                                        Icons.arrow_right_sharp,
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
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: Form(
                              key: _formKey,
                              child:
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
                                    labelText: "numero",
                                    labelStyle: TextStyle(color: Colors.green,fontSize: 18),
                                    focusedBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(color: Colors.green ,width:1,)),
                                  ),
                                controller: numstock,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter numero de stock";
                                  }
                                  return null;
                                },
                                onSaved: (value) =>
                                    numstock.text = value.toString(),
                              ),)
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                        print('Form data:');
                                        print('Num Stock: ${numstock.text}');

                                        // Perform the desired actions with the form data
                                        late Inventory Inventorydata =
                                            Inventory(
                                          uid: user?.uid,
                                          Invenid: "",
                                          numstock: numstock.text,
                                        );
                                        crud.addinventory(Inventorydata);

                                        // Navigate back or perform any other actions
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text("Confirm"))),
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
