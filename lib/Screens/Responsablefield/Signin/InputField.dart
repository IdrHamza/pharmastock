import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmastock/Models/Responsible.dart';

import '../ResponsableInterface/firstpage.dart';


class InputField extends StatefulWidget {
  const InputField({Key? key}) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final FirebaseAuth auth=FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey)
              )
          ),
          child: TextField(
            controller: _email,
            obscureText: false,
            enableSuggestions: true,
            autocorrect: true,
            decoration: InputDecoration(
                hintText: "Entrer votre email",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey)
              )
          ),
          child: TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,

            decoration: InputDecoration(
                hintText: "Entrer votre mot de passe",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none
            ),
          ),
        ),
        SizedBox(height: 40),
    ElevatedButton(onPressed: ()async{
      UserCredential result=await auth.signInWithEmailAndPassword(email: _email.text, password: _password.text);
      User? user=result.user;

      if(result.user!=0){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }


    }, child: Text("Login")

          ),



      ],
    );
  }
}
