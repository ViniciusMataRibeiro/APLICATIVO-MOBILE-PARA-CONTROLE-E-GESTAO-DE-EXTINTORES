import 'package:app_cge/app/modules/login/controller.dart';
import 'package:app_cge/app/modules/splash/controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
