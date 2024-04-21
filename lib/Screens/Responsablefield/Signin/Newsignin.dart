import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmastock/Models/supplier.dart';

import '../../../Services/Crud.dart';
import '../../Signup/Signup.dart';
import '../ResponsableInterface/firstpage.dart';


class Newsignin extends StatefulWidget {
  const Newsignin({super.key});

  @override
  _NewsigninState createState() => _NewsigninState();
}

class _NewsigninState extends State<Newsignin> {
  final formKey = GlobalKey<FormState>(); //key for form
  String name="";
  Crud crud =Crud();
  TextEditingController fname= TextEditingController();
  TextEditingController lname=TextEditingController();
  TextEditingController birthday=TextEditingController();
  TextEditingController _emails =TextEditingController();
  TextEditingController _passwords =TextEditingController();
  final FirebaseAuth auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFFffffff),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Form(
              key: formKey, //key for form
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:height*0.04),
                  Text("Welcome To", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
                  Text("Pharmastock!", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
                  SizedBox(height: height*0.05,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Enter your email",
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                    controller: _emails,
                  ),

                  SizedBox(height: 40,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Enter your password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return "Please enter a password with at least 6 characters";
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    controller: _passwords,
                  ),
                  SizedBox(height: 40,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupHome()));
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xff4c505b),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () async {
                            if(formKey.currentState!.validate())  {
                              final snackBar = SnackBar(content: Text('Submitting form'));_scaffoldKey.currentState!;

                              UserCredential result=await auth.signInWithEmailAndPassword(email: _emails.text, password: _passwords.text);
                              User? user=result.user;

                              if(result.user!=0){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                              }

                            }
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }



}

