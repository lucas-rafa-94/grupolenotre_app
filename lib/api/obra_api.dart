import 'dart:io';
import 'package:http/http.dart' as http;

class ObraApi{
  Future<String> makeGetAllRequest(String token) async {

    String url = 'https://api.grupolenotre.com/obras/';

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