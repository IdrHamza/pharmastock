import 'package:flutter/material.dart';

class Dashboardpage extends StatefulWidget {
  @override
  State<Dashboardpage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<Dashboardpage> {
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
                      itemDashboard('Pharmacies', "assets/image/logo2.png", Colors.white),
                      itemDashboard('Demands', "assets/image/Demands.jpg", Colors.white),
                      itemDashboard('Demandes   Livrées', "assets/image/fastdelivered.png", Colors.white),
                      itemDashboard('Profile', "assets/image/profile.png", Colors.white),

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
            color: Colors.deepPurple.shade100,
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
} }
