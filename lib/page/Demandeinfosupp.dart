import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import'package:cloud_firestore/cloud_firestore.dart';

import '../Models/DemandSupplier.dart';
import '../Models/Demands.dart';
import '../Services/Crud.dart';
class Demandinfosupp extends StatefulWidget {
  late String? demid;
   Demandinfosupp({Key? key, required this.demid}) : super(key: key);

  @override
  State<Demandinfosupp> createState() => _DemandinfosuppState();
}

class _DemandinfosuppState extends State<Demandinfosupp> {
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
      appBar: AppBar(backgroundColor: Colors.deepPurple,
        title: Text( "Des information sur la demande"),),
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
                              crud.deleteDemand(snapshot.data![index].dfid);
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

                                  child:  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20.0)),
                                      title: Text(snapshot.data![index].name
                                          .toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                                      subtitle:   Text(data.quantity.toString(),style: TextStyle(fontWeight:FontWeight.w500,fontSize: 18,color:Colors.white),),
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

                                )
                            )
                        );
                      });


              }
            },
          ),
        ),
      ),
      
    );
  }
}
