class ObraData {
  String _cs;
  String _nomeObra;
  String _ativa;

  ObraData();


  String get cs => _cs;

  set cs(String value) {
    _cs = value;
  }

  ObraData.fromMap(Map<String, dynamic> data) {
    _cs = data['cs'];
    _nomeObra = data['nomeObra'];
    _ativa = data['ativa'];

  }

  Map<String, dynamic> toJson() => {
        'cs': _cs,
        'nomeObra': _nomeObra,
        'ativa': _ativa,
      };

  String get nomeObra => _nomeObra;

  set nomeObra(String value) {
    _nomeObra = value;
  }

  String get ativa => _ativa;

  set ativa(String value) {
    _ativa = value;
  }
}
