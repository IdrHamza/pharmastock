import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmastock/Services/OtherServices.dart';
class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
  others other=others();
  Future<int> stock=other.getDemandCollectionCount("Inventory");
  Future<int> Demand=other.getDemandCollectionCount("Demands");
  Future<int> Medicament=other.getDemandCollectionCount("Medicament");
  Future<int> Fournisseur=other.getDemandCollectionCount("Respfour");


    return Container(
      child: Center(
        child: Column(
          children: [
            FutureBuilder<int>(
              future: stock,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                int stockCount = snapshot.data ?? 0;
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 100,
                    child: Center(
                      child: Text(
                        'Le nombre des Stock: $stockCount',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            FutureBuilder<int>(
              future: Medicament,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                int medicamentCount = snapshot.data ?? 0;
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 100,
                    child: Center(
                      child: Text(
                        'Le nombre des médicaments ajoutés: $medicamentCount',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            FutureBuilder<int>(
              future: Demand,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                int demandCount = snapshot.data ?? 0;
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 100,
                    child: Center(
                      child: Text(
                        'Le nombre des demandes est: $demandCount',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            FutureBuilder<int>(
              future: Fournisseur,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                int fournisseurCount = snapshot.data ?? 0;
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 100,
                    child: Center(
                      child: Text(
                        'Le nombre des fournisseurs ajoutés: $fournisseurCount',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}