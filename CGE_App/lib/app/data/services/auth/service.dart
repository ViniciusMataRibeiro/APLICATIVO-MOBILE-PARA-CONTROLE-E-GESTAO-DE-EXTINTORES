import 'package:cge_app/app/data/Models/tecnico_request.dart';
import 'package:cge_app/app/data/services/auth/repository.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../Models/TecnicoModel.dart';
import '../../Models/user.dart';
import '../../Models/user_login_request.dart';
import '../config/service.dart';

class AuthService extends GetxService {
  final _configService = Get.find<ConfigService>();
  final AuthRepository _repository;
  final user = Rxn<UserModel>();
  bool get isLogged => user.value != null && user.value!.email != '';

  AuthService(this._repository);

  @override
  void onInit() async {
    if (_configService.token != null) {
      await _getUser();
    }

    super.onInit();
  }

  Future<String> login(UserLoginRequestModel userLoginRequest, BuildContext context) async {
    var userLoginResponse = await _repository.login(userLoginRequest);
    if (userLoginResponse.expiresAt == 'Invalid email/password') {
      return 'Usuário ou senha inválidos';
    } else if (userLoginResponse.expiresAt == 'Técnico bloqueado') {
      return 'Técnico bloqueado';
    }
    else {
      await _configService.saveToken(userLoginResponse.token);
      var user = await _getUser();
      if (user.email != '') {
        Future.delayed(const Duration(milliseconds: 1), () {
          Get.offAllNamed('/dashboard');
        });
        return 'true';
      }
    }

    return '';
  }

  Future<bool> logout() async {
    _repository.logout();
    await _configService.removeToken();
    user.value = null;
    Future.delayed(const Duration(milliseconds: 1), () {
      Get.offAllNamed('/login');
      return true;
    });

    return false;
  }

  Future<UserModel> _getUser() {
    return _repository.getUser().then((value) => user.value = value);
  }

  Future<void> insertTecnico(TecnicoRequestModel tecnico) async {
    await _repository.InsertTecnico(tecnico);
    Future.delayed(const Duration(milliseconds: 1), () {
      Get.offAllNamed('/dashboard');
    });
  }

  Future<void> updateTecnico(TecnicoRequestModel tecnico) async {
    var result = await _repository.updateTecnico(tecnico);
    if (result) {
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed('/listTecnico');
      });
    }
  }

  Future<List> getTecnico() async {
    return await _repository.getTecnico();
  }
}
