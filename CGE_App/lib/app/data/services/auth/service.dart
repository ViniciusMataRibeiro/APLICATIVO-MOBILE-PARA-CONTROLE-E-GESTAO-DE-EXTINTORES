import 'package:cge_app/app/data/Models/tecnico_request.dart';
import 'package:cge_app/app/data/services/auth/repository.dart';
import 'package:get/get.dart';

import '../../Models/TecnicoModel.dart';
import '../../Models/setor_request.dart';
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

  Future<String> login(UserLoginRequestModel userLoginRequest) async {
    var userLoginResponse = await _repository.login(userLoginRequest);
    if (userLoginResponse.expiresAt == 'Invalid email/password') {
      return 'Usuário ou senha inválidos';
    } else if (userLoginResponse.expiresAt == 'Técnico bloqueado') {
      return 'Técnico bloqueado';
    } else {
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

  Future<void> logout() async {
    _repository.logout();
    await _configService.removeToken();
    user.value = null;
    Future.delayed(const Duration(milliseconds: 1), () {
      Get.offAllNamed('/login');
    });
  }

  Future<UserModel> _getUser() {
    return _repository.getUser().then((value) => user.value = value);
  }

  Future<bool> insertTecnico(TecnicoRequestModel tecnico) async {
    var result = await _repository.InsertTecnico(tecnico);
    if (result) {
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed('/dashboard');
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTecnico(TecnicoRequestModel tecnico) async {
    var result = await _repository.updateTecnico(tecnico);
    if (result) {
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed('/listTecnico');
      });
      return true;
    } else {
      return false;
    }
  }

  Future<List> getTecnico() async {
    return await _repository.getTecnico();
  }

  Future<Map> getResumoSetor() async {
    return await _repository.getResumoSetor();
  }

  Future<bool> insertSetor(SetorRequestModel setor) async {
    var result = await _repository.insertSetor(setor);
    if (result) {
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed('/dashboard');
      });
      return true;
    } else {
      return false;
    }
  }
}
