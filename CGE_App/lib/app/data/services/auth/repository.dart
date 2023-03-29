
import '../../Models/TecnicoModel.dart';
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
  Future<void> InsertTecnico(TecnicoRequestModel tecnico) => _api.insertTecnico(tecnico);

  Future<bool> updateTecnico(TecnicoRequestModel tecnico) => _api.updateTecnico(tecnico);

  Future<List> getTecnico() => _api.getTecnico();
}
