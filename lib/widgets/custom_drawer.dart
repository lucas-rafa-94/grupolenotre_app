import 'package:flutter/material.dart';
import 'package:grupolenotre/models/user_model.dart';
import 'package:grupolenotre/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';


class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 96, 194, 208),
              Color.fromARGB(255, 96, 194, 208),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
      ),
    );

   return ScopedModelDescendant<UserModel>(
       builder: (context, child, model){
         return Drawer(
           child: Stack(
             children: <Widget>[
               _buildDrawerBack(),
               ListView(
                 padding: EdgeInsets.only(left: 32.0, top: 16.0),
                 children: <Widget>[
                   Container(
                     margin: EdgeInsets.only(bottom: 8.0),
                     padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                     height: 170.0,
                     child: Stack(
                       children: <Widget>[
                         Positioned(
                           top: 30.0,
                           left: 180.0,
                           child: Image(
                               height: 50.0,
                               image: AssetImage('assets/images/logo-simbolo.png')
                           ),
                         ),
                         Positioned(
                           top: 24.0,
                           left: 0.0,
                           child: Text("GRUPO", style: TextStyle(fontSize: 8.0, color: Colors.white, fontWeight: FontWeight.bold)),
                         ),
                         Positioned(
                           top: 30.0,
                           left: 0.0,
                           child: Text("LE", style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold)),
                         ),
                         Positioned(
                           top: 60.0,
                           left: 0.0,
                           child: Text("NÔTRE", style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold)),
                         ),
                         Positioned(
                           top: 120.0,
                           left: 0.0,
                           child: Text("Olá, ${model.userName}", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold)),
                         )
                       ],
                     ),
                   ),
                   Divider( color: Colors.transparent),
                   DrawerTile(Icons.home, "Início", pageController, 0),
                   DrawerTile(Icons.business, "Filiais", pageController, 1),
                   DrawerTile(Icons.person, "Relatório Diário", pageController, 2)
                 ],
               )
             ],
           ),
         );
       }
   );

  }
}
