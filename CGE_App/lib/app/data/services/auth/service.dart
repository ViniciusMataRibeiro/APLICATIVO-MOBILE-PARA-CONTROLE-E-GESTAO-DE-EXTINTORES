import 'package:cge_app/app/data/Models/empresa_request_model.dart';
import 'package:cge_app/app/data/Models/tecnico_request.dart';
import 'package:cge_app/app/data/services/auth/repository.dart';
import 'package:get/get.dart';

import '../../Models/empresa_response_model.dart';
import '../../Models/endereco_request_model.dart';
import '../../Models/extintor_request_model.dart';
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
      return 'Técnico está bloqueado';
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

  Future<bool> updateTecnico(TecnicoRequestModel tecnico) async { //Develop
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

  Future<bool> updateSetor(SetorRequestModel setor) async {
    var result = await _repository.updateSetor(setor);
    if (result) {
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed('/dashboard');
      });
      return true;
    } else {
      return false;
    }
  }

  Future<Map> getAllExtintor() async {
    return await _repository.getAllExtintor();
  }

  Future<Map> getExtintorSetor(int idSetor) async {
    return await _repository.getExtintorSetor(idSetor);
  }

  Future<bool> insertExtintor(ExtintorRequestModel extintor) async {
    var result = await _repository.insertExtintor(extintor);
    if (result) {
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed('/dashboard');
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateExtintor(ExtintorRequestModel extintor) async {
    var result = await _repository.updateExtintor(extintor);
    if (result) {
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed('/dashboard');
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteExtintor(int idExtintor) async {
    var result = await _repository.deleteExtintor(idExtintor);
    if (result) {
      return true;
    } else {
      return false;
    }
  }

  Future<EmpresaResponseModel> insertEmpresa(
      EmpresaResquestModel empresa) async {
    var result = await _repository.insertEmpresa(empresa);
    if (result.id > 0) {
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed('/dashboard');
      });
      return result;
    } else {
      return result;
    }
  }

  Future<EmpresaResponseModel> updateEmpresa(
      EmpresaResquestModel empresa) async {
    var result = await _repository.updateEmpresa(empresa);
    if (result.id > 0) {
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed('/dashboard');
      });
      return result;
    } else {
      return result;
    }
  }

  Future<Map> getEnderecoEmpresa() async {
    return await _repository.getEnderecoEmpresa();
  }

  Future<bool> insertEndereco(EnderecoRequestModel endereco) async {
    var result = await _repository.insertEndereco(endereco);
    if (result) {
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed('/dashboard');
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateEndereco(EnderecoRequestModel endereco) async {
    var result = await _repository.updateEndereco(endereco);
    if (result) {
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed('/dashboard');
      });
      return true;
    } else {
      return false;
    }
  }

  Future<Map> getSetores() async {
    return await _repository.getSetores();
  }

  Future<List> getExtintorVistoria(int idSetor) async {
    return await _repository.getExtintorVistoria(idSetor);
  }

  Future<Map> getAllManutencao() async {
    return await _repository.getAllManutencao();
  }

}
