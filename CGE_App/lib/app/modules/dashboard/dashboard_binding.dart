import '../Extintor/cadastro_extintor/cadastroExtintor_controller.dart';
import '../Empresa/cadastro_empresa/cadastroEmpresa_controller.dart';
import '../Tecnico/cadastro_tecnico/cadastrotecnico_controller.dart';
import '../Empresa/perfil_empresa/perfilEmpresa_controller.dart';
import '../Tecnico/perfil_tecnico/perfilTecnico_controller.dart';
import '../Setor/cadastro_setor/cadastroSetor_controller.dart';
import '../Tecnico/ListTecnico/ListTecnico_controller.dart';
import '../Extintor/extintores/extintores_controller.dart';
import '../vistoria/vistoria/vistoria_controller.dart';
import '../Setor/setores/setores_controller.dart';
import '../login/login_controller.dart';
import 'package:flutter/services.dart';
import 'dashboard_Controller.dart';
import 'package:get/get.dart';


class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());

    Get.lazyPut<PerfilEmpresaController>(() => PerfilEmpresaController());
    Get.lazyPut<CadastroEmpresaController>(() => CadastroEmpresaController());

    Get.lazyPut<CadastroExtintorController>(() => CadastroExtintorController());
    Get.lazyPut<ExtintorController>(() => ExtintorController());

    Get.lazyPut<LoginController>(() => LoginController());

    Get.lazyPut<CadastroSetorController>(() => CadastroSetorController());
    Get.lazyPut<SetorController>(() => SetorController());

    Get.lazyPut<PerfilTecnicoController>(() => PerfilTecnicoController());
    Get.lazyPut<CadastroTecnicoController>(() => CadastroTecnicoController());
    Get.lazyPut<ListTecnicoController>(() => ListTecnicoController());

    Get.lazyPut<VistoriaController>(() => VistoriaController());

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
