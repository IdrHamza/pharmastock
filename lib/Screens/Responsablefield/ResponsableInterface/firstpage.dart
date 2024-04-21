import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../Typeofaccountbutton/mainforaccount.dart';
import '../../../typeofaccount.dart';
import 'newdashboard.dart';
import 'privacy_policy.dart';
import 'send_feedback.dart';
import 'settings.dart';

import 'Supplier.dart';
import 'dashboard.dart';
import 'Medicaments.dart';
import 'my_drawer_header.dart';
import 'Inventories.dart';
import 'notifications.dart';
import 'DelivredDemand.dart';
import 'ReceivedDemand.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = newdashboard();
    } else if (currentPage == DrawerSections.fournisseurs) {
      container = Supplierpage();
    } else if (currentPage == DrawerSections.medicament) {
      container = EventsPage();
    } else if (currentPage == DrawerSections.Stocks) {
      container = NotesPage();
    }else if (currentPage == DrawerSections.deliverd) {
      container = delivered();
    }
    else if (currentPage == DrawerSections.accepted) {
      container = AcceptedDemand();
    }
    else if (currentPage == DrawerSections.Demands) {
      container = SettingsPage();
    } else if (currentPage == DrawerSections.setting) {
      container = NotificationsPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
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
                MyHeaderDrawer(),
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
          menuItem(2, "fournisseur", Icons.people_alt_outlined,
              currentPage == DrawerSections.fournisseurs ? true : false),
          menuItem(3, "Medicament", Icons.local_pharmacy,
              currentPage == DrawerSections.medicament ? true : false),
          menuItem(4, "Stocks", Icons.inventory,
              currentPage == DrawerSections.Stocks ? true : false),

          menuItem(5, "Demandes", Icons.medical_services,
              currentPage == DrawerSections.Demands ? true : false),
          menuItem(6, "Deliverd Demands", Icons.medical_services,
              currentPage == DrawerSections.deliverd? true : false),
          menuItem(7, "Accepted Demands", Icons.medical_services,
              currentPage == DrawerSections.accepted ? true : false),
          menuItem(8, "Setting", Icons.settings,
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
              currentPage = DrawerSections.fournisseurs;
            } else if (id == 3) {
              currentPage = DrawerSections.medicament;
            } else if (id == 4) {
              currentPage = DrawerSections.Stocks;
            } else if (id == 5) {
              currentPage = DrawerSections.Demands;
            } else if (id == 6) {
              currentPage = DrawerSections.deliverd;
            } else if (id == 7) {
              currentPage = DrawerSections.accepted;
            } else if (id == 8) {
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
  fournisseurs,
  medicament,
  Stocks,
  Demands,
  deliverd,
  accepted,
  setting,

  }
