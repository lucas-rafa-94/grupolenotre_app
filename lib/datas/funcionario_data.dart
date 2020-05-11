class FuncionarioData{
  String _cs;
  String _nome;
  String _ativo;

  FuncionarioData();

  String get ativo => _ativo;

  set ativo(String value) {
    _ativo = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get cs => _cs;

  set cs(String value) {
    _cs = value;
  }

  FuncionarioData.fromMap(Map<String, dynamic> data) {
    _cs = data['cs'];
    _nome = data['nome'];
    _ativo = data['ativo'];

  }

  Map<String, dynamic> toJson() => {
    'cs': _cs,
    'nome': _nome,
    'ativo': _ativo,
  };

}