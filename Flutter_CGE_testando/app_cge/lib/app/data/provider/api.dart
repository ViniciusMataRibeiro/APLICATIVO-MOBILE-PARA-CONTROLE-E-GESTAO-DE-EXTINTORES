
import 'dart:convert';

import 'package:app_cge/app/data/models/user_login_request.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {

  @override
  void onInit() {
    httpClient.baseUrl = "http://192.168.0.104:3333/";

    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';

      return request;
    });
  }

  Response _errorHandler(Response response) {
    print(response.bodyString);

    switch (response.statusCode){
      case 200:
      case 202:
      case 204:
        return response;
      default:
        throw 'Ocorreu um erro';
      }
    }

  login(UserLoginRequestModel data) async {
      var json = _errorHandler(await post('login', jsonEncode(data)));

      return json;
  }
// Get request
}