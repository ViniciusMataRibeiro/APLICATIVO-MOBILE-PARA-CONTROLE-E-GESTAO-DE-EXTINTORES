// ignore_for_file: file_names
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;
  }
}
