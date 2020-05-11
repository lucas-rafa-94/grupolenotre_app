import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grupolenotre/models/user_model.dart';
import 'package:grupolenotre/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class FotoPreviewScreen extends StatefulWidget {
  String cs;
  String imagePath;
  FotoPreviewScreen(this.cs, this.imagePath);

  @override
  _FotoPreviewScreenState createState() => _FotoPreviewScreenState(this.cs, this.imagePath);
}

class _FotoPreviewScreenState extends State<FotoPreviewScreen> {
  String cs;
  String imagePath;
  _FotoPreviewScreenState(this.cs, this.imagePath);

  Future<void> _onSuccess() async {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=> HomeScreen())
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
                  Text(''),
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


  void create(cs , imagePath, model){
    model.makePostFotoRequest(
        cs,
        imagePath,
        _onSuccess,
        _onFailure
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      if (model.isLoading) return Center(child: CircularProgressIndicator());
      return Scaffold(
        appBar: AppBar(
          title: Text("Camera"),
          backgroundColor: Color.fromARGB(255, 66, 163, 177),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Image.file(
                      File(widget.imagePath), fit: BoxFit.cover)
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
                        create(this.cs, widget.imagePath, model);
                      },
                      textColor: Colors.white,
                      child: Text("Confirme a foto",
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
