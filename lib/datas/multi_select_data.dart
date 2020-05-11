class MultiSelectData {
  String _display;
  String _value;

  MultiSelectData();

  String get value => _value;

  set value(String value) {
    _value = value;
  }

  String get display => _display;

  set display(String value) {
    _display = value;
  }

  Map<String, dynamic> toJson() => {
    'display': _display,
    'value': _value
  };

  MultiSelectData.fromMap(Map<String, dynamic> data) {
    _display = data['display'];
    _value = data['value'];
  }


}