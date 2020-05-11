import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:grupolenotre/datas/filial_data.dart';
import 'package:grupolenotre/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class UpdateOrDeleteFilialScreen extends StatefulWidget {
  FilialData filialData;

  UpdateOrDeleteFilialScreen(this.filialData);

  @override
  _UpdateOrDeleteFilialScreenState createState() => _UpdateOrDeleteFilialScreenState(filialData.ativa, filialData.whatsapp, filialData.tipoContribuinte,  filialData.regTributario,);
}

class _UpdateOrDeleteFilialScreenState extends State<UpdateOrDeleteFilialScreen> {

  String _ativo;
  String _whatsApp;
  String _tipoContribuinte;
  String _regTributario;

  _UpdateOrDeleteFilialScreenState(this._ativo, this._whatsApp, this._tipoContribuinte,
      this._regTributario);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void update(model){
    widget.filialData.ativa = _ativo;
    widget.filialData.whatsapp = _whatsApp;
    widget.filialData.tipoContribuinte = _tipoContribuinte;
    widget.filialData.regTributario = _regTributario;
    model.filialUpdate(
        filialData: widget.filialData,
        onSuccess: _onSuccessUpdate,
        onFailure: _onFailureUpdate);

  }

  Future<void> _onSuccessUpdate() async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Aviso'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Filial atualizada com sucesso!'),
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
        }
    );
  }

  Future<void> _onFailureUpdate() async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Aviso'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Erro ao atualizar filial!'),
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
        }
    );
  }

  Future<void> _onSuccessDelete() async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Aviso'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Filial apagada com sucesso!'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  Future<void> _onFailureDelete() async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Aviso'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Erro ao apagar filial!'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }


  @override
  Widget _getFAB(UserModel model, FilialData filialData) {
    return SpeedDial(
      marginRight: 18,
      marginBottom: 40,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: Color(0xffD77E67),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
            onTap: () {
              model.filialDelete(
                  filialData: filialData,
                  onSuccess: _onSuccessDelete,
                  onFailure: _onFailureDelete
              );
            },
            label: 'Excluir',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Colors.red),
        // FAB 2
        SpeedDialChild(
            child: Icon(Icons.edit),
            backgroundColor: Color.fromARGB(255, 66, 163, 177),
            onTap: () {
              update(model);
            },
            label: 'Atualizar',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Color.fromARGB(255, 66, 163, 177))
      ],
    );
  }


  Widget build(BuildContext context) {
    //Gerat Tab Controllers


    return ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              key: _scaffoldKey,
              floatingActionButton: _getFAB(model, widget.filialData),
              appBar: AppBar(
                title: Text("Filiais"),
                backgroundColor: Color.fromARGB(255, 66, 163, 177),
                centerTitle: true,
                bottom: TabBar(
                  indicatorColor: Color(0xffD77E67),
                  tabs: <Widget>[
                    Tab(text: 'Geral'),
                    Tab(text: 'Endereço'),
                    Tab(text: 'Fiscal')
                  ],
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  //Geral Tab
                  Container(
                    child: Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.t,
                            children: <Widget>[
                              Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 14.0, top: 14.0, bottom: 10.0),
                                      child: Text("Filial está ativa?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0
                                        ),
                                      ),
                                    ),
                                    RadioButtonGroup(
                                      orientation: GroupedButtonsOrientation
                                          .VERTICAL,
                                      labels: [
                                        "Sim",
                                        "Não",
                                      ],
                                      onSelected: (String selected) =>
                                          setState(() {
                                            _ativo =
                                            selected == "Sim" ? '1' : '0';
                                          }),
                                      picked: _ativo == "1" ? 'Sim' : 'Não',
                                      onChange: (String label, int index) =>
                                          print(_ativo),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    widget.filialData.razaoSocial = text;
                                  },
                                  initialValue: widget.filialData.razaoSocial,
                                  decoration: new InputDecoration(
                                      labelText: "Razão Social",
                                      fillColor: Colors.red,
                                      border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(
                                            2.0),
                                        borderSide: new BorderSide(
                                            color: Colors.red),
                                      )),
//                        controller: razaoSocialController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    widget.filialData.nomeFantasia = text;
                                  },
                                  initialValue: widget.filialData.nomeFantasia,
                                  decoration: new InputDecoration(
                                      labelText: "Nome Fantasia",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
//                        controller: emailController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    widget.filialData.cnpj = text;
                                  },
                                  initialValue: widget.filialData.cnpj,
                                  decoration: new InputDecoration(
                                      labelText: "CNPJ",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
//                        controller: emailController,
                                ),
                              ),
                              Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 14.0, top: 14.0, bottom: 10.0),
                                      child: Text("Tipo de Contribuinte",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0
                                        ),
                                      ),
                                    ),
                                    RadioButtonGroup(
                                      labels: [
                                        "Contribuinte ICMS",
                                        "Contribuinte Isento",
                                        "Não Contribuinte",
                                      ],
                                      onSelected: (String selected) =>
                                          setState(() {
                                            _tipoContribuinte =
                                            selected == 'Não Contribuinte'
                                                ? '0'
                                                : selected ==
                                                'Contribuinte Isento'
                                                ? '1'
                                                : 'Contribuinte ICMS';
                                          }),
                                      picked: _tipoContribuinte == '0'
                                          ? 'Não Contribuinte'
                                          : _tipoContribuinte == '1'
                                          ? 'Contribuinte Isento'
                                          : 'Contribuinte ICMS',
                                      onChange: (String label, int index) =>
                                          print(label),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: TextFormField(
                                    onChanged: (text) {
                                      widget.filialData.inscricaoEstadual = text;
                                    },
                                    initialValue: widget.filialData
                                        .inscricaoEstadual,
                                    decoration: new InputDecoration(
                                        labelText: "Inscrição Estadual",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(2.0),
                                            borderSide: new BorderSide())),
//                        controller: emailController,
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: TextFormField(
                                    onChanged: (text) {
                                      widget.filialData.inscricaoMunicipal = text;
                                    },
                                    initialValue: widget.filialData
                                        .inscricaoMunicipal,
                                    decoration: new InputDecoration(
                                        labelText: "Inscrição Municipal",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(2.0),
                                            borderSide: new BorderSide())),
//                        controller: emailController,
                                  )),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    widget.filialData.emails = text;
                                  },
                                  initialValue: widget.filialData.emails,
                                  decoration: new InputDecoration(
                                      labelText: "Email",
                                      fillColor: Colors.red,
                                      border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(
                                            2.0),
                                        borderSide: new BorderSide(
                                            color: Colors.red),
                                      )),
//                        controller: emailController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    widget.filialData.fone = text;
                                  },
                                  initialValue: widget.filialData.fone,
                                  decoration: new InputDecoration(
                                      labelText: "Telefone",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
//                        controller: emailController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    widget.filialData.celular = text;
                                  },
                                  initialValue: widget.filialData.celular,
                                  decoration: new InputDecoration(
                                      labelText: "Celular",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
//                        controller: emailController,
                                ),
                              ),
                              Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 14.0, top: 14.0, bottom: 10.0),
                                      child: Text(
                                        "Celular é número de WhatsApp?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0
                                        ),
                                      ),
                                    ),
                                    RadioButtonGroup(
                                      labels: [
                                        "Sim",
                                        "Não",
                                      ],
                                      onSelected: (String selected) =>
                                          setState(() {
                                            _whatsApp =
                                            selected == "Sim" ? '1' : '0';
                                          }),
                                      picked: _whatsApp == "1" ? 'Sim' : 'Não',
                                      onChange: (String label, int index) =>
                                          print(_whatsApp),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: TextFormField(
                                    onChanged: (text) {
                                      widget.filialData.facebook = text;
                                    },
                                    initialValue: widget.filialData.facebook,
                                    decoration: new InputDecoration(
                                        labelText: "Facebook",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(2.0),
                                            borderSide: new BorderSide())),
//                        controller: emailController,
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: TextFormField(
                                    onChanged: (text) {
                                      widget.filialData.instagram = text;
                                    },
                                    initialValue: widget.filialData.instagram,
                                    decoration: new InputDecoration(
                                        labelText: "Instagram",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(2.0),
                                            borderSide: new BorderSide())),
//                        controller: emailController,
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: TextFormField(
                                    onChanged: (text) {
                                      widget.filialData.website = text;
                                    },
                                    initialValue: widget.filialData.website,
                                    decoration: new InputDecoration(
                                        labelText: "Site",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(2.0),
                                            borderSide: new BorderSide())),
//                        controller: emailController,
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                                  child: TextFormField(
                                    onChanged: (text) {
                                      widget.filialData.obs = text;
                                    },
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 10,
                                    initialValue: widget.filialData.obs,
                                    decoration: new InputDecoration(
                                        labelText: "Observações",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(2.0),
                                            borderSide: new BorderSide())),
//                        controller: emailController,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //Endereço Tab
                  Container(
                    child: Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.t,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    widget.filialData.cep = text;
                                  },
                                  initialValue: widget.filialData.cep,
                                  decoration: new InputDecoration(
                                      labelText: "CEP",
                                      fillColor: Colors.red,
                                      border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(
                                            2.0),
                                        borderSide: new BorderSide(
                                            color: Colors.red),
                                      )),
//                        controller: emailController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    widget.filialData.logradouro = text;
                                  },
                                  initialValue: widget.filialData.logradouro,
                                  decoration: new InputDecoration(
                                      labelText: "Logradouro",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
//                        controller: emailController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    widget.filialData.numero = text;
                                  },
                                  initialValue: widget.filialData.numero,
                                  decoration: new InputDecoration(
                                      labelText: "Número",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
//                        controller: emailController,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: TextFormField(
                                    onChanged: (text) {
                                      widget.filialData.complemento = text;
                                    },
                                    initialValue: widget.filialData.complemento,
                                    decoration: new InputDecoration(
                                        labelText: "Complemento",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(2.0),
                                            borderSide: new BorderSide())),
//                        controller: emailController,
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: TextFormField(
                                    onChanged: (text) {
                                      widget.filialData.bairro = text;
                                    },
                                    initialValue: widget.filialData.bairro,
                                    decoration: new InputDecoration(
                                        labelText: "Bairro",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(2.0),
                                            borderSide: new BorderSide())),
//                        controller: emailController,
                                  )),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    widget.filialData.cidade = text;
                                  },
                                  initialValue: widget.filialData.cidade,
                                  decoration: new InputDecoration(
                                      labelText: "Cidade",
                                      fillColor: Colors.red,
                                      border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(
                                            2.0),
                                        borderSide: new BorderSide(
                                            color: Colors.red),
                                      )),
//                        controller: emailController,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //Fiscal Tab
                  Container(
                    child: Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.t,
                            children: <Widget>[
                              Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 14.0, top: 14.0, bottom: 10.0),
                                      child: Text("Regime Tributário",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0
                                        ),
                                      ),
                                    ),
                                    RadioButtonGroup(
                                      orientation: GroupedButtonsOrientation
                                          .VERTICAL,
                                      labels: [
                                        "Simples Nacional",
                                        "Normal",
                                      ],
                                      onSelected: (String selected) =>
                                          setState(() {
                                            _regTributario =
                                            selected == "Simples Nacional"
                                                ? '1'
                                                : '0';
                                          }),
                                      picked: _regTributario == "1"
                                          ? 'Simples Nacional'
                                          : 'Normal',
                                      onChange: (String label, int index) =>
                                          print(_regTributario),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    widget.filialData.aPis = text;
                                  },
                                  initialValue: widget.filialData.aPis,
                                  decoration: new InputDecoration(
                                      labelText: "Alíquota. PIS (%)",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
//                        controller: emailController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    widget.filialData.aCofins = text;
                                  },
                                  initialValue: widget.filialData.aCofins,
                                  decoration: new InputDecoration(
                                      labelText: "Alíquota. COFINS (%)",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
//                        controller: emailController,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: TextFormField(
                                    onChanged: (text) {
                                      widget.filialData.aCS = text;
                                    },
                                    initialValue: widget.filialData.aCS,
                                    decoration: new InputDecoration(
                                        labelText: "Alíquota. Contribuição Social (%)",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(2.0),
                                            borderSide: new BorderSide())),
//                        controller: emailController,
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: TextFormField(
                                    onChanged: (text) {
                                      widget.filialData.aIR = text;
                                    },
                                    initialValue: widget.filialData.aIR,
                                    decoration: new InputDecoration(
                                        labelText: "Alíquota. Imposto de Renda (%)",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(2.0),
                                            borderSide: new BorderSide())),
//                        controller: emailController,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

    );

  }
}
