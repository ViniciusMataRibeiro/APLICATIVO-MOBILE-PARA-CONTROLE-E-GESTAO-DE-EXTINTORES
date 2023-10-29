import '../../Models/empresa_request_model.dart';
import '../../Models/empresa_response_model.dart';
import '../../Models/endereco_request_model.dart';
import '../../Models/extintor_request_model.dart';
import '../../Models/setor_request.dart';
import '../../Models/tecnico_request.dart';
import '../../Models/user.dart';
import '../../Models/user_login_request.dart';
import '../../Models/user_login_response.dart';
import '../../Models/vistoria_request_model.dart';
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

  Future<Map> getTecnico() => _api.getTecnico();

    Future<bool> deleteTecnico(int idTecnico) =>
      _api.deleteTecnico(idTecnico);

  Future<Map> getResumoSetor() => _api.getResumoSetor();

  Future<Map> getByIdExtintor(int id) => _api.getByIdExtintor(id);

  Future<int> insertSetor(SetorRequestModel setor) => _api.insertSetor(setor);

  Future<int> updateSetor(SetorRequestModel setor) => _api.updateSetor(setor);

  Future<int> insertExtintor(ExtintorRequestModel extintor) =>
      _api.insertExtintor(extintor);

  Future<int> updateExtintor(ExtintorRequestModel extintor) =>
      _api.updateExtintor(extintor);

  Future<bool> deleteExtintor(int idExtintor) =>
      _api.deleteExtintor(idExtintor);

  Future<Map> getAllExtintor(bool isAtivo) => _api.getAllExtintor(isAtivo);


  Future<Map> getExtintorSetor(int idSetor) => _api.getExtintorSetor(idSetor);

  Future<EmpresaResponseModel> insertEmpresa(EmpresaResquestModel empresa) =>
      _api.insertEmpresa(empresa);

  Future<EmpresaResponseModel> updateEmpresa(EmpresaResquestModel empresa) =>
      _api.updateEmpresa(empresa);

  Future<Map> getEnderecoEmpresa() => _api.getEnderecoEmpresa();

  Future<bool> insertEndereco(EnderecoRequestModel endereco) =>
      _api.insertEndereco(endereco);

  Future<bool> updateEndereco(EnderecoRequestModel endereco) =>
      _api.updateEndereco(endereco);

  Future<Map> getSetores() => _api.getSetores();
  Future<List> getExtintorVistoria(int idSetor) => _api.getExtintorVistoria(idSetor);

  Future<Map> getAllManutencao() => _api.getAllManutencao();

  Future<bool> insertVistoria(VistoriaRequestModel vistoria) =>
      _api.insertVistoria(vistoria);

  Future<bool> updateVistoria(VistoriaRequestModel vistoria) =>
      _api.updateVistoria(vistoria);
}
