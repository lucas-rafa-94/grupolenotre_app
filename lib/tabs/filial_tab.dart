import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grupolenotre/api/filial_api.dart';
import 'package:grupolenotre/datas/filial_data.dart';
import 'package:grupolenotre/models/user_model.dart';
import 'package:grupolenotre/screens/filial/insert_filial_screen.dart';
import 'package:grupolenotre/tiles/menu_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class FilialTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FilialApi filialApi = new FilialApi();

    List<dynamic> _toList (String  str){
      List map = json.decode(str)['registros'];
      FilialData f = FilialData.fromMap(map[0]);
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
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=> InserFilialScreen())
                          );
                        },
                        textColor: Colors.white,
                        child: Text("Cadastrar Nova Filial",
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
                      labelText: "Pesquise uma filial",
                      hintText: "Filial",
                      prefixIcon: Icon(Icons.search, color: Color(0xffD77E67)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: FutureBuilder<String>(
                      future: filialApi.makeGetAllStringRequest(model.token),
                      builder: (context, snapshot){
                        if(!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        return ListView.builder(
                            padding: EdgeInsets.only(top: 0.0),
                            itemCount: _toList(snapshot.data).length,
                            itemBuilder: (context, index) {
                              return MenuTile(FilialData.fromMap(json.decode(snapshot.data)['registros'][index]));
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
