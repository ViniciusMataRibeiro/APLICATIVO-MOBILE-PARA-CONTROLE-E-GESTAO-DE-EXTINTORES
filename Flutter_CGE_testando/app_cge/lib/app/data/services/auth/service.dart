import 'package:app_cge/app/data/models/user.dart';
import 'package:app_cge/app/data/models/user_login_request.dart';
import 'package:app_cge/app/data/services/auth/repository.dart';
import 'package:app_cge/app/data/services/config/service.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final _configService = Get.find<ConfigService>();
  final AuthRepository _repository;
  final user = Rxn<UserModel>();
  bool get isLogged => user.value != null;

  AuthService(this._repository);

  @override
  void onInit() async {
    if (_configService.token != null) {
      await _getUser();
    }

    super.onInit();
  }

  Future<void> login(UserLoginRequestModel userLoginRequest) async {
    var userLoginResponse = await _repository.login(userLoginRequest);
    await _configService.saveToken(userLoginResponse.token);
    await _getUser();
    await logout();
  }

  Future<void> logout() async {
    _repository.logout();
    await _configService.removeToken();
    user.value = null;
  }

  Future _getUser() {
    return _repository.getUser()
      .then((value) {
        user.value = value;
      });
  }
}
