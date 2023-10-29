import 'package:cge_app/app/modules/vistoria/consulta_vistoria/consulta_vistoria_binding.dart';
import 'package:cge_app/app/modules/vistoria/consulta_vistoria/consulta_vistoria_page.dart';
import 'package:cge_app/app/modules/Empresa/cadastro_empresa/cadastroEmpresa_binding.dart';
import 'package:cge_app/app/modules/Tecnico/cadastro_tecnico/cadastrotecnico_binding.dart';
import 'package:cge_app/app/modules/Empresa/cadastro_empresa/cadastroEmpresa_page.dart';
import 'package:cge_app/app/modules/Tecnico/cadastro_tecnico/cadastroTecnico_page.dart';
import 'package:cge_app/app/modules/Setor/ExtintorSetor/extintores_setor_page.dart';
import '../modules/Extintor/cadastro_extintor/cadastroExtintor_binding.dart';
import '../modules/detailsQrCode/extintor/extintores_details_binding.dart';
import '../modules/Extintor/cadastro_extintor/cadastroExtintor_page.dart';
import '../modules/Empresa/endereco_empresa/enderecoEmpresa_binding.dart';
import '../modules/qrCode/print_out_qrcode/print_out_qrcode_binding.dart';
import '../modules/detailsQrCode/extintor/extintores_details_page.dart';
import '../modules/Empresa/endereco_empresa/enderecoEmpresa_page.dart';
import '../modules/qrCode/print_out_qrcode/print_out_qrcode_page.dart';
import '../modules/Setor/ExtintorSetor/extintores_setor_binding.dart';
import '../modules/Empresa/perfil_empresa/perfilEmpresa_binding.dart';
import '../modules/Tecnico/perfil_tecnico/perfilTecnico_binding.dart';
import 'package:cge_app/app/modules/qrCode/generetor/qr_image.dart';
import '../modules/Setor/cadastro_setor/cadastroSetor_binding.dart';
import '../modules/Empresa/perfil_empresa/perfilEmpresa_page.dart';
import '../modules/Tecnico/perfil_tecnico/perfilTecnico_page.dart';
import '../modules/Setor/cadastro_setor/cadastroSetor_page.dart';
import '../modules/Tecnico/ListTecnico/ListTecnico_binding.dart';
import '../modules/Tecnico/ListTecnico/ListTecnico_page.dart';
import '../modules/qrCode/generetor/qr_binding_generetor.dart';
import '../modules/vistoria/vistoria/vistoria_binding.dart';
import '../modules/qrCode/scanner/qr_binding_scanner.dart';
import '../modules/vistoria/vistoria/vistoria_page.dart';
import '../modules/dashboard/dashboard_binding.dart';
import '../modules/qrCode/scanner/qr_scanner.dart';
import '../modules/dashboard/dashboard_page.dart';
import 'package:cge_app/app/routes/routes.dart';
import '../modules/Admin/admin_binding.dart';
import '../modules/login/login_binding.dart';
import '../modules/Admin/admin_page.dart';
import '../modules/login/login_page.dart';
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
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.perfil,
      page: () => PerfilPage(),
      binding: PerfilBinding(),
    ),
    GetPage(
      name: Routes.perfiltecnico,
      page: () => PerfilTecnicoPage(),
      binding: PerfilTecnicoBinding(),
    ),
    GetPage(
      name: Routes.perfiladmin,
      page: () => AdminPage(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: Routes.cadExtintor,
      page: () => const CadastroExtintorPage(),
      binding: CadastroExtintorBinding(),
    ),
    GetPage(
      name: Routes.cadSetor,
      page: () => const CadastroSetorPage(),
      binding: CadastroSetorBinding(),
    ),
    GetPage(
      name: Routes.cadEmpresa,
      page: () => const CadastroEmpresaPage(),
      binding: CadastroEmpresaBinding(),
    ),
    GetPage(
      name: Routes.vistoria,
      page: () => const VistoriaPage(),
      binding: VistoriaBinding(),
    ),
    GetPage(
      name: Routes.cadTecnico,
      page: () => const CadastroTecnicoPage(),
      binding: CadastroTecnicoBinding(),
    ),
    GetPage(
      name: Routes.listTecnico,
      page: () => const ListTecnico(),
      binding: ListTecnicoBinding(),
    ),
    GetPage(
      name: Routes.extintorSetor,
      page: () => const ExtintorSetor(),
      binding: ExtintorSetorBinding(),
    ),
    GetPage(
      name: Routes.enderecoEmpresa,
      page: () => const EnderecoEmpresaPage(),
      binding: EnderecoEmpresaBinding(),
    ),
    GetPage(
      name: Routes.consultaVistoria,
      page: () => const ConsultaVistoria(),
      binding: ConsultaVistoriaBinding(),
    ),
    GetPage(
      name: Routes.qrCodeGeneretor,
      page: () => const QRImage(),
      binding: QRCodeGeneretorBinding(),
    ),
    GetPage(
      name: Routes.qrCodeScanner,
      page: () => const QRScanner(),
      binding: QRCodeScannerBinding(),
    ),
    GetPage(
      name: Routes.detailsExtintor,
      page: () => const ExtintorDetails(),
      binding: ExtintorDetailsBinding(),
    ),
    GetPage(
      name: Routes.qrCodePrinter,
      page: () => const PrintQrCodePage(),
      binding: PrintQrCodeBinding(),
    )
  ];
}
