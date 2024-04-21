import 'package:flutter/material.dart';
import 'package:pharmastock/fournisseur/registre.dart';

import 'login.dart';

void mainlog() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InputtField(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => InputtField(),
    },
  ));
}