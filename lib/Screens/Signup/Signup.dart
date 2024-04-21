import 'package:flutter/material.dart';
import 'package:pharmastock/Screens/Signup/pharma.dart';

import '../../Models/Responsible.dart';
import '../../Services/Crud.dart';




class SignupHome extends StatefulWidget{
  @override
  _SignupHomeState createState() => _SignupHomeState();
}

class _SignupHomeState extends State<SignupHome> {
  final formKey = GlobalKey<FormState>(); //key for form
  String name="";
  Crud crud =Crud();
  TextEditingController fname= TextEditingController();
  TextEditingController lname=TextEditingController();
  TextEditingController birthday=TextEditingController();
  TextEditingController _emails =TextEditingController();
  TextEditingController _passwords =TextEditingController();
  TextEditingController phonenum=TextEditingController();
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
                    Text("Bienvenue à", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
                    Text("Pharmastock!", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
                    SizedBox(height: height*0.05,),

                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Entrez votre nom"
                      ),
                      validator: (value){
                        if(value!.isEmpty ||!RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                          return "entrez votre nom svp";
                        }else{
                          return null;
                        }
                      },
                      controller: lname,
                    ),
                    SizedBox(height: height*0.05,),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Entrez votre prenom"
                      ),
                      validator: (value){
                        if(value!.isEmpty ||!RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                          return "entrez votre Prenom svp";
                        }else{
                          return null;
                        }
                      },
                      controller: fname,
                    ),
                    SizedBox(height: height*0.05,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Entrez votre email",
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
                    SizedBox(height: height * 0.05,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Entrer votre date de naissance",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your birthday";
                        } else {
                          return null;
                        }
                      },
                      controller: birthday,
                    ), SizedBox(height: 40,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Entrer votre mot de passe ",
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
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter your phone number",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a your phone number";
                        } else {
                          return null;
                        }
                      },
                      obscureText: false,
                      controller:phonenum ,
                    ),
                    SizedBox(height: 40,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xff4c505b),
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                if(formKey.currentState!.validate()) {
                                  final snackBar = SnackBar(content: Text('Submitting form'));_scaffoldKey.currentState!;

                                  Responsible ResponsibleData= Responsible(docid:' ',uid:" ",fname: fname.text,lname: lname.text,email:_emails.text,birthday:birthday.text, typeacc: "resp"'', phonenum: phonenum.text);
                                  Navigator.push(context, MaterialPageRoute(builder:(context)=>pharma(ResponsibleData,_passwords.text)));

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