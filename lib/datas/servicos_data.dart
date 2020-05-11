class ServicoData{
  String _cs;
  String _descricao;


  ServicoData();


  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get cs => _cs;

  set cs(String value) {
    _cs = value;
  }

  ServicoData.fromMap(Map<String, dynamic> data) {
    _cs = data['cs'];
    _descricao = data['descricao'];

  }

  Map<String, dynamic> toJson() => {
    'cs': _cs,
    'descricao': _descricao,
  };

}