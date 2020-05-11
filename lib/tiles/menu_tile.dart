import 'package:flutter/material.dart';
import 'package:grupolenotre/datas/filial_data.dart';
import 'package:grupolenotre/screens/filial/updateordelete_filial_screen.dart';

class MenuTile extends StatefulWidget {
  final FilialData filialData;
  MenuTile(this.filialData);
  @override
  _MenuTileState createState() => _MenuTileState(this.filialData);
}

class _MenuTileState extends State<MenuTile> {
  final FilialData filialData;
  _MenuTileState(this.filialData);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=> UpdateOrDeleteFilialScreen(filialData))
          );
        },
        child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Text('Razão Social', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(filialData.razaoSocial == null ? '' : filialData.razaoSocial),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text('Nome Fantasia', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(filialData.nomeFantasia == null ? '' : filialData.nomeFantasia),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text('CNPJ', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 20.0),
                  child: Text(filialData.cnpj == null ? '' : filialData.cnpj),
                ),
              ],
            )
        )
    );
  }
}