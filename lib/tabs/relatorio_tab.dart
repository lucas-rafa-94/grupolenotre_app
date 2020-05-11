import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grupolenotre/api/relatorio_api.dart';
import 'package:grupolenotre/datas/relatorio_data.dart';
import 'package:grupolenotre/models/user_model.dart';
import 'package:grupolenotre/screens/relatorio/insert_relatorio_screen.dart';
import 'package:grupolenotre/screens/relatorio/updateordelete_relatorio_screen.dart';
import 'package:grupolenotre/tiles/relatorio_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class RelatorioTab extends StatefulWidget {
  @override
  _RelatorioTabState createState() => _RelatorioTabState();
}

class _RelatorioTabState extends State<RelatorioTab> {


  Future<void> _onSuccessCreate() async {

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=> InserRelatorioScreen())
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

  void getDataCreate(model){

    model.getDataCreate(
        onSuccess: _onSuccessCreate,
        onFailure: _onFailure
    );
  }

  @override
  Widget build(BuildContext context) {
    RelatorioApi relatorioApi = new RelatorioApi();

    List<dynamic> _toList (String  str){
      List map = json.decode(str)['registros'];
      RelatorioData f = RelatorioData.fromMap(map[0]);
      return map;
    }

    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
    );
    return ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return Container(
            child: Column(
              children: <Widget>[
                Divider(
                  height: 10.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50.0,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(0.0),
                          side: BorderSide(color: Color(0xffD77E67)),
                        ),
                        color: Color(0xffD77E67),
                        onPressed: () {
                          getDataCreate(model);
                        },
                        textColor: Colors.white,
                        child: Text("Adicionar Relatótio Diário",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 12)),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onTap: () {
                      print("teste");
                    },
//              onChanged: (){},
//              controller: editingController,
                    decoration: InputDecoration(
                      labelText: "Encontre um relatório",
                      hintText: "Relatório Diário",
                      prefixIcon: Icon(Icons.search, color: Color(0xffD77E67)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child:  FutureBuilder<String>(
                      future: relatorioApi.makeGetAllRequest(model.token),
                      builder: (context, snapshot){
                        if(snapshot.hasError)
                          return Text("Não encontrado nenhum relatório :/");
                        if(!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        return ListView.builder(
                            padding: EdgeInsets.only(top: 0.0),
                            itemCount: _toList(snapshot.data).length,
                            itemBuilder: (context, index) {
                              return RelatorioTile(RelatorioData.fromMap(json.decode(snapshot.data)['registros'][index]));
                            });
                      },
                    )
                )
              ],
            ),
          );
        }
    );
  }
}
