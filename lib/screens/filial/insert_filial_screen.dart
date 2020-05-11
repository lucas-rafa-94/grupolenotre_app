import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:grupolenotre/datas/filial_data.dart';
import 'package:grupolenotre/datas/produto_data.dart';
import 'package:grupolenotre/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class InserFilialScreen extends StatefulWidget {
  @override
  _InserFilialScreenState createState() => _InserFilialScreenState();
}

class _InserFilialScreenState extends State<InserFilialScreen> {



  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _ativo = "0";
  String _tipoContribuinte = "0";
  String _whatsApp = "0";
  String _regTributario = "0";

  FilialData _filialData = new FilialData();

  //Geral Tab Controllers
  TextEditingController razaoSocialController = TextEditingController();
  TextEditingController nomeFantasiaController = TextEditingController();
  TextEditingController cnpjController = TextEditingController();
  TextEditingController inscricaoEstadualController = TextEditingController();
  TextEditingController inscricaoMunicipalController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController webSiteController = TextEditingController();
  TextEditingController obsController = TextEditingController();

  //Endereco Tab Controllers
  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();

  //Fiscal Tab Controllers
  TextEditingController aPisController = TextEditingController();
  TextEditingController aCofinsController = TextEditingController();
  TextEditingController aCsController = TextEditingController();
  TextEditingController aIrController = TextEditingController();

  Future<void> _onSuccess() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Aviso'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Filial criada com sucesso!'),
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

  void create(model){
    print(_ativo);
    _filialData.ativa = _ativo;
    _filialData.whatsapp = _whatsApp;
    _filialData.tipoContribuinte = _tipoContribuinte;
    _filialData.regTributario = _regTributario;
    model.filialCreate(
        filialData: _filialData,
        onSuccess: _onSuccess,
        onFailure: _onFailure);
  }

  @override
  Widget _getFAB(UserModel model, FilialData _filialData) {
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
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 66, 163, 177),
            onTap: () {
              create(model);
            },
            label: 'Criar Filial',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Color.fromARGB(255, 66, 163, 177))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      if (model.isLoading) return Center(child: CircularProgressIndicator());
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          key: _scaffoldKey,
          floatingActionButton: _getFAB(model, _filialData),
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
                                  child: Text(
                                    "Filial está ativa?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                                RadioButtonGroup(
                                  orientation:
                                      GroupedButtonsOrientation.VERTICAL,
                                  labels: [
                                    "Sim",
                                    "Não",
                                  ],
                                  onSelected: (String selected) => setState(() {
                                    _ativo = selected == "Sim" ? '1' : '0';
                                  }),
                                  picked: _ativo == "1" ? 'Sim' : 'Não',
                                  onChange: (String label, int index) {
//
                                  }
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: TextFormField(
                              onChanged: (text) {
                                _filialData.razaoSocial = text;
                              },
                              decoration: new InputDecoration(
                                  labelText: "Razão Social",
                                  fillColor: Colors.red,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(2.0),
                                    borderSide:
                                        new BorderSide(color: Colors.red),
                                  )),
                              controller: razaoSocialController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              onChanged: (text) {
                                _filialData.nomeFantasia = text;
                              },
                              decoration: new InputDecoration(
                                  labelText: "Nome Fantasia",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      borderSide: new BorderSide())),
                              controller: nomeFantasiaController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              onChanged: (text) {
                                _filialData.cnpj = text;
                              },
                              decoration: new InputDecoration(
                                  labelText: "CNPJ",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      borderSide: new BorderSide())),
                              controller: cnpjController,
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
                                    "Tipo de Contribuinte",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                                RadioButtonGroup(
                                  labels: [
                                    "Contribuinte ICMS",
                                    "Contribuinte Isento",
                                    "Não Contribuinte",
                                  ],
                                  onSelected: (String selected) => setState(() {
                                    _tipoContribuinte =
                                        selected == 'Não Contribuinte'
                                            ? '0'
                                            : selected == 'Contribuinte Isento'
                                                ? '1'
                                                : 'Contribuinte ICMS';
                                  }),
                                  picked: _tipoContribuinte == '0'
                                      ? 'Não Contribuinte'
                                      : _tipoContribuinte == '1'
                                          ? 'Contribuinte Isento'
                                          : 'Contribuinte ICMS',
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextFormField(
                                onChanged: (text) {
                                  _filialData.inscricaoEstadual = text;
                                },
                                decoration: new InputDecoration(
                                    labelText: "Inscrição Estadual",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(2.0),
                                        borderSide: new BorderSide())),
                                controller: inscricaoEstadualController,
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextFormField(
                                onChanged: (text) {
                                  _filialData.inscricaoMunicipal = text;
                                },
                                decoration: new InputDecoration(
                                    labelText: "Inscrição Municipal",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(2.0),
                                        borderSide: new BorderSide())),
                                controller: inscricaoMunicipalController,
                              )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: TextFormField(
                              onChanged: (text) {
                                _filialData.emails = text;
                              },
                              decoration: new InputDecoration(
                                  labelText: "Email",
                                  fillColor: Colors.red,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(2.0),
                                    borderSide:
                                        new BorderSide(color: Colors.red),
                                  )),
                              controller: emailController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              onChanged: (text) {
                                _filialData.fone = text;
                              },
                              decoration: new InputDecoration(
                                  labelText: "Telefone",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      borderSide: new BorderSide())),
                              controller: telefoneController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              onChanged: (text) {
                                _filialData.celular = text;
                              },
                              decoration: new InputDecoration(
                                  labelText: "Celular",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      borderSide: new BorderSide())),
                              controller: celularController,
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
                                        fontSize: 16.0),
                                  ),
                                ),
                                RadioButtonGroup(
                                  labels: [
                                    "Sim",
                                    "Não",
                                  ],
                                  onSelected: (String selected) => setState(() {
                                    _whatsApp = selected == "Sim" ? '1' : '0';
                                  }),
                                  picked: _whatsApp == "1" ? 'Sim' : 'Não',
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextFormField(
                                onChanged: (text) {
                                  _filialData.facebook = text;
                                },
                                decoration: new InputDecoration(
                                    labelText: "Facebook",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(2.0),
                                        borderSide: new BorderSide())),
                                controller: facebookController,
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextFormField(
                                onChanged: (text) {
                                  _filialData.instagram = text;
                                },
                                decoration: new InputDecoration(
                                    labelText: "Instagram",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(2.0),
                                        borderSide: new BorderSide())),
                                controller: instagramController,
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextFormField(
                                onChanged: (text) {
                                  _filialData.website = text;
                                },
                                decoration: new InputDecoration(
                                    labelText: "Site",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(2.0),
                                        borderSide: new BorderSide())),
                                controller: webSiteController,
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                              child: TextFormField(
                                onChanged: (text) {
                                  _filialData.obs = text;
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: 10,
                                decoration: new InputDecoration(
                                    labelText: "Observações",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(2.0),
                                        borderSide: new BorderSide())),
                                controller: obsController,
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
                                _filialData.cep = text;
                              },
                              decoration: new InputDecoration(
                                  labelText: "CEP",
                                  fillColor: Colors.red,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(2.0),
                                    borderSide:
                                        new BorderSide(color: Colors.red),
                                  )),
                              controller: cepController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              onChanged: (text) {
                                _filialData.logradouro = text;
                              },
                              decoration: new InputDecoration(
                                  labelText: "Logradouro",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      borderSide: new BorderSide())),
                              controller: logradouroController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              onChanged: (text) {
                                _filialData.numero = text;
                              },
                              decoration: new InputDecoration(
                                  labelText: "Número",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      borderSide: new BorderSide())),
                              controller: numeroController,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextFormField(
                                onChanged: (text) {
                                  _filialData.complemento = text;
                                },
                                decoration: new InputDecoration(
                                    labelText: "Complemento",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(2.0),
                                        borderSide: new BorderSide())),
                                controller: complementoController,
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextFormField(
                                onChanged: (text) {
                                  _filialData.bairro = text;
                                },
                                decoration: new InputDecoration(
                                    labelText: "Bairro",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(2.0),
                                        borderSide: new BorderSide())),
                                controller: bairroController,
                              )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: TextFormField(
                              onChanged: (text) {
                                _filialData.cidade = text;
                              },
                              decoration: new InputDecoration(
                                  labelText: "Cidade",
                                  fillColor: Colors.red,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(2.0),
                                    borderSide:
                                        new BorderSide(color: Colors.red),
                                  )),
                              controller: cidadeController,
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
                                  child: Text(
                                    "Regime Tributário",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                                RadioButtonGroup(
                                  orientation:
                                      GroupedButtonsOrientation.VERTICAL,
                                  labels: [
                                    "Simples Nacional",
                                    "Normal",
                                  ],
                                  onSelected: (String selected) => setState(() {
                                    _regTributario =
                                        selected == "Simples Nacional"
                                            ? '1'
                                            : '0';
                                  }),
                                  picked: _regTributario == "1"
                                      ? 'Simples Nacional'
                                      : 'Normal',
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              onChanged: (text) {
                                _filialData.aPis = text;
                              },
                              decoration: new InputDecoration(
                                  labelText: "Alíquota. PIS (%)",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      borderSide: new BorderSide())),
                        controller: aPisController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              onChanged: (text) {
                                _filialData.aCofins = text;
                              },
                              decoration: new InputDecoration(
                                  labelText: "Alíquota. COFINS (%)",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      borderSide: new BorderSide())),
                        controller: aCofinsController,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextFormField(
                                onChanged: (text) {
                                  _filialData.aCS = text;
                                },
                                decoration: new InputDecoration(
                                    labelText:
                                        "Alíquota. Contribuição Social (%)",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(2.0),
                                        borderSide: new BorderSide())),
                              controller: aCsController,
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextFormField(
                                onChanged: (text) {
                                  _filialData.aIR = text;
                                },
                                decoration: new InputDecoration(
                                    labelText: "Alíquota. Imposto de Renda (%)",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(2.0),
                                        borderSide: new BorderSide())),
                              controller: aIrController,
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
    });
  }
}
