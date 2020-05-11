import 'package:flutter/material.dart';
import 'package:grupolenotre/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class FotoDetalhesScreen extends StatefulWidget {
  String urlFoto;
  FotoDetalhesScreen(this.urlFoto);
  @override
  _FotoDetalhesScreenState createState() => _FotoDetalhesScreenState(this.urlFoto);
}

class _FotoDetalhesScreenState extends State<FotoDetalhesScreen> {
  String urlFoto;
  _FotoDetalhesScreenState(this.urlFoto);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      if (model.isLoading) return Center(child: CircularProgressIndicator());
      return Scaffold(
        appBar: AppBar(
          title: Text("Foto"),
          backgroundColor: Color.fromARGB(255, 66, 163, 177),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Image.network(
                      this.urlFoto, fit: BoxFit.cover)
              ),
//            SizedBox(height: 10.0),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(
                    top: 20.0, left: 15.0, right: 15.0, bottom: 20.0),
                color: Colors.white,
                child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius:
                        new BorderRadius.circular(60.0),
                        side: BorderSide(
                            color: Color(0xffD77E67)),
                      ),
                      color: Color(0xffD77E67),
                      onPressed: () {
//                        create(model);
                      },
                      textColor: Colors.white,
                      child: Text("Deletar Foto",
                          style: TextStyle(fontSize: 12)),
                    )),
              ),
            ],
          ),
        ),
      );
    });
  }
}
