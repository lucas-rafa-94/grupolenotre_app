import 'dart:convert';
import 'dart:io';

import 'package:grupolenotre/datas/filial_data.dart';
import 'package:http/http.dart' as http;

class FilialApi {

  Future<String> makeGetAllRequest(String token) async {

    String url = 'https://api.grupolenotre.com/filiais/';

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Basic $token",
    };

    http.Response response = await http.get(url,
        headers: headers);
    int statusCode = response
        .statusCode;

    print(json.encode(response.body));
    return response.body;

  }

  Future<String> makeGetAllStringRequest(String token) async {
    String url = 'https://api.grupolenotre.com/filiais/';

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

    return response.body;
  }

  Future<String> makePutRequest(String token, FilialData filialData) async {
    String url = 'https://api.grupolenotre.com/filiais/${filialData.cs}';

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Basic $token",
    };

    http.Response response = await http.put(url,
        headers: headers, body: filialData.toJson());
    int statusCode = response
        .statusCode;

    if (statusCode == 200)
    {

    }

    return response.body;
  }
}