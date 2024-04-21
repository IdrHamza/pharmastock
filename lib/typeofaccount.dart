import 'package:flutter/material.dart';

import 'Screens/Responsablefield/Signin/login.dart';
import 'Screens/Signup/Signupfour.dart';
import 'firstfourpage.dart';
import 'fournisseur/login.dart';
class types extends StatefulWidget {
  const types({Key? key}) : super(key: key);

  @override
  State<types> createState() => _typesState();
}

class _typesState extends State<types> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton.extended(onPressed: (){Navigator.push
            (context, MaterialPageRoute(builder: (context)=>loginp() ));},
              label: Text("Rsponsable"),
            backgroundColor: Colors.greenAccent,
              icon:Icon(Icons.local_pharmacy)),
          SizedBox(height:30),
          FloatingActionButton.extended(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>InputtField() ));}, label: Text("Supplier"),
              backgroundColor: Colors.greenAccent,
              icon:Icon(Icons.person_off)),

        ],
      ))
    );
  }
}
