import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Models/Inventory.dart';
import '../Models/Medicament.dart';
import '../Models/Stock_medicaments.dart';
import '../Services/Crud.dart';
import '../Services/OtherServices.dart';

class invmed extends StatefulWidget {
  final String numstock;
  final String num;

  const invmed({
    Key? key,
    required this.numstock,  required this.num,
  }) : super(key: key);

  @override
  State<invmed> createState() => _invmedState();
}

class _invmedState extends State<invmed> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final Crud crud = Crud();
  late Stream<List<Stockmed>> stockmed;
  final TextEditingController name = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Medicament? mediacament;
  late List<Medicament>medicaments;
  var number;
  others other=others();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stockmed = crud.getStockmedData(widget.numstock);

    fetchData();

  }
  Future<void> fetchData() async {
    List<Medicament> medicamentlist = await crud.retrieveMedicament();
    setState(() {
      medicaments = medicamentlist;

    });
  }

  Future<void> _refreshList() async {
    // Fetch new data or update the UI here
    await Future.delayed(Duration(seconds: 2));
    setState(()async {
      stockmed = crud.getStockmedData(widget.numstock);
      number=await other.calculateTotalQuantity(widget.numstock);

    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
        stream: other.calculateTotalQuantity(widget.numstock),
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            double number = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text("stock numero ${widget.num}")
                ,
                backgroundColor: Colors.teal,
              ),
              body: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child:    Container(
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
                                        "$number",
                                        style: TextStyle(
                                            fontSize: 30, fontWeight: FontWeight.w500,color: Colors.black),
                                      ),
                                    )),
                        ),
                        // Add other widgets in the row if needed
                      ],
                    ),
                  ],
                )
              ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshList,
                    child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: StreamBuilder<List<Stockmed>>(
                      stream: stockmed,
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

                                return Dismissible(
                                  onDismissed: (direction) {},
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
                                      margin: EdgeInsets.only(),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [Color(0xFFB2DF8A), Color(0xFF66BB6A)],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                String? id = data.sid;
                                                return AlertDialog(
                                                  actions: <Widget>[
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        SizedBox(height:20,),
                                                        Form(
                                                            key: _formKey, //key for form
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(height: 20),
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
                                                            )])) ,SizedBox(height: 20), Container(margin: EdgeInsets.only(left: 10,right: 10),
                                                              child: DropdownButtonFormField<Medicament>(
                                                          value: mediacament,
                                                          items: medicaments.map((Medicament med) {
                                                              return DropdownMenuItem<Medicament>(
                                                                value: med,
                                                                child: Text(med.name.toString()),
                                                              );
                                                          }).toList(),
                                                          onChanged: (Medicament? newValue) {
                                                              setState(() {
                                                                mediacament = newValue;
                                                              });
                                                          },
                                                                  decoration: InputDecoration(
                                                                      labelText: 'Select Mediacment',
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(20),
                                                                          borderSide: BorderSide(
                                                                              color: Colors.green
                                                                          )


                                                                      ),
                                                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                      enabledBorder:OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(20),
                                                                          borderSide: BorderSide(
                                                                              color: Colors.green
                                                                          ) ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(20),
                                                                          borderSide: BorderSide(
                                                                              color: Colors.green
                                                                          )

                                                                      ),labelStyle: TextStyle(color: Colors.green,fontSize: 20)
                                                                  )),
                                                            ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: TextButton(
                                                                    onPressed: () async {
                                                                      if (_formKey
                                                                          .currentState!
                                                                          .validate()) {
                                                                        _formKey
                                                                            .currentState!
                                                                            .save();
                                                                        late Stockmed
                                                                            stockmeddata =
                                                                            Stockmed(
                                                                                sid: id,
                                                                                invenid:
                                                                                    widget
                                                                                        .numstock,
                                                                                quantity:
                                                                                    quantity
                                                                                        .text,
                                                                                medicament:
                                                                                mediacament?.name);
                                                                        crud.upadatStockmed(
                                                                            stockmeddata);

                                                                        Navigator.pop(
                                                                            context);
                                                                      }
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
                                                                    child:
                                                                        Text("Cancel")))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:Colors.teal,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: ListTile(
                                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

                                              title: Text(snapshot.data![index].medicament.toString(),style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color:Colors.white),),
                                              subtitle:
                                                  Text(data.quantity,style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color:Colors.white),),
                                              trailing: Icon(
                                                Icons.arrow_right_sharp,
                                                color: Colors.white,
                                              ),
                                              leading: Icon(Icons.medical_information,color: Colors.white,),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                        }
                      },
                    ),
                      ),
                  ),
                ),
              ],
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
                          ) ])), SizedBox(height: 20,), Container(margin: EdgeInsets.only(left: 10,right: 10),
                            child: DropdownButtonFormField<Medicament>(
                              value: mediacament,
                              items: medicaments.map((Medicament med) {
                                return DropdownMenuItem<Medicament>(
                                  value: med,
                                  child: Text(med.name.toString()),
                                );
                              }).toList(),
                              onChanged: (Medicament? newValue) {
                                setState(() {
                                  mediacament = newValue;
                                });
                              },
                            decoration: InputDecoration(
                                labelText: 'Select Medicament',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.green
                                    )


                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                enabledBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.green
                                    ) ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.green
                                    )

                                ),labelStyle: TextStyle(color: Colors.green,fontSize: 20)
                            )),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();

                                          late final Stockmed stockmeddata =
                                              Stockmed(
                                                  sid: " ",
                                                  invenid: widget.numstock,
                                                  quantity: quantity.text,
                                                  medicament: mediacament?.name);

                                          crud.addStockmed(stockmeddata);
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
    }});
  }
}
