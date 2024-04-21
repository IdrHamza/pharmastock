import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmastock/Models/Responsible.dart';
import 'package:pharmastock/Screens/Signup/pharma.dart';
import 'package:pharmastock/Services/Crud.dart';


import '../Responsablefield/ResponsableInterface/firstpage.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Crud crud =Crud();
  TextEditingController fname= TextEditingController();
  TextEditingController lname=TextEditingController();
  TextEditingController birthday=TextEditingController();
  TextEditingController _emails =TextEditingController();
  TextEditingController _passwords =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.lightGreen,
            Colors.green,
            Colors.greenAccent
          ]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 80,),
        Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text("Sign in", style: TextStyle(color: Colors.white, fontSize: 40),),
            ),
            SizedBox(height: 10,),
            Center(
              child: Text("Welcome to Pharmastock", style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey)
                  )
              ),
              child: TextField(
                controller:fname,
                obscureText: false,
                enableSuggestions: true,
                autocorrect: true,
                decoration: InputDecoration(
                    hintText: "Enter your first name",
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
                controller:lname,
                obscureText: false,
                enableSuggestions: true,
                autocorrect: true,
                decoration: InputDecoration(
                    hintText: "Enter your last name",
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
                controller:birthday,
                obscureText: false,
                enableSuggestions: true,
                autocorrect: true,
                decoration: InputDecoration(
                    hintText: "Enter your birthday",
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
                controller:_emails,
                obscureText: false,
                enableSuggestions: true,
                autocorrect: true,
                decoration: InputDecoration(
                    hintText: "Enter your email",
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
                controller:_passwords,
                obscureText:  true,
                enableSuggestions: false,
                autocorrect: false,

                decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none
                ),
              ),
            ),
            SizedBox(height: 40),
          ElevatedButton(onPressed:(){

              Responsible ResponsibleData= Responsible(docid:' ',uid:" ",fname: fname.text,lname: lname.text,email:_emails.text,birthday:birthday.text, typeacc: '', phonenum: '');
              Navigator.push(context, MaterialPageRoute(builder:(context)=>pharma(ResponsibleData,_passwords.text)));

          }, child: Text("Next")
          )


          ],
        )


          ],
        ),
      )
            ,
            Expanded(child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )
              ),
            ))
          ],
        ),
      ),
    );
  }
}
