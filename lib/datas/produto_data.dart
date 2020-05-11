class ProdutoData {
  String _cs;
  String _nomePopular;
  String _nomeMaterial;
  String _ativo;


  ProdutoData();

  ProdutoData.fromMap(Map<String, dynamic> data) {
    _cs = data['cs'];
    _nomePopular = data['nomePopular'];
    _ativo = data['ativo'];
    _nomeMaterial = data['nomeMaterial'];

  }

  Map<String, dynamic> toJson() => {
    'cs': _cs,
    'nomeObra': _nomePopular,
    'ativa': _ativo,
    'nomeMaterial': _nomeMaterial,
  };


  String get nomeMaterial => _nomeMaterial;

  set nomeMaterial(String value) {
    _nomeMaterial = value;
  }

  String get cs => _cs;

  set cs(String value) {
    _cs = value;
  }

  String get nomePopular => _nomePopular;

  String get ativo => _ativo;

  set ativo(String value) {
    _ativo = value;
  }

  set nomePopular(String value) {
    _nomePopular = value;
  }


}


class ProdutoSelecionado{
  String _nome;
  String _qtd;

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get qtd => _qtd;

  set qtd(String value) {
    _qtd = value;
  }

  ProdutoSelecionado();

  Map<String, dynamic> toJson() => {
    'nome': _nome,
    'qtd': _qtd
  };

}