import 'package:app_cge/app/data/models/user.dart';
import 'package:app_cge/app/data/models/user_login_request.dart';
import 'package:app_cge/app/data/models/user_login_response.dart';
import 'package:app_cge/app/data/provider/api.dart';

class AuthRepository {
  final Api _api;

  AuthRepository(this._api);

  Future<UserLoginResponseModel> login(
          UserLoginRequestModel userLoginRequest) =>
      _api.login(userLoginRequest);

  Future<UserModel> getUser() => _api.getUser();
}
