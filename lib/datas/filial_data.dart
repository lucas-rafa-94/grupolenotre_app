class FilialData {

    String _cs;
    String _ativa;
    String _cnpj;
    String _razaoSocial;
    String _nomeFantasia;
    String _tipoContribuinte;
    String _inscricaoEstadual;
    String _inscricaoMunicipal;
    String _cep;
    String _logradouro;
    String _numero;
    String _complemento;
    String _bairro;
    String _cidade;
    String _uf;
    String _fone;
    String _celular;
    String _whatsapp;
    String _website;
    String _facebook;
    String _instagram;
    String _obs;
    String _regTributario;
    String _aPis;
    String _aCofins;
    String _aCS;
    String _aIR;
    String _emails;
    String _dataCadastro;
    String _dataAtualizacao;


    String get cs => _cs;

    set cs(String value) {
      _cs = value;
    }

    FilialData();

    FilialData.fromMap(Map<String, dynamic> data) {
      _cs = data['cs'];
      _ativa = data['ativa'];
      _cnpj = data['cnpj'];
      _razaoSocial = data['razaoSocial'];
      _nomeFantasia = data['nomeFantasia'];
      _tipoContribuinte = data['tipoContribuinte'];
      _inscricaoEstadual = data['inscricaoEstadual'];
      _inscricaoMunicipal = data['inscricaoMunicipal'];
      _cep = data['cep'];
      _logradouro = data['logradouro'];
      _numero = data['numero'];
      _complemento = data['complemento'];
      _bairro = data['bairro'];
      _cidade = data['cidade'];
      _uf = data['uf'];
      _fone = data['fone'];
      _celular = data['celular'];
      _whatsapp = data['whatsapp'];
      _website = data['website'];
      _facebook = data['facebook'];
      _instagram = data['instagram'];
      _obs = data['obs'];
      _regTributario = data['regTributario'];
      _aPis = data['aPis'];
      _aCofins = data['aCofins'];
      _aCS = data['aCS'];
      _aIR = data['aIR'];
      _emails = data['emails'];
      _dataCadastro = data['dataCadastro'];
      _dataAtualizacao = data['dataAtualizacao'];
    }

    Map<String, dynamic> toJson() => {
    'ativa': _ativa,
    'cnpj': _cnpj,
    'razaoSocial': _razaoSocial,
    'nomeFantasia': _nomeFantasia,
    'tipoContribuinte': _tipoContribuinte,
    'inscricaoEstadual': _inscricaoEstadual,
    'inscricaoMunicipal': _inscricaoMunicipal,
    'cep': _cep,
    'logradouro': _logradouro,
    'numero': _numero,
    'complemento': _complemento,
    'bairro': _bairro,
    'cidade': _cidade,
    'uf': _uf,
    'fone': _fone,
    'celular': _celular,
    'whatsapp': _whatsapp,
    'website': _website,
    'facebook': _facebook,
    'instagram': _instagram,
    'obs': _obs,
    'regTributario': _regTributario,
    'aPis': _aPis,
    'aCofins': _aCofins,
    'aCS': _aCS,
    'aIR': _aIR,
    'emails': _emails,
    'dataCadastro': _dataCadastro,
    'dataAtualizacao': _dataAtualizacao
    };

    String get ativa => _ativa;

    set ativa(String value) {
      _ativa = value;
    }

    String get cnpj => _cnpj;

    set cnpj(String value) {
      _cnpj = value;
    }

    String get razaoSocial => _razaoSocial;

    set razaoSocial(String value) {
      _razaoSocial = value;
    }

    String get nomeFantasia => _nomeFantasia;

    set nomeFantasia(String value) {
      _nomeFantasia = value;
    }

    String get tipoContribuinte => _tipoContribuinte;

    set tipoContribuinte(String value) {
      _tipoContribuinte = value;
    }

    String get inscricaoEstadual => _inscricaoEstadual;

    set inscricaoEstadual(String value) {
      _inscricaoEstadual = value;
    }

    String get inscricaoMunicipal => _inscricaoMunicipal;

    set inscricaoMunicipal(String value) {
      _inscricaoMunicipal = value;
    }

    String get cep => _cep;

    set cep(String value) {
      _cep = value;
    }

    String get logradouro => _logradouro;

    set logradouro(String value) {
      _logradouro = value;
    }

    String get numero => _numero;

    set numero(String value) {
      _numero = value;
    }

    String get complemento => _complemento;

    set complemento(String value) {
      _complemento = value;
    }

    String get bairro => _bairro;

    set bairro(String value) {
      _bairro = value;
    }

    String get cidade => _cidade;

    set cidade(String value) {
      _cidade = value;
    }

    String get uf => _uf;

    set uf(String value) {
      _uf = value;
    }

    String get fone => _fone;

    set fone(String value) {
      _fone = value;
    }

    String get celular => _celular;

    set celular(String value) {
      _celular = value;
    }

    String get whatsapp => _whatsapp;

    set whatsapp(String value) {
      _whatsapp = value;
    }

    String get website => _website;

    set website(String value) {
      _website = value;
    }

    String get facebook => _facebook;

    set facebook(String value) {
      _facebook = value;
    }

    String get instagram => _instagram;

    set instagram(String value) {
      _instagram = value;
    }

    String get obs => _obs;

    set obs(String value) {
      _obs = value;
    }

    String get regTributario => _regTributario;

    set regTributario(String value) {
      _regTributario = value;
    }

    String get aPis => _aPis;

    set aPis(String value) {
      _aPis = value;
    }

    String get aCofins => _aCofins;

    set aCofins(String value) {
      _aCofins = value;
    }

    String get aCS => _aCS;

    set aCS(String value) {
      _aCS = value;
    }

    String get aIR => _aIR;

    set aIR(String value) {
      _aIR = value;
    }

    String get emails => _emails;

    set emails(String value) {
      _emails = value;
    }

    String get dataCadastro => _dataCadastro;

    set dataCadastro(String value) {
      _dataCadastro = value;
    }

    String get dataAtualizacao => _dataAtualizacao;

    set dataAtualizacao(String value) {
      _dataAtualizacao = value;
    }

}