import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmastock/page/user_page.dart';
import '../../../Typeofaccountbutton/mainforaccount.dart';
import '../../../typeofaccount.dart';
import 'Dashboard_page.dart';
import 'Drawerheader.dart';
import 'Fournisseur_page.dart';
import 'Medicament_page.dart';
import 'Stock_page.dart';
import 'ajouter_un_fournisseur_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Newdrawer(),
    );
  }
}

class Newdrawer extends StatefulWidget {
  @override
  _NewdrawerState createState() => _NewdrawerState();
}

class _NewdrawerState extends State<Newdrawer> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = Dashboardpage();
    } else if (currentPage == DrawerSections.Pharmacies) {
      container = AjouterunfournisseurPage();
    } else if (currentPage == DrawerSections.Demandes) {
      container = MedicamentsPage();
    } else if (currentPage == DrawerSections.deliverd) {
      container = StocksPage();
    }else if (currentPage == DrawerSections.setting) {
      container = UserPage();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: Text("Pharmastock",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
        actions: [ IconButton(
            icon: Icon(Icons.logout,color: Colors.white,), // Replace with your desired icon
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>typeaccount())));
            }

        ),],
      ),
      body: container,
      drawer: Drawer(

        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawerFournisseurs(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Pharmacies", Icons.people_alt_outlined,
              currentPage == DrawerSections.Pharmacies ? true : false),
          menuItem(3, "Demandes", Icons.medication,
              currentPage == DrawerSections.Demandes ? true : false),
          menuItem(4, "Demandes livrèes", Icons.medication,
              currentPage == DrawerSections.deliverd ? true : false),

          menuItem(5, "Profile", Icons.person,
              currentPage == DrawerSections.setting ? true : false),


          Divider(),

        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.Pharmacies;
            } else if (id == 3) {
              currentPage = DrawerSections.Demandes;
            } else if (id == 4) {
              currentPage = DrawerSections.deliverd;
            } else if (id == 5) {
              currentPage = DrawerSections.setting;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





enum DrawerSections {
  dashboard,
  Pharmacies,
  Demandes,
  deliverd,
  setting,

}
