import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'custom_exception.dart';
import 'package:practical_moweb/networking/networking_constants.dart' as constants;

class ApiProvider{
  late Uri _uri;

  Future<dynamic> patch(String url,{var body}) async {
    var responseJson;
    var response;
    try {
    _uri = Uri.parse(constants.baseUrl + url);
      if(body==null){
        response = await http.patch(_uri, headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        });
      }else{
        response = await http.patch(_uri, headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },body: json.encode(body));
      }

      responseJson = _response(response);

    } on SocketException {
      throw FetchDataException(constants.no_Internet);
    }
    return responseJson;
  }
  Future<dynamic> get(String url) async {

    var responseJson;
    try {

      _uri = Uri.parse(constants.baseUrl + url);

        final response = await http.get(_uri, headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        });

        responseJson = _response(response);

    } on SocketException {
      throw NoInternetException(constants.no_Internet);
    }
    return responseJson;
  }
  Future<dynamic> delete(String url) async {
    var responseJson;
    try {
      _uri = Uri.parse(constants.baseUrl + url);
      final response = await http.delete(_uri, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      responseJson = _response(response);
    } on SocketException {
      throw NoInternetException(constants.no_Internet);
    }
    return responseJson;
  }
  Future<dynamic> post(String url, var body) async {
    var responseJson;
    try {
      print(body);
      _uri = Uri.parse(constants.baseUrl + url);
      final response = await http.post(_uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body));

      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  Future<dynamic> put(String url,{var body}) async {
    var responseJson;
    var response;
    try {

      if(body==null){
        _uri = Uri.parse(constants.baseUrl + url);
        response = await http.put(_uri,
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            });
      }else{
        response = await http.put(Uri.parse(constants.baseUrl + url),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            },
            body: json.encode(body));
      }

      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  dynamic _response(http.Response response) {
    print(response.statusCode);
    print(_uri);
    print(response.statusCode);
    print(response.body);

    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 201:
      case 204:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
      case 412:
      case 400:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw BadRequestException(msg);
      case 401:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw NoInternetException(msg);
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        var responseJson = json.decode(response.body.toString());
        var error =
        responseJson["errors"] ?? "";
        var msg;
        if (error != "") {
          msg = error["message"] ?? "";
        }
        throw BadRequestException(msg ?? response.body.toString());
      case 422:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw BadRequestException(msg);
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}