import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmastock/Models/Pharmacie.dart';
import 'package:pharmastock/Services/OtherServices.dart';
import 'package:pharmastock/widget/button_widget.dart';

import '../Models/Demands.dart';
import '../Screens/Responsablefield/ResponsableInterface/DemandInfo.dart';
import '../Services/Crud.dart';
import 'Demandeinfosupp.dart';

class StocksPage extends StatefulWidget {
  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final User? user = FirebaseAuth.instance.currentUser;
  final Crud crud = Crud();
  TextEditingController numstock = TextEditingController();
  late Stream<List<Demands>> _stream;
  others other = others();
  var pharma;
  var count;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = crud.getfourDemandsacc();
    count = other.getDeliveredCountfour();
  }

  Future<void> _refreshList() async {
    // Fetch new data or update the UI here
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _stream = crud.getfourDemandsacc();
      count = other.getDeliveredCountfour();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: RefreshIndicator(
            onRefresh: _refreshList,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: StreamBuilder<List<Demands>>(
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
                                          border: Border.all(
                                              color: Colors.deepPurple
                                                  .withOpacity(0.1),
                                              width: 2.0),
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.deepPurple.shade100,
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
                                            "Demandes livrées",
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 30,
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
                                                      color: Colors.deepPurple
                                                          .withOpacity(0.1),
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20.0,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors
                                                          .deepPurple.shade100,
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                margin: EdgeInsets.only(
                                                    top: 30,
                                                    bottom: 30,
                                                    left: 10),
                                                child: Center(
                                                  child: Text(
                                                    y.toString(),
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                )),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
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

                                      pharma =
                                          crud.getDocument(data.uid.toString());
                                      print(data.uid);

                                      return Dismissible(
                                        onDismissed: (direction) {
                                        },
                                        key: Key(UniqueKey().toString()),
                                        background: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Icon(Icons.delete,
                                              color: Colors.white),
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(right: 10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Demandinfosupp(
                                                              demid: data
                                                                  .demandid)));
                                            },
                                            child: StreamBuilder<
                                                DocumentSnapshot<
                                                    Map<String, dynamic>>>(
                                              stream:
                                                  crud.getDocument(data.uid),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          DocumentSnapshot<
                                                              Map<String,
                                                                  dynamic>>>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return CircularProgressIndicator(); // Show a loading indicator while fetching data
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                } else {
                                                  DocumentSnapshot<
                                                          Map<String, dynamic>>
                                                      docSnapshot =
                                                      snapshot.data!;
                                                  String name = docSnapshot
                                                      .data()!['name']
                                                      .toString();
                                                  String image = docSnapshot
                                                      .data()!['image']
                                                      .toString();

                                                  Pharmacie pharmacie =
                                                      Pharmacie.fromFirestore(
                                                          docSnapshot);

                                                  return Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.deepPurple,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: ListTile(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          10),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          title: Text(
                                                            name,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          trailing: Icon(
                                                            Icons
                                                                .arrow_right_sharp,
                                                            color: Colors.white,
                                                          ),
                                                          leading:  Icon(Icons.local_pharmacy,color: Colors.white,)),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          );
                      }
                    }))));
  }
}
