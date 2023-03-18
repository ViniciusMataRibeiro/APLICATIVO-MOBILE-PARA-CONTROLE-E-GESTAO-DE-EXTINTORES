
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

  Future<void> InsertTecnico(TecnicoRequestModel tecnico) => _api.InsertTecnico(tecnico);
}
