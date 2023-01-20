import 'dart:convert';

import 'package:app_cge/app/data/models/user.dart';
import 'package:app_cge/app/data/models/user_login_request.dart';
import 'package:app_cge/app/data/models/user_login_response.dart';
import 'package:app_cge/app/data/services/config/service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {
  final _configService = Get.find<ConfigService>();

  @override
  void onInit() {
    httpClient.baseUrl = "http://127.0.0.1:3333/";

    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';

      return request;
    });

    httpClient.addAuthenticator((Request request) {
      var token = _configService.token;
      var headers = {'Authorization': 'Bearer $token'};

      request.headers.addAll(headers);
      return request;
    });

    super.onInit();
  }

  Response _errorHandler(Response response) {
    print(response.bodyString);

    switch (response.statusCode) {
      case 200:
      case 202:
      case 204:
        return response;
      default:
        throw 'Ocorreu um erro';
    }
  }

  Future<UserLoginResponseModel> login(UserLoginRequestModel data) async {
    var response = _errorHandler(await post('login', jsonEncode(data)));

    return UserLoginResponseModel.fromJson(response.body);
  }

  Future<UserModel> getUser() async {
    var response = _errorHandler(await get('auth/me'));

    return UserModel.fromJson(response.body);
  }
}
