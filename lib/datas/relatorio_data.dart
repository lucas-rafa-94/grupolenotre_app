import 'package:grupolenotre/datas/produto_data.dart';

class NomeFuncionario {
  String nome;


  NomeFuncionario({this.nome});



  factory NomeFuncionario.fromJson(Map<String, dynamic> parsedJson){
    return NomeFuncionario(
        nome:parsedJson['nome'],
    );
  }

  Map<String, dynamic> toJson() => {
    'nome': nome,
  };


}

class ServicoResponse {
  String cs;
  String descricao;


  ServicoResponse({this.cs, this.descricao});


  factory ServicoResponse.fromJson(Map<String, dynamic> parsedJson){
    return ServicoResponse(
      cs:parsedJson['cs'], descricao:parsedJson['descricao']
    );
  }

  Map<String, dynamic> toJson() => {
    'cs': cs,
    'descricao': descricao,
  };


}

class ProdutoRetorno {
  String csProduto;
  String nome;
  String unidadeMedida;
  String quantidade;

  ProdutoRetorno({this.csProduto, this.nome, this.unidadeMedida,
      this.quantidade});

  factory ProdutoRetorno.fromJson(Map<String, dynamic> parsedJson){
    return ProdutoRetorno(
      nome:parsedJson['nome'],
      csProduto:parsedJson['csProduto'],
      unidadeMedida:parsedJson['unidadeMedida'],
      quantidade:parsedJson['quantidade'],
    );
  }

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'csProduto': csProduto,
    'unidadeMedida': unidadeMedida,
    'quantidade': quantidade,
  };

}

class ServicoRequest {
  String _cs;

  ServicoRequest();

  String get cs => _cs;

  set cs(String value) {
    _cs = value;
  }

  Map<String, dynamic> toJson() => {
    'cs': _cs,
  };

}

class RelatorioData {

  String _cs;
  String _csFuncionario;
  String _operador;
  String _csObra;
  String _obra;
  String _csCliente;
  String _filial;
  String _csFilial;
  String _kmInicial;
  String _kmFinal;
  String _kmTrabalho;
  String _kmParticular;
  String _dataRelatorio;
  String _valida;
  String _deslocamento;
  String _funcionariosRequest;
  List<NomeFuncionario> _funcionariosRetorno;
  String _horarioInicial;
  String _horarioFinal;
  List<ServicoRequest> _servicosRequest;
  List<ServicoResponse> _servicosResponse;
  String _data;
  List<ProdutoRetorno> _produtos;
  List<ProdutoSelecionado> _produtosRequest;
  String _obs;
  String _dataCadastro;
  String _dataAtualizacao;


  List<ServicoRequest> get servicosRequest => _servicosRequest;

  set servicosRequest(List<ServicoRequest> value) {
    _servicosRequest = value;
  }


  List<ServicoResponse> get servicosResponse => _servicosResponse;

  set servicosResponse(List<ServicoResponse> value) {
    _servicosResponse = value;
  }

  String get data => _data;




  String get funcionariosRequest => _funcionariosRequest;

  set funcionariosRequest(String value) {
    _funcionariosRequest = value;
  }

  set data(String value) {
    _data = value;
  }

  String get cs => _cs;


  List<ProdutoRetorno> get produtos => _produtos;

  set produtos(List<ProdutoRetorno> value) {
    _produtos = value;
  }

  String get obra => _obra;

  set obra(String value) {
    _obra = value;
  }

  String get csFilial => _csFilial;

  set csFilial(String value) {
    _csFilial = value;
  }

  set cs(String value) {
    _cs = value;
  }

  RelatorioData();

 factory RelatorioData.fromMap(Map<String, dynamic> data) {


    var list = data['funcionarios'] as List;
    List<NomeFuncionario> funcionariosList = list.map((i) => NomeFuncionario.fromJson(i)).toList();

    var listProd = data['produtos'] as List;
    List<ProdutoRetorno> produtosList = listProd.map((i) => ProdutoRetorno.fromJson(i)).toList();

    var listServico = data['servicos'] as List;
    List<ServicoResponse> servicosList = listServico.map((i) => ServicoResponse.fromJson(i)).toList();


    RelatorioData relatorioData = new RelatorioData();

    relatorioData._obra = data['obra'];
    relatorioData._data = data['data'];
    relatorioData._csFuncionario = data['csFuncionario'];
    relatorioData._operador = data['operador'];
    relatorioData._filial = data['filial'];
    relatorioData._cs = data['cs'];
    relatorioData._csObra = data['csObra'];
    relatorioData._csFilial = data['csFilial'];
    relatorioData._csCliente = data['csFilcsClienteial'];
    relatorioData._kmInicial = data['kmInicial'];
    relatorioData._kmFinal = data['kmFinal'];
    relatorioData._kmTrabalho = data['kmTrabalho'];
    relatorioData._kmParticular = data['kmParticular'];
    relatorioData._dataRelatorio = data['dataRelatorio'];
    relatorioData._valida = data['valida'];
    relatorioData._deslocamento = data['deslocamento'];
    relatorioData._horarioInicial = data['horarioInicial'];
    relatorioData._horarioFinal = data['horarioFinal'];
    relatorioData._obs = data['obs'];
    relatorioData._dataCadastro = data['dataCadastro'];
    relatorioData._dataAtualizacao = data['dataAtualizacao'];
    relatorioData._funcionariosRetorno = funcionariosList;
    relatorioData._produtos = produtosList;
    relatorioData._servicosResponse = servicosList;

    return relatorioData;
  }

  Map<String, dynamic> toJson() => {
    'operador': _csFuncionario,
    'filial': _csFilial,
    'obra': _csObra,
    'kmInicial': _kmInicial,
    'kmFInal': _kmFinal,
    'kmTrabalho': _kmTrabalho,
    'kmParticular': _kmParticular,
    'dataRelatorio': _data,
    'valida': _valida,
    'horarioInicial': _horarioInicial,
    'horarioFinal': _horarioFinal,
    'servicos': _servicosRequest,
    'produtos': _produtosRequest,
    'obs': _obs,
    'funcionarios': _funcionariosRequest,
    'valida': _valida
  };

  String get csFuncionario => _csFuncionario;

  set csFuncionario(String value) {
    _csFuncionario = value;
  }

  String get operador => _operador;

  set operador(String value) {
    _operador = value;
  }

  String get csObra => _csObra;

  set csObra(String value) {
    _csObra = value;
  }

  String get csCliente => _csCliente;

  set csCliente(String value) {
    _csCliente = value;
  }

  String get filial => _filial;

  set filial(String value) {
    _filial = value;
  }

  String get kmInicial => _kmInicial;

  set kmInicial(String value) {
    _kmInicial = value;
  }

  String get kmFinal => _kmFinal;

  set kmFinal(String value) {
    _kmFinal = value;
  }

  String get kmTrabalho => _kmTrabalho;

  set kmTrabalho(String value) {
    _kmTrabalho = value;
  }

  String get kmParticular => _kmParticular;

  set kmParticular(String value) {
    _kmParticular = value;
  }

  String get dataRelatorio => _dataRelatorio;

  set dataRelatorio(String value) {
    _dataRelatorio = value;
  }

  String get valida => _valida;

  set valida(String value) {
    _valida = value;
  }

  String get deslocamento => _deslocamento;

  set deslocamento(String value) {
    _deslocamento = value;
  }


  String get horarioInicial => _horarioInicial;

  set horarioInicial(String value) {
    _horarioInicial = value;
  }

  String get horarioFinal => _horarioFinal;

  set horarioFinal(String value) {
    _horarioFinal = value;
  }



  String get obs => _obs;

  set obs(String value) {
    _obs = value;
  }

  String get dataCadastro => _dataCadastro;

  set dataCadastro(String value) {
    _dataCadastro = value;
  }

  String get dataAtualizacao => _dataAtualizacao;

  set dataAtualizacao(String value) {
    _dataAtualizacao = value;
  }

  List<NomeFuncionario> get funcionariosRetorno => _funcionariosRetorno;

  set funcionariosRetorno(List<NomeFuncionario> value) {
    _funcionariosRetorno = value;
  }

  List<ProdutoSelecionado> get produtosRequest => _produtosRequest;

  set produtosRequest(List<ProdutoSelecionado> value) {
    _produtosRequest = value;
  }

}

class FotosResponse{
  String _cs;
  String _identificacao;
  String _tipo;
  String _ordem;
  String _bytes;
  String _url;
  String _dataCadastro;

  FotosResponse();


  FotosResponse.fromMap(Map<String, dynamic> data) {
    _cs = data['cs'];
    _identificacao = data['identificacao'];
    _tipo = data['tipo'];
    _ordem = data['ordem'];
    _bytes = data['bytes'];
    _url = data['url'];
    _dataCadastro = data['dataCadastro'];

  }


  Map<String, dynamic> toJson() => {
    'cs': _cs,
    'identificacao': _identificacao,
    'tipo': _tipo,
    'ordem': _ordem,
    'bytes': _bytes,
    'dataCadastro': _dataCadastro
  };

  String get dataCadastro => _dataCadastro;

  set dataCadastro(String value) {
    _dataCadastro = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get bytes => _bytes;

  set bytes(String value) {
    _bytes = value;
  }

  String get ordem => _ordem;

  set ordem(String value) {
    _ordem = value;
  }

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  String get identificacao => _identificacao;

  set identificacao(String value) {
    _identificacao = value;
  }

  String get cs => _cs;

  set cs(String value) {
    _cs = value;
  }





}