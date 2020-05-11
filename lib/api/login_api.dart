import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginApi {

  String token = "";

  String returnToken(String email, String password){
    _makePostRequest(email, password);
    return token;
  }

  Future<Map> _makePostRequest(String email, String password) async {
    String url = 'https://api.grupolenotre.com/login';
    Map<String, String> headers = {"Content-type": "application/json"};
    String dados =
        '{"email": "${email}", "senha": "${password}"}';

    http.Response response = await http.post(url,
        headers: headers, body: dados);
    int statusCode = response
        .statusCode;

    token = json.decode(response.body)['usuario']['token'];

    return json.decode(response.body);
  }
}