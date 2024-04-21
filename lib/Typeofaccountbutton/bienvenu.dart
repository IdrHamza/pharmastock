import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Screens/Responsablefield/Signin/Newsignin.dart';
import '../Screens/Responsablefield/Signin/login.dart';
import '../fournisseur/login.dart';
import '../my_button.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFEEEFF5),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  child:Image.asset("assets/image/logo2.png")
                ),
                Text(
                  'Pharmastock',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff171818),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            FloatingActionButton.extended(onPressed: (){Navigator.push
              (context, MaterialPageRoute(builder: (context)=>Newsignin() ));},
                label: Text("Responsable"),
                backgroundColor: Colors.teal,
                icon:Icon(Icons.local_pharmacy)),
            SizedBox(height:30),
            FloatingActionButton.extended(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>InputtField() ));}, label: Text("Fournisseur"),
                backgroundColor: Colors.deepPurple,
                icon:Icon(Icons.person_off)),
          ],
        ),
      ),
    );
  }
}