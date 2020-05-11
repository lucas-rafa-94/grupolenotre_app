import 'dart:convert';
import 'dart:io';

import 'package:grupolenotre/datas/relatorio_data.dart';
import 'package:http/http.dart' as http;

class RelatorioApi {

  Future<String> makeGetAllRequest(String token) async {
    String url = 'https://api.grupolenotre.com/relatorios_diarios/';

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Basic $token",
    };

    http.Response response = await http.get(url,
        headers: headers);
    int statusCode = response
        .statusCode;


    if (statusCode == 200)
    {

    }

    //print(response.body);

    return response.body;
  }

  Future<String> makePutRequest(String token, RelatorioData relatorioData) async {
    String url = 'https://api.grupolenotre.com/relatorios_diarios/${relatorioData.cs}';

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Basic $token",
    };

    http.Response response = await http.put(url,
        headers: headers, body: relatorioData.toJson());
    int statusCode = response
        .statusCode;

    if (statusCode == 200)
    {

    }

    return response.body;
  }
}