import 'package:flutter/material.dart';

import 'bienvenu.dart';

void main() {
  runApp(typeaccount());
}

class typeaccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharmastock app',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}