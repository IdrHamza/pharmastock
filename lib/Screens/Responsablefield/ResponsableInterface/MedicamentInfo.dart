import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmastock/Models/Medicament.dart';
import 'package:pharmastock/Services/Crud.dart';
class MedicamentInfo extends StatefulWidget {
  late String? mid;
   MedicamentInfo({Key? key, required  this.mid}) : super(key: key);

  @override
  State<MedicamentInfo> createState() => _MedicamentInfoState();
}

class _MedicamentInfoState extends State<MedicamentInfo> {
  @override
  Crud crud = Crud();
  late Future<DocumentSnapshot> doc;
  Medicament? medicament;

  @override
  void initState() {
    super.initState();
    getDataAndTransform();
  }

  void getDataAndTransform() async {
    DocumentSnapshot doc = await crud.getdata("Medicament", widget.mid.toString());
    setState(() {
      medicament = Medicament.fromFirestore(doc);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (medicament == null) {
      // Show a loading indicator or placeholder widget
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFEEEFF5),
      appBar: AppBar(
        title: Text(medicament!.name.toString()),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [ ListTile(contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            title:Text(medicament?.name ?? ''),
          ),ListTile(contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

              title:Text(medicament?.DatedePreremption ?? '')
          ),ListTile(contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),title:Text(medicament?.supplieremail ?? ''))],
        ),
      ),
    );
  }
}
