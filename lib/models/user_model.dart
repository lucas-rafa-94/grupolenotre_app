import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:grupolenotre/datas/filial_data.dart';
import 'package:grupolenotre/datas/funcionario_data.dart';
import 'package:grupolenotre/datas/multi_select_data.dart';
import 'package:grupolenotre/datas/obra_data.dart';
import 'package:grupolenotre/datas/produto_data.dart';
import 'package:grupolenotre/datas/relatorio_data.dart';
import 'package:grupolenotre/datas/servicos_data.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {

    List multiData = [];
    List multiDataServico=[];
    List<FilialData> multiDataFilial = new List();
    List<ProdutoSelecionado> multiDataProdutoSelecionado = new List();
    List<ObraData> multiDataObra = new List();
    List<ProdutoData> multiDataProduto = new List();
    List<FotosResponse> multiDataFotoResponse= new List();
    bool isLoading = false;

    int codigoResposta = 0;

    String token = '';
    String userName = '';


    void signIn({@required String email, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFailure }){
      _makePostLoginRequest(email: email, pass: pass, onSuccess: onSuccess, onFailure: onFailure );
    }

    void filialUpdate({@required FilialData filialData, @required Future<void> Function() onSuccess, @required Future<void> Function() onFailure }){
      _makeFilialPutRequest(filialData, onSuccess, onFailure);
    }

    void filialCreate({@required FilialData filialData, @required Future<void> Function() onSuccess, @required Future<void> Function() onFailure }){
      _makeFilialPostRequest(filialData, onSuccess, onFailure);
    }

    void filialDelete({@required FilialData filialData, @required Future<void> Function() onSuccess, @required Future<void> Function() onFailure }){
      _makeFilialDeleteRequest(filialData, onSuccess, onFailure);
    }

    void relatorioUpdate({@required RelatorioData relatorioData, @required Future<void> Function() onSuccess, @required Future<void> Function() onFailure }){
      _makeRelatorioPutRequest(relatorioData, onSuccess, onFailure);
    }

    void relatorioCreate({@required RelatorioData relatorioData, @required Future<void> Function() onSuccess, @required Future<void> Function() onFailure }){
      _makeRelatorioPostRequest(relatorioData, onSuccess, onFailure);
    }

    void relatorioDelete({@required RelatorioData relatorioData, @required Future<void> Function() onSuccess, @required Future<void> Function() onFailure }){
      _makeRelatorioDeleteRequest(relatorioData, onSuccess, onFailure);
    }

    void getDataApi({@required String cs, @required Future<void> Function() onSuccess, @required Future<void> Function() onFailure }){
      _makeDataGetRequest(cs, onSuccess, onFailure);
    }

    void clear(){
      multiData.clear();
      multiDataServico.clear();
      multiDataFilial.clear();
      multiDataObra.clear();
      multiDataProdutoSelecionado.clear();
      multiDataProduto.clear();
    }

    void getDataCreate({@required Future<void> Function() onSuccess, @required Future<void> Function() onFailure }){
      _makeDataGetRequestCreate( onSuccess, onFailure);
    }

    Future<String> _makeDataGetRequestCreate(  Future<void> Function() onSuccess, Future<void> Function() onFailure   ) async {
      multiData.clear();
      multiDataServico.clear();
      multiDataFilial.clear();
      multiDataObra.clear();
      multiDataProdutoSelecionado.clear();
      multiDataProduto.clear();
      multiDataFotoResponse.clear();

      isLoading = true;
      notifyListeners();

      //GET FUNCIONARIOS

      String url = 'https://api.grupolenotre.com/funcionarios';

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Basic $token",
      };

      http.Response response = await http.get(url,
          headers: headers);
      int statusCode = response
          .statusCode;

      List map = json.decode(response.body)['registros'];

      for(var i = 0; i < map.length; i++){
        MultiSelectData multiSelectData = new MultiSelectData();
        multiSelectData.display = FuncionarioData.fromMap(json.decode(response.body)['registros'][i]).nome;
        multiSelectData.value = FuncionarioData.fromMap(json.decode(response.body)['registros'][i]).cs;
        multiData.add(multiSelectData.toJson());
      }

      //GET SERVICOS

      String urlServicos = 'https://api.grupolenotre.com/relatorio_servicos';


      http.Response responseServicos = await http.get(urlServicos,
          headers: headers);
      int statusCodeServicos = response
          .statusCode;

      List mapServicos = json.decode(responseServicos.body)['registros'];

      for(var i = 0; i < mapServicos.length; i++){
        MultiSelectData multiSelectData = new MultiSelectData();
        multiSelectData.display = ServicoData.fromMap(json.decode(responseServicos.body)['registros'][i]).descricao;
        multiSelectData.value = ServicoData.fromMap(json.decode(responseServicos.body)['registros'][i]).cs;
        multiDataServico.add(multiSelectData.toJson());
      }


      //GET FILIAIS

      String urlFilial = 'https://api.grupolenotre.com/filiais/';


      http.Response responseFilial = await http.get(urlFilial,
          headers: headers);
      int statusCodeFilial = response
          .statusCode;


      List mapFiliais = json.decode(responseFilial.body)['registros'];

      for (var i = 0; i < mapFiliais.length; i++) {
        multiDataFilial.add(FilialData.fromMap(json.decode(responseFilial.body)['registros'][i]));
      }


      //GET Obras

      String urlObras = 'https://api.grupolenotre.com/obras/';


      http.Response responseObras = await http.get(urlObras,
          headers: headers);
      int statusCodeObras = response
          .statusCode;


      List mapObras = json.decode(responseObras.body)['registros'];

      for (var i = 0; i < mapObras.length; i++) {
        multiDataObra.add(ObraData.fromMap(json.decode(responseObras.body)['registros'][i]));
      }


      //Produtos


      String urlProdutos = 'https://api.grupolenotre.com/produtos/';


      http.Response responseProdutos = await http.get(urlProdutos,
          headers: headers);
      int statusCodeProdutos = response
          .statusCode;


      List mapProdutos = json.decode(responseProdutos.body)['registros'];

      for (var i = 0; i < mapProdutos.length; i++) {
        multiDataProduto.add(ProdutoData.fromMap(json.decode(responseProdutos.body)['registros'][i]));
      }

      for(var v = 0; v < multiDataProduto.length; v++ ){
        ProdutoSelecionado produtoSelecionado = new ProdutoSelecionado();
        produtoSelecionado.nome = multiDataProduto[v].nomeMaterial;
        produtoSelecionado.qtd = '0';
        multiDataProdutoSelecionado.add(produtoSelecionado);
      }


      //Fotos

//      String urlFotos = 'https://api.grupolenotre.com/arquivos_relatorios_diarios/' +  cs + '/imagens';
//
//      print(urlFotos);
//
//      http.Response responseFotos = await http.get(urlFotos,
//          headers: headers);
//      int statusCodeImagens = response
//          .statusCode;
//
//      print('teste 0');
//
//      List mapFotos = json.decode(responseFotos.body)['registros'];
//
//      for (var i = 0; i < mapFotos.length; i++) {
//        multiDataFotoResponse.add(FotosResponse.fromMap(json.decode(responseFotos.body)['registros'][i]));
//      }

//      for(var v = 0; v < multiDataFotoResponse.length; v++ ){
//        ProdutoSelecionado produtoSelecionado = new ProdutoSelecionado();
//        produtoSelecionado.nome = multiDataProduto[v].nomeMaterial;
//        produtoSelecionado.qtd = '0';
//        multiDataProdutoSelecionado.add(produtoSelecionado);
//      }

//      print('teste 1');

      isLoading = false;
      onSuccess();
      notifyListeners();


      return response.body;


    }

    Future<String> _makeDataGetRequest( String cs, Future<void> Function() onSuccess, Future<void> Function() onFailure   ) async {
      multiData.clear();
      multiDataServico.clear();
      multiDataFilial.clear();
      multiDataObra.clear();
      multiDataProdutoSelecionado.clear();
      multiDataProduto.clear();
      multiDataFotoResponse.clear();

      isLoading = true;
      notifyListeners();

      //GET FUNCIONARIOS

      String url = 'https://api.grupolenotre.com/funcionarios';

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Basic $token",
      };

      http.Response response = await http.get(url,
          headers: headers);
      int statusCode = response
          .statusCode;

      List map = json.decode(response.body)['registros'];

      for(var i = 0; i < map.length; i++){
        MultiSelectData multiSelectData = new MultiSelectData();
        multiSelectData.display = FuncionarioData.fromMap(json.decode(response.body)['registros'][i]).nome;
        multiSelectData.value = FuncionarioData.fromMap(json.decode(response.body)['registros'][i]).cs;
        multiData.add(multiSelectData.toJson());
      }

      //GET SERVICOS

      String urlServicos = 'https://api.grupolenotre.com/relatorio_servicos';


      http.Response responseServicos = await http.get(urlServicos,
          headers: headers);
      int statusCodeServicos = response
          .statusCode;

      List mapServicos = json.decode(responseServicos.body)['registros'];

      for(var i = 0; i < mapServicos.length; i++){
        MultiSelectData multiSelectData = new MultiSelectData();
        multiSelectData.display = ServicoData.fromMap(json.decode(responseServicos.body)['registros'][i]).descricao;
        multiSelectData.value = ServicoData.fromMap(json.decode(responseServicos.body)['registros'][i]).cs;
        multiDataServico.add(multiSelectData.toJson());
      }


      //GET FILIAIS

      String urlFilial = 'https://api.grupolenotre.com/filiais/';


      http.Response responseFilial = await http.get(urlFilial,
          headers: headers);
      int statusCodeFilial = response
          .statusCode;


      List mapFiliais = json.decode(responseFilial.body)['registros'];

      for (var i = 0; i < mapFiliais.length; i++) {
        multiDataFilial.add(FilialData.fromMap(json.decode(responseFilial.body)['registros'][i]));
      }


      //GET Obras

      String urlObras = 'https://api.grupolenotre.com/obras/';


      http.Response responseObras = await http.get(urlObras,
          headers: headers);
      int statusCodeObras = response
          .statusCode;


      List mapObras = json.decode(responseObras.body)['registros'];

      for (var i = 0; i < mapObras.length; i++) {
        multiDataObra.add(ObraData.fromMap(json.decode(responseObras.body)['registros'][i]));
      }


      //Produtos


      String urlProdutos = 'https://api.grupolenotre.com/produtos/';


      http.Response responseProdutos = await http.get(urlProdutos,
          headers: headers);
      int statusCodeProdutos = response
          .statusCode;


      List mapProdutos = json.decode(responseProdutos.body)['registros'];

      for (var i = 0; i < mapProdutos.length; i++) {
        multiDataProduto.add(ProdutoData.fromMap(json.decode(responseProdutos.body)['registros'][i]));
      }

      for(var v = 0; v < multiDataProduto.length; v++ ){
        ProdutoSelecionado produtoSelecionado = new ProdutoSelecionado();
        produtoSelecionado.nome = multiDataProduto[v].nomeMaterial;
        produtoSelecionado.qtd = '0';
        multiDataProdutoSelecionado.add(produtoSelecionado);
      }


      //Fotos

      String urlFotos = 'https://api.grupolenotre.com/arquivos_relatorios_diarios/' +  cs + '/imagens';



      http.Response responseFotos = await http.get(urlFotos,
          headers: headers);
      int statusCodeImagens = response
          .statusCode;



      List mapFotos = json.decode(responseFotos.body)['registros'];

      for (var i = 0; i < mapFotos.length; i++) {
        multiDataFotoResponse.add(FotosResponse.fromMap(json.decode(responseFotos.body)['registros'][i]));
      }

//      for(var v = 0; v < multiDataFotoResponse.length; v++ ){
//        ProdutoSelecionado produtoSelecionado = new ProdutoSelecionado();
//        produtoSelecionado.nome = multiDataProduto[v].nomeMaterial;
//        produtoSelecionado.qtd = '0';
//        multiDataProdutoSelecionado.add(produtoSelecionado);
//      }



      isLoading = false;
      onSuccess();
      notifyListeners();


      return response.body;


    }

    Future<String> _getFilialApi(Future<void> Function() onSuccess, Future<void> Function() onFailure   ) async {

      String url = 'https://api.grupolenotre.com/filiais/';

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Basic $token",
      };

      http.Response response = await http.get(url,
          headers: headers);
      int statusCode = response
          .statusCode;

      if (statusCode == 200)
      {

      }

      return response.body;
    }

    Future<Map> _makePostLoginRequest({@required String email, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFailure }) async {

      isLoading = true;
      notifyListeners();

      String url = 'https://api.grupolenotre.com/login';
      Map<String, String> headers = {"Content-type": "application/json"};
      String dados =
          '{"email": "${email}", "senha": "${pass}"}';
      http.Response response = await http.post(url,
          headers: headers,
          body: dados); // check the status code for the result
      int statusCode = response
          .statusCode; // this API passes back the id of the new item added to the body

      if (statusCode == 200) {
        codigoResposta = json.decode(response.body)['codigo'];
        if(codigoResposta == 10){
          token = json.decode(response.body)['usuario']['token'];
          userName = json.decode(response.body)['usuario']['nome'];
          isLoading = false;
          onSuccess();
          notifyListeners();
        }else if  (codigoResposta == 230 || codigoResposta == 200 ){
          isLoading = false;
          notifyListeners();
          onFailure();
        }
      }else{
        isLoading = false;
        notifyListeners();
        onFailure();
      }

      return json.decode(response.body);
    }

    Future<String> _makeFilialPutRequest(FilialData filialData, Future<void> Function() onSuccess, Future<void> Function() onFailure   ) async {
      isLoading = true;
      notifyListeners();

      String url = 'https://api.grupolenotre.com/filiais/${filialData.cs}';

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Basic ${token}",
      };



      http.Response response = await http.put(url,
          headers: headers, body: json.encode(filialData.toJson()));
      int statusCode = response
          .statusCode;


      if (statusCode == 200) {
        codigoResposta = json.decode(response.body)['codigo'];

        if(codigoResposta == 120){
          isLoading = false;
          onSuccess();
          notifyListeners();
        }else if  (codigoResposta == 220 ){
          isLoading = false;
          notifyListeners();
          onFailure();
        }
      }else{
        isLoading = false;
        notifyListeners();
        onFailure();
      }

      return response.body;
    }

    Future<String> _makeFilialDeleteRequest(FilialData filialData, Future<void> Function() onSuccess, Future<void> Function() onFailure   ) async {
      isLoading = true;
      notifyListeners();

      String url = 'https://api.grupolenotre.com/filiais/${filialData.cs}';

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Basic ${token}",
      };



      http.Response response = await http.delete(url,
          headers: headers);
      int statusCode = response
          .statusCode;



      if (statusCode == 200) {
        codigoResposta = json.decode(response.body)['codigo'];

        if(codigoResposta == 130){
          isLoading = false;
          onSuccess();
          notifyListeners();
        }else{
          isLoading = false;
          notifyListeners();
          onFailure();
        }
      }else{
        isLoading = false;
        notifyListeners();
        onFailure();
      }

      return response.body;
    }

    Future<String> _makeFilialPostRequest(FilialData filialData, Future<void> Function() onSuccess, Future<void> Function() onFailure   ) async {
      isLoading = true;
      notifyListeners();

      String url = 'https://api.grupolenotre.com/filiais';

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Basic ${token}",
      };


      http.Response response = await http.post(url,
          headers: headers, body: json.encode(filialData.toJson()));
      int statusCode = response
          .statusCode;



      if (statusCode == 200) {
        codigoResposta = json.decode(response.body)['codigo'];

        if(codigoResposta == 110){
          isLoading = false;
          onSuccess();
          notifyListeners();
        }else{
          isLoading = false;
          notifyListeners();
          onFailure();
        }
      }else{
        isLoading = false;
        notifyListeners();
        onFailure();
      }

      return response.body;
    }

    Future<String> _makeRelatorioPutRequest(RelatorioData relatorioData, Future<void> Function() onSuccess, Future<void> Function() onFailure   ) async {
      isLoading = true;
      notifyListeners();


      String url = 'https://api.grupolenotre.com/relatorios_diarios/${relatorioData.cs}';

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Basic ${token}",
      };


      relatorioData.valida = '1';
      relatorioData.csObra = 'ee8a1ea3d13dcc011d005d557f2f84f720200417202846';


      http.Response response = await http.put(url,
          headers: headers, body: json.encode(relatorioData.toJson()));
      int statusCode = response
          .statusCode;

//      isLoading = false;
//      notifyListeners();
//      onSuccess();

      if (statusCode == 200) {
        codigoResposta = json.decode(response.body)['codigo'];

        if(codigoResposta == 120){
          isLoading = false;
          onSuccess();
          notifyListeners();
        }else{
          isLoading = false;
          notifyListeners();
          onFailure();
        }
      }else{

      }


      return response.body;
    }

    Future<String> _makeRelatorioDeleteRequest(RelatorioData relatorioData, Future<void> Function() onSuccess, Future<void> Function() onFailure   ) async {
      isLoading = true;
      notifyListeners();

      String url = 'https://api.grupolenotre.com/relatorios_diarios/${relatorioData.cs}';

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Basic ${token}",
      };



      http.Response response = await http.delete(url,
          headers: headers);
      int statusCode = response
          .statusCode;


      if (statusCode == 200) {
        codigoResposta = json.decode(response.body)['codigo'];

        if(codigoResposta == 130){
          isLoading = false;
          onSuccess();
          notifyListeners();
        }else{
          isLoading = false;
          notifyListeners();
          onFailure();
        }
      }else{
        isLoading = false;
        notifyListeners();
        onFailure();
      }

      return response.body;
    }

    Future<String> _makeRelatorioPostRequest(RelatorioData relatorioData, Future<void> Function() onSuccess, Future<void> Function() onFailure   ) async {
      isLoading = true;
      notifyListeners();

      String url = 'https://api.grupolenotre.com/relatorios_diarios';

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Basic ${token}",
      };

      relatorioData.csFuncionario = "cd5985b259af922d329be61f03261ef320200331164850";
//      relatorioData.csFilial = "79c3fe0b7afc77b64c0498004648793c20131204173505";

      http.Response response = await http.post(url,
          headers: headers, body: json.encode(relatorioData.toJson()));

      int statusCode = response
          .statusCode;


      if (statusCode == 200) {
        codigoResposta = json.decode(response.body)['codigo'];

        if(codigoResposta == 110){
          isLoading = false;
          onSuccess();
          notifyListeners();
        }else{
          isLoading = false;
          notifyListeners();
          onFailure();
        }
      }else{
        isLoading = false;
        notifyListeners();
        onFailure();
      }

      return response.body;
    }



    void makePostFotoRequest(String cs, String path, Future<void> Function() onSuccess, Future<void> Function() onFailure ){
      _makePostFotoRequest(cs, path,  onSuccess, onFailure);
    }

    Future<String> _makePostFotoRequest(String cs, String path,  Future<void> Function() onSuccess, Future<void> Function() onFailure   ) async {

      isLoading = true;
      notifyListeners();
      String r = "";

      Map<String, String> headers = {
        HttpHeaders.authorizationHeader: "Basic ${token}"
      };

      var uri = Uri.parse('https://api.grupolenotre.com/arquivos_relatorios_diarios/' + cs );

      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath(
            'arquivo', path,
            contentType: MediaType.parse("image/png")));

      request.headers.addAll(headers);
      print(request.files[0]);

      print('envio foto: '+ uri.toString());
      print('envio foto: '+ request.toString());

      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      print('resposta foto: ' + respStr);

      if (response.statusCode == 200){
        isLoading = false;
        notifyListeners();
        r = 'Uploaded!';
        onSuccess();
      } else{
        isLoading = false;
        notifyListeners();
        r = 'Not Uploaded!';
        onFailure();
      }

      return r;
    }


}