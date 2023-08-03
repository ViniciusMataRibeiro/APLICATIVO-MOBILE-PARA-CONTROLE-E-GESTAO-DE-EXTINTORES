import '../../Models/empresa_request_model.dart';
import '../../Models/empresa_response_model.dart';
import '../../Models/endereco_request_model.dart';
import '../../Models/extintor_request_model.dart';
import '../../Models/setor_request.dart';
import '../../Models/tecnico_request.dart';
import '../../Models/user.dart';
import '../../Models/user_login_request.dart';
import '../../Models/user_login_response.dart';
import '../../provider/api.dart';

class AuthRepository {
  final Api _api;

  AuthRepository(this._api);

  Future<UserLoginResponseModel> login(
          UserLoginRequestModel userLoginRequest) =>
      _api.login(userLoginRequest);

  Future<UserModel> getUser() => _api.getUser();

  Future<void> logout() => _api.logout();

  // ignore: non_constant_identifier_names
  Future<bool> InsertTecnico(TecnicoRequestModel tecnico) =>
      _api.insertTecnico(tecnico);

  Future<bool> updateTecnico(TecnicoRequestModel tecnico) =>
      _api.updateTecnico(tecnico);

  Future<List> getTecnico() => _api.getTecnico();

  Future<Map> getResumoSetor() => _api.getResumoSetor();

  Future<bool> insertSetor(SetorRequestModel setor) => _api.insertSetor(setor);

  Future<bool> updateSetor(SetorRequestModel setor) => _api.updateSetor(setor);

  Future<bool> insertExtintor(ExtintorRequestModel extintor) =>
      _api.insertExtintor(extintor);

  Future<bool> updateExtintor(ExtintorRequestModel extintor) =>
      _api.updateExtintor(extintor);

  Future<Map> getAllExtintor() => _api.getAllExtintor();

  Future<Map> getExtintorSetor(int idSetor) => _api.getExtintorSetor(idSetor);

  Future<EmpresaResponseModel> insertEmpresa(EmpresaResquestModel empresa) =>
      _api.insertEmpresa(empresa);

  Future<EmpresaResponseModel> updateEmpresa(EmpresaResquestModel empresa) =>
      _api.updateEmpresa(empresa);

  Future<bool> insertEndereco(EnderecoRequestModel endereco) =>
      _api.insertEndereco(endereco);

  Future<bool> updateEndereco(EnderecoRequestModel endereco) =>
      _api.updateEndereco(endereco);

  Future<List> getSetores() => _api.getSetores();
}
