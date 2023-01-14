import 'package:app_cge/app/modules/dashboard/page.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;
  }
}
