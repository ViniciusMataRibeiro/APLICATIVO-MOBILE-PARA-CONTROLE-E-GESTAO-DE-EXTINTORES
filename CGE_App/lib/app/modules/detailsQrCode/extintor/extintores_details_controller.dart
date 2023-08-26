// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

import '../../../data/services/auth/service.dart';

class ExtintorDetailsController extends GetxController {
  final _authService = Get.find<AuthService>();
  late String extintor_id;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      extintor_id = Get.arguments;
    }

    super.onInit();
  }

  Future<Map> getExtintor() async {
    Map t = await _authService.getByIdExtintor(int.parse(extintor_id));

    return t;
  }
}
