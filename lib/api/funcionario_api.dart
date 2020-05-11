import 'dart:io';
import 'package:http/http.dart' as http;

class FuncionarioApi{
  Future<String> makeGetAllRequest(String token) async {

    String url = 'https://api.grupolenotre.com/funcionarios';

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Basic $token",
    };

    http.Response response = await http.get(url,
        headers: headers);
    int statusCode = response
        .statusCode;


    return response.body;

  }
}