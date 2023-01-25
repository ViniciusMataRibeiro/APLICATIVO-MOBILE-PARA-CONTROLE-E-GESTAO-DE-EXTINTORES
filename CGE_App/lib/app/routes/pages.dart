import 'package:cge_app/app/routes/routes.dart';
import 'package:get/get.dart';

import '../modules/cadastro_extintor/binding.dart';
import '../modules/cadastro_extintor/page.dart';
import '../modules/cadastro_setor/binding.dart';
import '../modules/cadastro_setor/page.dart';
import '../modules/dashboard/binding.dart';
import '../modules/dashboard/page.dart';
import '../modules/login/binding.dart';
import '../modules/login/page.dart';
import '../modules/perfil/binding.dart';
import '../modules/perfil/page.dart';
import '../modules/splash/binding.dart';
import '../modules/splash/page.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.inicial,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
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
