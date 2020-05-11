import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grupolenotre/datas/relatorio_data.dart';
import 'package:grupolenotre/models/user_model.dart';
import 'package:grupolenotre/screens/relatorio/insert_relatorio_screen.dart';
import 'package:grupolenotre/screens/relatorio/updateordelete_relatorio_screen.dart';
import 'package:scoped_model/scoped_model.dart';



class RelatorioTile extends StatefulWidget {
  RelatorioData relatorioData;
  RelatorioTile(this.relatorioData);

  @override
  _RelatorioTileState createState() => _RelatorioTileState(this.relatorioData);
}

class _RelatorioTileState extends State<RelatorioTile> {
  RelatorioData relatorioData;
  _RelatorioTileState(this.relatorioData);

  Future<void> _onSuccess() async {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=> UpdateOrDeleteRelatorioScreen(this.relatorioData))
    );
  }


  Future<void> _onFailure() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Aviso'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Erro ao criar a filial!'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void getData(model){
    model.clear();
    model.getDataApi(
        cs: this.relatorioData.cs,
        onSuccess: _onSuccess,
        onFailure: _onFailure
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      if (model.isLoading) return Center(child: CircularProgressIndicator());
      return GestureDetector(
        onTap: (){
          getData(model);
        },
        child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Text('Data', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(relatorioData.data == null ? '' : relatorioData.data),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text('Operador', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(relatorioData.operador == null ? '' : relatorioData.operador),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text('Check in', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
                  child: Text(relatorioData.horarioInicial == null ? '' : relatorioData.horarioInicial),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text('Check out', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
                  child: Text(relatorioData.horarioFinal == null ? '' : relatorioData.horarioFinal),
                ),
              ],
            )
        ),
      );
    });
  }
}

