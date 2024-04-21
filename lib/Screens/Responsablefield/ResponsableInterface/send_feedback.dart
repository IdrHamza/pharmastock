import 'package:flutter/material.dart';
import'package:firebase_auth/firebase_auth.dart';

import '../../../typeofaccount.dart';

class SendFeedbackPage extends StatefulWidget {
  @override
  _SendFeedbackPageState createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children:<Widget> [
            TextButton(onPressed: (){
              FirebaseAuth.instance.signOut().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>types())));
            }, child: Text("Signout"))
          ],
        )
      ),
    );
  }
}