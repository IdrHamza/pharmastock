import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Signup/SignUpScreen.dart';
import '../../Signup/Signup.dart';
import 'InputField.dart';

class InputWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: InputField(),
            ),


            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Vous n'avez pas encore de compte ? ",
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupHome()));}, child: Text("SignUp"))

              ],
            ),
          ],
        ),
      ),
    );
  }
}