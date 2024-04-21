import 'package:flutter/material.dart';

import '../../../Models/Responsible.dart';
import '../../../Services/Crud.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final formKey = GlobalKey<FormState>(); //key for form
  String name="";
  Crud crud =Crud();
  TextEditingController fname= TextEditingController();
  TextEditingController lname=TextEditingController();
  TextEditingController birthday=TextEditingController();
  TextEditingController _emails =TextEditingController();
  TextEditingController _passwords =TextEditingController();
  late Responsible respo;
  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
    );
  }
}