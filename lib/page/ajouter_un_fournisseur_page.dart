import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmastock/Models/fourresp.dart';
import 'package:pharmastock/Services/OtherServices.dart';

import '../Models/Pharmacie.dart';
import '../Models/Respfour.dart';
import '../Models/supplier.dart';
import '../Services/Crud.dart';
class AjouterunfournisseurPage extends StatefulWidget {
  const AjouterunfournisseurPage({Key? key}) : super(key: key);

  @override
  State<AjouterunfournisseurPage> createState() => _AjouterunfournisseurPageState();
}

class _AjouterunfournisseurPageState extends State<AjouterunfournisseurPage> {
  final  db = FirebaseFirestore.instance;
  final FirebaseAuth auth=FirebaseAuth.instance;
  final User? user=FirebaseAuth.instance.currentUser;
  final Crud crud = Crud();
  var count;
  others other=others();

  late Stream<List<Fourresp>> respfour;
  TextEditingController _email=TextEditingController();
    late Future <List<Pharmacie>> pharmacie;

  List<Pharmacie> pharmalist  = [];

  Pharmacie? selectedpharmacie;
  TextEditingController statut=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email=TextEditingController();
    respfour = crud.getFourrespData();
    fetchData();
    Pharmacie? selectedSupplier;
    List<Pharmacie> pharm = [];


  }
  Future<void> fetchData() async {
    List<Pharmacie> pharma = await crud.getPharmacielist();
    setState(() {
      pharmalist  = pharma;
      count=other.getfourresp();
    });
  }

  Future<void> _refreshList() async {
    // Fetch new data or update the UI here
    await Future.delayed(Duration(seconds: 2));
    setState(() {

      respfour = crud.getFourrespData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: RefreshIndicator(
        onRefresh:_refreshList ,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: StreamBuilder<List<Fourresp>>(
            stream: respfour,
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
                                    "Pharmacies",
                                    style: TextStyle(
                                        fontSize: 25, fontWeight: FontWeight.w500,color: Colors.black),
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
                            final data=snapshot.data![index];
                            final fid=data.fid;
                            final docid=data.fid;
                            return Dismissible(
                              onDismissed: (direction){
                                crud.deletedeFourresp(data.fourrespid);




                              },
                              key:Key(UniqueKey().toString() )  ,
                              background: Container(
                                decoration: BoxDecoration( color:Colors.red,
                                  borderRadius:BorderRadius.circular(8.0),
                                ),child:Icon(Icons.delete,color: Colors.white,),
                                alignment: Alignment.centerRight,

                                padding: EdgeInsets.only(right: 10),),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:StreamBuilder<
                                    DocumentSnapshot<Map<String, dynamic>>>(
                                  stream: crud.getDocument(data.email),
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
                                          leading: Icon(Icons.local_pharmacy,color: Colors.white,),),
                                        );

                                    }
                                  },
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
      floatingActionButton:FloatingActionButton(
        onPressed: (() {showDialog(context: context, builder: (BuildContext context){
          return Center(
            child: SingleChildScrollView(

              child: Dialog(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(height: 30,),
              DropdownButtonFormField<Pharmacie>(
                value: selectedpharmacie,
                items: pharmalist.map<DropdownMenuItem<Pharmacie>>((Pharmacie pharmaciedata) {
                  return DropdownMenuItem<Pharmacie>(
                    value: pharmaciedata,
                    child: Text(pharmaciedata.name),
                  );
                }).toList(),
                onChanged: (Pharmacie? newValue) {
                  setState(() {
                    selectedpharmacie = newValue;
                  });
                },

                        decoration: InputDecoration(
                          labelText: 'Select Supplier',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(child: TextButton(onPressed: ()async {
                            String email=_email.text;
                            final  snackbar=SnackBar(content: Text("Pas d'utilisateur "));
                            Fourresp respfourdata=Fourresp(fourrespid: '',  fid: user!.uid, email:  selectedpharmacie!.uid.toString());













                              await crud.addFourresp(respfourdata);




                            Navigator.pop(context);











                          }, child: Text("Confirm ",))),

                          Expanded(child: TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child:  Text("Cancel")))
                        ],
                      )



                    ],
                  )

              ),
            ),
          );

        });}),
        tooltip: 'add',
        child: const Icon(Icons.add),
      ),


    );
  }
}
