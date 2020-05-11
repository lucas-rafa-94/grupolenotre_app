import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:grupolenotre/api/filial_api.dart';
import 'package:grupolenotre/api/funcionario_api.dart';
import 'package:grupolenotre/api/obra_api.dart';
import 'package:grupolenotre/api/produto_api.dart';
import 'package:grupolenotre/datas/filial_data.dart';
import 'package:grupolenotre/datas/funcionario_data.dart';
import 'package:grupolenotre/datas/multi_select_data.dart';
import 'package:grupolenotre/datas/obra_data.dart';
import 'package:grupolenotre/datas/produto_data.dart';
import 'package:grupolenotre/datas/relatorio_data.dart';
import 'package:grupolenotre/models/user_model.dart';
import 'package:grupolenotre/screens/camera/camera_screen.dart';
import 'package:grupolenotre/screens/home_screen.dart';
import 'package:grupolenotre/tabs/relatorio_tab.dart';
import 'package:grupolenotre/tiles/menu_foto_tile.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class UpdateOrDeleteRelatorioScreen extends StatefulWidget {
  RelatorioData relatorioData;

  UpdateOrDeleteRelatorioScreen(this.relatorioData);

  @override
  _UpdateOrDeleteRelatorioScreenState createState() => _UpdateOrDeleteRelatorioScreenState(this.relatorioData);

}

class _UpdateOrDeleteRelatorioScreenState extends State<UpdateOrDeleteRelatorioScreen> {
  
  var dateFormat = DateFormat("dd/MM/yyyy");
  var maskDataInputFormatter = MaskTextInputFormatter(mask: "##/##/####", filter: { "#": RegExp(r'[0-9]') });
  var maskHorarioInputFormatter = MaskTextInputFormatter(mask: "##:##", filter: { "#": RegExp(r'[0-9]') });

  RelatorioData relatorioData;

  Card singleItemList(model, int index) {
    return Card(
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 100,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Text(model.multiDataProdutoSelecionado[index].nome == null ? 'Nome não identificado' : model.multiDataProdutoSelecionado[index].nome)
                ),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    onChanged: (text) {
                      model.multiDataProdutoSelecionado[index].qtd = text;
                    },
                    initialValue: model.multiDataProdutoSelecionado[index].qtd,
                    decoration: new InputDecoration(
                      labelText: "Quantidade",
                      fillColor: Colors.white,
                    ),
                  ),
                )
              ],
            )
        )
    );

  }

  _UpdateOrDeleteRelatorioScreenState(this.relatorioData);

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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=> HomeScreen())
                  );
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=> HomeScreen())
                  );
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

//  RelatorioData this.relatorioData = new RelatorioData();


  @override
  Widget _getFAB(UserModel model, RelatorioData relatorioData) {
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
              model.relatorioDelete(
                  relatorioData: this.relatorioData,
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

  TextEditingController filialController = TextEditingController();
  TextEditingController obraController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController horarioInicialController = TextEditingController();
  TextEditingController horarioFinalController = TextEditingController();
  TextEditingController kmInicialController = TextEditingController();
  TextEditingController kmFinalController = TextEditingController();
  TextEditingController kmTrabalhoController = TextEditingController();
  TextEditingController kmParticularController = TextEditingController();
  TextEditingController funcionariosController = TextEditingController();
  TextEditingController obsController = TextEditingController();

  List<FilialData> list = new List();

  Map<String, int> quantities = {};

  void takeNumber(String text, String itemId) {
    try {
      int number = int.parse(text);
      quantities[itemId] = number;
    } on FormatException {}
  }



  MultiSelectData multiSelectData = new MultiSelectData();


  List _multiData = new List();
  List  _myFuncionarios = new List();
  List  _myServicos = new List();
  ObraApi obraApi = new ObraApi();

  final _scaffoldKey = GlobalKey<ScaffoldState>();


  FilialApi filialApi = new FilialApi();
  FuncionarioApi funcionarioApi = new FuncionarioApi();
  ProdutoApi produtoApi = new ProdutoApi();
  String _csObra = '';
  String _csFilial = '';
  String _valueFilialDropDown ='Selecione a Filial';
  String _valueObraDropDown ='Selecione o Cliente';
  String _filial = '';

  String _date = '';
  String _timeInicio = '';
  String _timeFinal = '';


  void update(model) {
    String func = '';

    List<ServicoRequest> list = new List();
    for (int i = 0; i < _myFuncionarios.length; i++) {
      func = func + _myFuncionarios[i] + " ,";
    }
    this.relatorioData.funcionariosRequest = func;
    this.relatorioData.filial = _filial;
    this.relatorioData.csObra = _csObra;
    this.relatorioData.produtosRequest = model.multiDataProdutoSelecionado;

    for (int i = 0; i < _myServicos.length; i++) {
      ServicoRequest servico = new ServicoRequest();
      servico.cs = _myServicos[i];
      list.add(servico);
    }


    this.relatorioData.servicosRequest = list;


    model.relatorioUpdate(
        relatorioData: this.relatorioData,
        onSuccess: _onSuccessUpdate,
        onFailure: _onFailureUpdate);

  }

  void fill(model){
    for(int i = 0; i < model.multiDataFilial.length; i++){
        if(model.multiDataFilial[i].cs == this.relatorioData.csFilial){
        _valueFilialDropDown = model.multiDataFilial[i].nomeFantasia;
      }
    }

    for(int i = 0; i < model.multiDataObra.length; i++){
      if(model.multiDataObra[i].cs == this.relatorioData.csObra){
        _valueObraDropDown = model.multiDataObra[i].nomeObra;
      }
    }

    if(this.relatorioData.funcionariosRetorno != null){
      for(int i = 0; i < this.relatorioData.funcionariosRetorno.length; i++){

        for(int v = 0; v < model.multiData.length; v++ ){
          MultiSelectData multiSelectData = new MultiSelectData();
          multiSelectData = MultiSelectData.fromMap(model.multiData[v]);
          if(multiSelectData.display == this.relatorioData.funcionariosRetorno[i].nome){
            if(!_myFuncionarios.contains(multiSelectData.display)){
              _myFuncionarios.add(multiSelectData.display);
            }
          }
        }
      }
    }


    if(this.relatorioData.produtos != null){
      for(int i = 0; i < this.relatorioData.produtos.length; i++){
        for(int v = 0; v < model.multiDataProdutoSelecionado.length; v++ ){
          if(model.multiDataProdutoSelecionado[v].nome == this.relatorioData.produtos[i].nome){
            model.multiDataProdutoSelecionado[v].qtd = this.relatorioData.produtos[i].quantidade;
          }
        }
      }
    }

    if(this.relatorioData.servicosResponse != null){
      for(int i = 0; i < this.relatorioData.servicosResponse.length; i++){

        for(int v = 0; v < model.multiDataServico.length; v++ ){

          if(model.multiDataServico[v]['value'] == this.relatorioData.servicosResponse[i].cs){
            if(!_myServicos.contains(model.multiDataServico[v]['value'])){
              _myServicos.add(model.multiDataServico[v]['value']);
            }
          }
        }
      }
    }


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final formKey = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final format = DateFormat("dd/MM/yyyy");
    final timeFormat = DateFormat("HH:mm");

    FilialData _filialData;
    ObraData _obraData;

    //Geral Tab Controllers
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      print('DATA -- ' + this.relatorioData.data);
      _date = this.relatorioData.data == null ? 'Não Definido' : this.relatorioData.data;
      _timeInicio = this.relatorioData.horarioInicial == null ? 'Não Definido' : this.relatorioData.horarioInicial;
      _timeFinal = this.relatorioData.horarioFinal == null ? 'Não Definido' : this.relatorioData.horarioFinal;

      fill(model);
      if (model.isLoading) return Center(child: CircularProgressIndicator());
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          key: _scaffoldKey,
          floatingActionButton: _getFAB(model, this.relatorioData),
          appBar: AppBar(
            title: Text("Relatório Diário"),
            backgroundColor: Color.fromARGB(255, 66, 163, 177),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Color(0xffD77E67),
              tabs: <Widget>[Tab(text: 'Geral'), Tab(text: 'Produtos'), Tab(text: 'Fotos')],
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
                      child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 400,
                                      padding: EdgeInsets.only(
                                          left: 14.0,
                                          top: 14.0,
                                          bottom: 10.0,
                                          right: 14.0),
                                      child: FutureBuilder<String>(
                                          future: filialApi
                                              .makeGetAllRequest(model.token),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<String> snapshot) {
                                            if (!snapshot.hasData)
                                              return CircularProgressIndicator();
                                            return DropdownButton<FilialData>(
                                                items: model.multiDataFilial
                                                    .map((filialData) =>
                                                    DropdownMenuItem<
                                                        FilialData>(
                                                      child: Text(filialData
                                                          .nomeFantasia),
                                                      value: filialData,
                                                    ))
                                                    .toList(),
                                                onChanged: (FilialData value) {
                                                  setState(() {
                                                    _filialData = value;
                                                    _valueFilialDropDown =
                                                        _filialData
                                                            .nomeFantasia;
                                                    _csFilial = _filialData.cs;
                                                  });
                                                },
                                                isExpanded: false,
                                                value: _filialData,
                                                hint:
                                                Text(_valueFilialDropDown));
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 400,
                                      padding: EdgeInsets.only(
                                          left: 14.0,
                                          top: 14.0,
                                          bottom: 10.0,
                                          right: 14.0),
                                      child: FutureBuilder<String>(
                                          future: obraApi
                                              .makeGetAllRequest(model.token),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<String> snapshot) {
                                            if (!snapshot.hasData)
                                              return CircularProgressIndicator();
                                            return DropdownButton<ObraData>(
                                                items:
                                                model.multiDataObra
                                                    .map((obraData) =>
                                                    DropdownMenuItem<
                                                        ObraData>(
                                                      child: Text(
                                                          obraData
                                                              .nomeObra),
                                                      value: obraData,
                                                    ))
                                                    .toList(),
                                                onChanged: (ObraData value) {
                                                  setState(() {
                                                    _obraData = value;
                                                    _valueObraDropDown =
                                                        _obraData.nomeObra;
                                                    _csObra = _obraData.cs;
                                                  });
                                                },
                                                isExpanded: false,
                                                value: _obraData,
                                                hint: Text(_valueObraDropDown));
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                child: MultiSelectFormField(
                                  autovalidate: false,
                                  titleText: 'Funcionários',
                                  dataSource: model.multiData,
                                  textField: 'display',
                                  valueField: 'display',
                                  okButtonLabel: 'OK',
                                  cancelButtonLabel: 'CANCEL',
                                  // required: true,
                                  hintText: 'Escolha um ou mais de um',
                                  value: _myFuncionarios,
                                  onSaved: (value) {
                                    if (value == null) return;
                                    setState(() {
                                      _myFuncionarios = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                child: MultiSelectFormField(
                                  autovalidate: false,
                                  titleText: 'Serviços executados',
                                  dataSource: model.multiDataServico,
                                  textField: 'display',
                                  valueField: 'value',
                                  okButtonLabel: 'OK',
                                  cancelButtonLabel: 'CANCEL',
                                  // required: true,
                                  hintText: 'Escolha um ou mais de um',
                                  value: _myServicos,
                                  onSaved: (value) {
                                    if (value == null) return;
                                    setState(() {
                                      _myServicos = value;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child : DateTimeField(
                                  decoration: new InputDecoration(
                                      labelText: "Data",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
                                  initialValue: format.parse(_date),
                                  format: format,
                                  onChanged: (time){
                                    this.relatorioData.data = time.day.toString() + '/' + time.month.toString() + '/' + time.year.toString();
                                  },
                                    onShowPicker: (context, currentValue) {
                                      return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate: format.parse(_date) ?? DateTime.now(),
                                        lastDate: DateTime(2100),
                                      );
                                    },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child : DateTimeField(
                                  decoration: new InputDecoration(
                                      labelText: "Horário Inicial",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
                                  initialValue: timeFormat.parse(_timeFinal),
                                  format: timeFormat,
                                  onChanged: (time){
                                    this.relatorioData.horarioInicial = time.hour.toString() + ':' + time.minute.toString();
                                  },
                                  onShowPicker: (context, currentValue) async {
                                    final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(timeFormat.parse(_timeFinal) ?? DateTime.now()),
                                    );
                                    return DateTimeField.convert(time);
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child : DateTimeField(
                                      decoration: new InputDecoration(
                                          labelText: "Horário Final",
                                          fillColor: Colors.white,
                                          border: new OutlineInputBorder(
                                              borderRadius:
                                              new BorderRadius.circular(2.0),
                                              borderSide: new BorderSide())),
                                    initialValue: timeFormat.parse(_timeFinal),
                                    onChanged: (time){
                                      this.relatorioData.horarioFinal = time.hour.toString() + ':' + time.minute.toString();
                                    },
                                    format: timeFormat,
                                    onShowPicker: (context, currentValue) async {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(timeFormat.parse(_timeFinal) ?? DateTime.now()),
                                      );
                                      return DateTimeField.convert(time);
                                    },
                                  ),
                              ),
//                              Container(
//                                padding: EdgeInsets.all(16),
//                                child: Column(
//                                  mainAxisSize: MainAxisSize.max,
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    RaisedButton(
//                                      shape: RoundedRectangleBorder(
//                                          borderRadius: BorderRadius.circular(5.0)),
//                                      elevation: 4.0,
//                                      onPressed: () {
//                                        DatePicker.showDatePicker(context,
//                                            theme: DatePickerTheme(
//                                              containerHeight: 210.0,
//                                            ),
//                                            showTitleActions: true,
//                                            minTime: DateTime(2000, 1, 1),
//                                            maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
//                                              _date = '${date.year} - ${date.month} - ${date.day}';
//                                              this.relatorioData.data = '${date.day} / ${date.month} / ${date.year}';
//                                              setState(() {});
//                                            }, currentTime: DateTime.now(), locale: LocaleType.pt);
//                                      },
//                                      child: Container(
//                                        alignment: Alignment.center,
//                                        height: 50.0,
//                                        child: Row(
//                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Row(
//                                              children: <Widget>[
//                                                Container(
//                                                  child: Row(
//                                                    children: <Widget>[
//                                                      Icon(
//                                                        Icons.date_range,
//                                                        size: 18.0,
//                                                        color: Colors.teal,
//                                                      ),
//                                                      Text(
//                                                        " $_date",
//                                                        style: TextStyle(
//                                                            color: Colors.teal,
//                                                            fontWeight: FontWeight.bold,
//                                                            fontSize: 18.0),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                )
//                                              ],
//                                            ),
//                                            Text(
//                                              "  Data Início",
//                                              style: TextStyle(
//                                                  color: Colors.teal,
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 12.0),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                      color: Colors.white,
//                                    ),
//                                    SizedBox(
//                                      height: 20.0,
//                                    ),
//                                    RaisedButton(
//                                      shape: RoundedRectangleBorder(
//                                          borderRadius: BorderRadius.circular(5.0)),
//                                      elevation: 4.0,
//                                      onPressed: () {
//                                        DatePicker.showTimePicker(context,
//                                            theme: DatePickerTheme(
//                                              containerHeight: 210.0,
//                                            ),
//                                            showTitleActions: true, onConfirm: (time) {
//                                              _timeInicio = '${time.hour} : ${time.minute}';
//                                              this.relatorioData.horarioInicial = '${time.hour} : ${time.minute}';
//                                              setState(() {});
//                                            }, currentTime: DateTime.now(), locale: LocaleType.pt);
//                                        setState(() {
//
//                                        });
//                                      },
//                                      child: Container(
//                                        alignment: Alignment.center,
//                                        height: 50.0,
//                                        child: Row(
//                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Row(
//                                              children: <Widget>[
//                                                Container(
//                                                  child: Row(
//                                                    children: <Widget>[
//                                                      Icon(
//                                                        Icons.access_time,
//                                                        size: 18.0,
//                                                        color: Colors.teal,
//                                                      ),
//                                                      Text(
//                                                        " $_timeInicio",
//                                                        style: TextStyle(
//                                                            color: Colors.teal,
//                                                            fontWeight: FontWeight.bold,
//                                                            fontSize: 18.0),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                )
//                                              ],
//                                            ),
//                                            Text(
//                                              "  Horário Início",
//                                              style: TextStyle(
//                                                  color: Colors.teal,
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 12.0),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                      color: Colors.white,
//                                    ),
//                                    SizedBox(
//                                      height: 20.0,
//                                    ),
//                                    RaisedButton(
//                                      shape: RoundedRectangleBorder(
//                                          borderRadius: BorderRadius.circular(5.0)),
//                                      elevation: 4.0,
//                                      onPressed: () {
//                                        DatePicker.showTimePicker(context,
//                                            theme: DatePickerTheme(
//                                              containerHeight: 210.0,
//                                            ),
//                                            showTitleActions: true, onConfirm: (time) {
//                                              _timeFinal = '${time.hour} : ${time.minute}';
//                                              this.relatorioData.horarioFinal = '${time.hour} : ${time.minute}';
//                                              setState(() {});
//                                            }, currentTime: DateTime.now(), locale: LocaleType.pt);
//                                        setState(() {
//
//                                        });
//                                      },
//                                      child: Container(
//                                        alignment: Alignment.center,
//                                        height: 50.0,
//                                        child: Row(
//                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Row(
//                                              children: <Widget>[
//                                                Container(
//                                                  child: Row(
//                                                    children: <Widget>[
//                                                      Icon(
//                                                        Icons.access_time,
//                                                        size: 18.0,
//                                                        color: Colors.teal,
//                                                      ),
//                                                      Text(
//                                                        " $_timeFinal",
//                                                        style: TextStyle(
//                                                            color: Colors.teal,
//                                                            fontWeight: FontWeight.bold,
//                                                            fontSize: 18.0),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                )
//                                              ],
//                                            ),
//                                            Text(
//                                              "  Horário Final",
//                                              style: TextStyle(
//                                                  color: Colors.teal,
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 12.0),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                      color: Colors.white,
//                                    )
//                                  ],
//                                ),
//                              ),
//                              Padding(
//                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                                child: TextFormField(
//                                  onChanged: (text) {
//                                    this.relatorioData.data = text;
//                                  },
//                                  inputFormatters: [maskDataInputFormatter],
//                                  validator: (value) {
//                                    if (value.isEmpty) {
//                                      return 'Campo Vazio!';
//                                    }
//                                    return null;
//                                  },
//                                  keyboardType: TextInputType.number,
//                                  initialValue: this.relatorioData.data == null ? '' : this.relatorioData.data,
//                                  decoration: new InputDecoration(
//                                      labelText: "Data",
//                                      fillColor: Colors.white,
//                                      border: new OutlineInputBorder(
//                                          borderRadius:
//                                          new BorderRadius.circular(2.0),
//                                          borderSide: new BorderSide())),
////                                  controller: dataController,
//                                ),
//                              ),
//                              Padding(
//                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                                child: TextFormField(
//                                  onChanged: (text) {
//                                    this.relatorioData.horarioInicial = text;
//                                  },
//                                  initialValue: this.relatorioData.horarioInicial == null ? '' : this.relatorioData.horarioInicial,
//                                  inputFormatters: [maskHorarioInputFormatter],
//                                  validator: (value) {
//                                    if (value.isEmpty) {
//                                      return 'Campo Vazio!';
//                                    }
//                                    return null;
//                                  },
//                                  keyboardType: TextInputType.number,
//                                  decoration: new InputDecoration(
//                                      labelText: "Horário Inicial",
//                                      fillColor: Colors.white,
//                                      border: new OutlineInputBorder(
//                                          borderRadius:
//                                          new BorderRadius.circular(2.0),
//                                          borderSide: new BorderSide())),
////                                  controller: horarioInicialController,
//                                ),
//                              ),
//                              Padding(
//                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                                child: TextFormField(
//                                  onChanged: (text) {
//                                    this.relatorioData.horarioFinal = text;
//                                  },
//                                  initialValue: this.relatorioData.horarioFinal == null ? '' : this.relatorioData.horarioFinal,
//                                  keyboardType: TextInputType.number,
//                                  inputFormatters: [maskHorarioInputFormatter],
//                                  validator: (value) {
//                                    if (value.isEmpty) {
//                                      return 'Campo Vazio!';
//                                    }
//                                    return null;
//                                  },
//                                  decoration: new InputDecoration(
//                                      labelText: "Horário Final",
//                                      fillColor: Colors.white,
//                                      border: new OutlineInputBorder(
//                                          borderRadius:
//                                          new BorderRadius.circular(2.0),
//                                          borderSide: new BorderSide())),
////                                  controller: horarioFinalController,
//                                ),
//                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    this.relatorioData.kmInicial = text;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Campo Vazio!';
                                    }
                                    return null;
                                  },
                                  initialValue: this.relatorioData.kmInicial == null ? '' : this.relatorioData.kmInicial,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                      labelText: "Km Inicial",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
//                                  controller: kmInicialController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    this.relatorioData.kmFinal = text;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Campo Vazio!';
                                    }
                                    return null;
                                  },
                                  initialValue: this.relatorioData.kmFinal == null ? '' : this.relatorioData.kmFinal,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                      labelText: "Km Final",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
//                                  controller: kmFinalController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    this.relatorioData.kmTrabalho = text;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Campo Vazio!';
                                    }
                                    return null;
                                  },
                                  initialValue: this.relatorioData.kmTrabalho == null ? '' : this.relatorioData.kmTrabalho,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                      labelText: "Km Trabalho",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
//                                  controller: kmTrabalhoController,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    this.relatorioData.kmParticular = text;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Campo Vazio!';
                                    }
                                    return null;
                                  },
                                  initialValue: this.relatorioData.kmParticular == null ? '' : this.relatorioData.kmParticular,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                      labelText: "Km Particular",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(2.0),
                                          borderSide: new BorderSide())),
//                                  controller: kmParticularController,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                                  child: TextFormField(
                                    onChanged: (text) {
                                      this.relatorioData.obs = text;
                                    },
                                    initialValue: this.relatorioData.obs == null ? '' : this.relatorioData.obs,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 10,
                                    decoration: new InputDecoration(
                                        labelText: "Observações",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(2.0),
                                            borderSide: new BorderSide())),
//                                    controller: obsController,
                                  ))
                            ],
                          )),
                    )
                  ],
                ),
              ),
              //Produtos
              Container(
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 0.0),
                      itemCount: model.multiDataProdutoSelecionado.length,
                      itemBuilder: (context, index) {
                        return singleItemList(
                            model, index);
                      })
              ),
              Container(
                child: ScopedModelDescendant<UserModel>(
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
                                          MaterialPageRoute(builder: (context)=> CameraScreen(this.relatorioData.cs))
                                      );
                                    },
                                    textColor: Colors.white,
                                    child: Text("Adicionar Foto",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontSize: 12)),
                                  )),
                            ),
                            Expanded(
                                child: ListView.builder(
                                        padding: EdgeInsets.only(top: 0.0),
                                        itemCount: model.multiDataFotoResponse.length,
                                        itemBuilder: (context, index) {
                                          return MenuFotoTile(this.relatorioData.cs, model.multiDataFotoResponse[index]);
                                        })
                            )
                          ],
                        ),
                      );
                    }
                ),
              )
            ],
          ),
        ),
      );
    });

  }
}
