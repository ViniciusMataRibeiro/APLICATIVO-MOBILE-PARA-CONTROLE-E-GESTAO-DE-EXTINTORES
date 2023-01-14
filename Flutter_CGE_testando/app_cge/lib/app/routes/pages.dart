import 'package:app_cge/app/modules/cadastro_extintor/binding.dart';
import 'package:app_cge/app/modules/cadastro_extintor/page.dart';
import 'package:app_cge/app/modules/cadastro_setor/binding.dart';
import 'package:app_cge/app/modules/cadastro_setor/page.dart';
import 'package:app_cge/app/modules/dashboard/binding.dart';
import 'package:app_cge/app/modules/dashboard/page.dart';
import 'package:app_cge/app/modules/login/binding.dart';
import 'package:app_cge/app/modules/login/page.dart';
import 'package:app_cge/app/modules/perfil/binding.dart';
import 'package:app_cge/app/modules/perfil/page.dart';
import 'package:app_cge/app/routes/routes.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.dashboard,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.perfil,
      page: () => PerfilPage(),
      binding: PerfilBinding(),
    ),
    GetPage(
      name: Routes.cadExtintor,
      page: () => CadastroExtintorPage(),
      binding: CadastroExtintorBinding(),
    ),
    GetPage(
      name: Routes.cadSetor,
      page: () => CadastroSetorPage(),
      binding: CadastroSetorBinding(),
    ),
  ];
}
