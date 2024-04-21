import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import'package:firebase_auth/firebase_auth.dart';
import 'package:pharmastock/Models/Pharmacie.dart';
import 'package:pharmastock/Models/Responsible.dart';
import 'package:pharmastock/Screens/Responsablefield/ResponsableInterface/firstpage.dart';
import 'package:pharmastock/Services/Crud.dart';
import'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
class pharma extends StatefulWidget {
  Responsible ResponsibleData;
  String password;
  pharma(this.ResponsibleData,this.password);


  @override
  State<pharma> createState() => _pharmaState();
}

class _pharmaState extends State<pharma> {
  TextEditingController name=TextEditingController();
  TextEditingController adress=TextEditingController();
    Crud crud = Crud();
    String imageUrl='';



   

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
          children: <Widget>[ Container(
      width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.lightGreen,
            Colors.green,
            Colors.greenAccent
          ]),
        ),),
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
                          controller:name,
                          obscureText: false,
                          enableSuggestions: true,
                          autocorrect: true,
                          decoration: InputDecoration(
                              hintText: "Enter Pharmacy's name",
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
                          controller:adress,
                          obscureText: false,
                          enableSuggestions: true,
                          autocorrect: true,
                          decoration: InputDecoration(
                              hintText: "Enter adress",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none
                          ),
                        ),
                      ),



                      
                      
                      SizedBox(height: 40),
                      ElevatedButton(onPressed:()async{
                        UserCredential result=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: widget.ResponsibleData.email, password: widget.password);
                        User? user=result.user;
                        widget.ResponsibleData.uid=user?.uid;
                        if(user!=0){
                          crud.addResponsible(widget.ResponsibleData);
                        Pharmacie pharma=Pharmacie(uid: user?.uid, phid: "", name: name.text, adress: adress.text,fid:'', image: imageUrl);
                        crud.addPharma(pharma);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                        }
    
                        

                      }, child: Text("Signup")
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
      );
  }
}
