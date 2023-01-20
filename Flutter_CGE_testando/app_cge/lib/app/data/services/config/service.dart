import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ConfigService extends GetxService {
  final box = GetStorage();
  final _token = RxnString();
  String? get token => _token.value;

  @override
  void onInit() {
    _token.value = box.read(ConfigKeys.token.toString());
    box.listenKey(ConfigKeys.token.toString(), (value) => _token.value = value);

    super.onInit();
  }

  Future<void> saveToken(String token) {
    return box.write(ConfigKeys.token.toString(), token);
  }

  Future<void> removeToken() {
    return box.remove(ConfigKeys.token.toString());
  }
}

enum ConfigKeys { token }
