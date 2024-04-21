import 'package:flutter/material.dart';

import 'Supplier.dart';

class newdashboard extends StatefulWidget {
  const newdashboard({Key? key}) : super(key: key);

  @override
  State<newdashboard> createState() => _newdashboardState();
}

class _newdashboardState extends State<newdashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      body: Column(
        children: [
          SizedBox(height: 50),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEEEFF5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                    padding: const EdgeInsets.all(20), // Add padding to the GridView

                    children: [
                    GestureDetector( onTap: (){Supplierpage();} , child: itemDashboard('Supplier', "assets/image/Supplier.png", Colors.white),),
                      itemDashboard('Medicament', "assets/image/medicamenticon.png", Colors.white),
                      itemDashboard('Inventories', "assets/image/images.png", Colors.white),
                      itemDashboard('Demands', "assets/image/Demands.jpg", Colors.white),
                      itemDashboard('Delivered Demands', "assets/image/fastdelivered.png", Colors.white),
                      itemDashboard('Accepted Demands', "assets/image/receiveddelivery.png", Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemDashboard(String title, String image, Color background) {
    return Container(
      width: 500,
      height: 500,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow:  [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.teal.shade100,
            spreadRadius: 1,
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(

              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 13),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
