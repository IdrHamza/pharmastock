import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmastock/Models/DemandSupplier.dart';
import 'package:pharmastock/Models/Demands.dart';
import 'package:pharmastock/Models/Pharmacie.dart';
import 'package:pharmastock/Services/OtherServices.dart';
import 'package:pharmastock/page/Demandeinfosupp.dart';
import 'package:pharmastock/widget/button_widget.dart';

import '../Models/Inventory.dart';
import '../Services/Crud.dart';
import '../forms/invmed.dart';

class MedicamentsPage extends StatefulWidget {
  const MedicamentsPage({Key? key}) : super(key: key);

  @override
  State<MedicamentsPage> createState() => _MedicamentsPageState();
}

class _MedicamentsPageState extends State<MedicamentsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final Crud crud = Crud();
  TextEditingController numstock = TextEditingController();
  late Stream<List<Demands>> _stream;
  var pharma;
  var count;
  others other=others();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = crud.getfourDemands();
    count= other.getfournisseursDemand();
  }

  Future<void> _refreshList() async {
    // Fetch new data or update the UI here
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _stream = crud.getfourDemands();
      count= other.getfournisseursDemand();
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
                                  border: Border.all(color: Colors.deepPurple.withOpacity(0.1), width: 2.0),
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
                                margin:
                                EdgeInsets.only(top: 30, bottom: 30, left: 10),
                                child: Center(
                                  child: Text(
                                    "Demands",
                                    style: TextStyle(
                                        fontSize: 30, fontWeight: FontWeight.w500,color: Colors.black),
                                  ),
                                )),
                          ),SizedBox(width: 50,),
                          StreamBuilder<int>(
                              stream: count,
                              builder: (context, snapshot) {

                                if(snapshot.hasData){
                                  int y=snapshot.data!;

                                  return Expanded(
                                    child: Expanded(
                                      child: Container(
                                          height: 150,
                                          width: 150,
                                          alignment: Alignment.topLeft,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: Colors.deepPurple.withOpacity(0.1), width: 2.0),
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
                                          margin:
                                          EdgeInsets.only(top: 30, bottom: 30, left: 10),
                                          child: Center(
                                            child: Text(
                                              y.toString(),
                                              style: TextStyle(
                                                  fontSize: 30, fontWeight: FontWeight.w500,color: Colors.black),
                                            ),
                                          )),
                                    ),
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
                                data.email = '';
                                crud.upadateDemand(data);
                              },
                              key: Key(UniqueKey().toString()),
                              background: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Icon(Icons.delete, color: Colors.white),
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            Demandinfosupp(demid: data.demandid)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.deepPurple,
                                      border: Border.all(
                                        color: Colors
                                            .grey, // Set the color of the border line
                                        width: 2.0,
                                        // Set the width of the border line
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        StreamBuilder<
                                            DocumentSnapshot<Map<String, dynamic>>>(
                                          stream: crud.getDocument(data.uid),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<
                                                      DocumentSnapshot<
                                                          Map<String, dynamic>>>
                                                  snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator(); // Show a loading indicator while fetching data
                                            } else if (snapshot.hasError) {
                                              return Text('Error: ${snapshot.error}');
                                            } else {
                                              DocumentSnapshot<Map<String, dynamic>>
                                                  docSnapshot = snapshot.data!;
                                              String name = docSnapshot
                                                  .data()!['name']
                                                  .toString();
                                              String image=docSnapshot
                                                  .data()!['image']
                                                  .toString();
                                              Pharmacie pharmacie =
                                                  Pharmacie.fromFirestore(
                                                      docSnapshot);

                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurple,
                                                  borderRadius:
                                                      BorderRadius.circular(20.0),
                                                ),
                                                child: ListTile(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 10),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  title: Text(
                                                    name,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white),
                                                  ),
                                                  trailing: Icon(
                                                    Icons.arrow_right_sharp,
                                                    color: Colors.white,
                                                  ),
                                                  leading: Icon(Icons.local_pharmacy,color: Colors.white,),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .white, // Set the desired color here
                                                ),
                                                onPressed: () {
                                                  data.statut = 'Delivred';
                                                  data.deliverydate =
                                                      DateTime.now().toString();
                                                  crud.upadateDemand(
                                                      data); // Add your logic for the Confirm button here
                                                },
                                                child: Text(
                                                  'Confirm',
                                                  style: TextStyle(
                                                      color: Colors.deepPurple),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .white, // Set the desired color here
                                                ),
                                                onPressed: () {
                                                 crud.deleteDemand(data.demandid); // Add your logic for the Decline button here
                                                },
                                                child: Text(
                                                  'Decline',
                                                  style: TextStyle(
                                                      color: Colors.deepPurple),
                                                ),
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
    );
    ;
  }
}
