import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmastock/Services/OtherServices.dart';

import '../../../Models/Demands.dart';
import '../../../Models/Pharmacie.dart';
import '../../../Models/supplier.dart';
import '../../../Services/Crud.dart';
import '../../../page/Demandeinfosupp.dart';
import 'Demandinforesp.dart';
class AcceptedDemand extends StatefulWidget {
  const AcceptedDemand({Key? key}) : super(key: key);

  @override
  State<AcceptedDemand> createState() => _AcceptedDemandState();
}

class _AcceptedDemandState extends State<AcceptedDemand> {
  final User? user=FirebaseAuth.instance.currentUser;
  final Crud crud = Crud();
  TextEditingController numstock=TextEditingController();
  late Stream<List<Demands>>_stream;
  late Stream<int>count;
  others other=others();





  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    _stream=crud.getreceivedDemand();
    count=other.getReceivedCount();
  }
  Future<void> _refreshList() async {
    // Fetch new data or update the UI here
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _stream=crud.getreceivedDemand();
      count=other.getReceivedCount();

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
                                    "Demandes reçues",
                                    style: TextStyle(
                                        fontSize: 27, fontWeight: FontWeight.w500,color: Colors.black),
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
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => Demandinforesp(demid:data.demandid)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child:StreamBuilder<Supplier>(
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
                                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white),
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
                                                ),
                                              ),

                                          );
                                        } else if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}');
                                        } else {
                                          return CircularProgressIndicator(); // Display a loading indicator
                                        }
                                      },
                                    )
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
    );}}

