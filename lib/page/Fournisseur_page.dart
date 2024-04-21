import 'package:flutter/material.dart';
import 'package:pharmastock/widget/button_widget.dart';
import 'package:pharmastock/page/ajouter_un_fournisseur_page.dart';
import 'package:pharmastock/page/Editer_un_fournisseur_page.dart';

class FournisseurPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
          title: Text('Fournisseurs'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
    body: Column(
      children: [
        SizedBox(height: 16,),
          ElevatedButton.icon(
            onPressed: () => selectedItem(context, 0),
             label: const Text('Ajouter une Pharmacie'),
            icon: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              textStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              elevation: 20,
              shadowColor: Colors.black,

              fixedSize: Size(1000, 100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
              )
            ),
          ),
        SizedBox(height: 16,),
        ElevatedButton.icon(
          onPressed: () => selectedItem(context, 1),
          label: const Text('Editer une Pharmacie'),
          icon: const Icon(Icons.edit),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              textStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              elevation: 20,
              shadowColor: Colors.black,

              fixedSize: Size(1000, 100),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
              )
          ),
        ),
        ]




    ),
    );

}
void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();

  switch (index) {
    case 0:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AjouterunfournisseurPage(),
      ));
      break;
    case 1:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditerunfournisseurPage(),
      ));
      break;

}
}



