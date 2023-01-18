import 'package:app_cge/app/data/models/user.dart';
import 'package:app_cge/app/data/models/user_login_request.dart';
import 'package:app_cge/app/data/services/auth/repository.dart';
import 'package:app_cge/app/data/services/config/service.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final _configService = Get.find<ConfigService>();
  AuthRepository _repository;
  final user = Rxn<UserModel>();

  AuthService(this._repository);

  Future<void> login(UserLoginRequestModel userLoginRequest) async {
    var userLoginResponse = await _repository.login(userLoginRequest);
    await _configService.saveToken(userLoginResponse.token);
    await _getUser();

    print(userLoginResponse.token);
  }

  Future _getUser() {
    return _repository.getUser().then((value) {
      user.value = value;
    });
  }
}
