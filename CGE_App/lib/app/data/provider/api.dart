import 'dart:convert';
import 'package:cge_app/app/data/Models/setor_request.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Models/empresa_request_model.dart';
import '../Models/empresa_response_model.dart';
import '../Models/endereco_request_model.dart';
import '../Models/extintor_request_model.dart';
import '../Models/tecnico_request.dart';
import '../Models/user.dart';
import '../Models/user_login_request.dart';
import '../Models/user_login_response.dart';
import '../services/config/service.dart';

class Api {
  final _configService = Get.find<ConfigService>();
  final baseUrl = "http://192.168.0.116:3333";

  Future<UserLoginResponseModel> login(UserLoginRequestModel data) async {
    var url = Uri.parse("$baseUrl/login");
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return UserLoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      return UserLoginResponseModel(token: '', expiresAt: data['message']);
    }
  }

  Future<UserModel> getUser() async {
    var url = Uri.parse("$baseUrl/auth/me");
    var response = await http
        .get(url, headers: {'authorization': 'Bearer ${_configService.token}'});
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      return UserModel(nome: '', email: '', tipo: '');
    }
  }

  Future<void> logout() async {
    var url = Uri.parse("$baseUrl/logout?token=${_configService.token}");
    var response = await http.post(url);
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed');
    }
  }

  Future<bool> insertTecnico(TecnicoRequestModel data) async {
    var url = Uri.parse("$baseUrl/tecnico");
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTecnico(TecnicoRequestModel data) async {
    var url = Uri.parse("$baseUrl/tecnico/${data.id}");
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List> getTecnico() async {
    var url = Uri.parse("$baseUrl/Tecnicos");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer ${_configService.token}',
    });
    if (response.statusCode == 200) {
      List d = [];
      List dados = await jsonDecode(response.body);
      await Future.forEach(dados, (element) {
        Map<String, dynamic> t = Map.from(element);
        d.add(t);
      });

      return d;
    } else {
      return [];
    }
  }

  Future<Map> getResumoSetor() async {
    var url = Uri.parse("$baseUrl/resumoSetor");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer ${_configService.token}',
    });
    if (response.statusCode == 200) {
      List d = [];
      List dados = await jsonDecode(response.body);
      await Future.forEach(dados, (element) {
        Map<String, dynamic> t = Map.from(element);
        d.add(t);
      });

      return {"dadosGraficos": d};
    } else {
      return {"dadosGraficos": []};
    }
  }

  Future<bool> insertSetor(SetorRequestModel data) async {
    var url = Uri.parse("$baseUrl/setor");
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateSetor(SetorRequestModel data) async {
    var url = Uri.parse("$baseUrl/setor/${data.id}");
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map> getAllExtintor() async {
    var url = Uri.parse("$baseUrl/extintorsAll");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer ${_configService.token}',
    });
    if (response.statusCode == 200) {
      List d = [];
      List dados = await jsonDecode(response.body);
      await Future.forEach(dados, (element) {
        Map<String, dynamic> t = Map.from(element);
        d.add(t);
      });

      return {"dados": d};
    } else {
      return {"dados": []};
    }
  }

  Future<bool> insertExtintor(ExtintorRequestModel extintor) async {
    var url = Uri.parse("$baseUrl/extintor");
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(extintor.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateExtintor(ExtintorRequestModel extintor) async {
    var url = Uri.parse("$baseUrl/extintor/${extintor.id}");
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(extintor.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<EmpresaResponseModel> insertEmpresa(EmpresaResquestModel data) async {
    var url = Uri.parse("$baseUrl/empresa");
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return EmpresaResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return EmpresaResponseModel(id: 0, nome: '', email: '', telefone: '');
    }
  }

  Future<EmpresaResponseModel> updateEmpresa(EmpresaResquestModel data) async {
    var url = Uri.parse("$baseUrl/empresa/${data.id}");
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return EmpresaResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return EmpresaResponseModel(id: 0, nome: '', email: '', telefone: '');
    }
  }

  Future<bool> insertEndereco(EnderecoRequestModel data) async {
    var url = Uri.parse("$baseUrl/endereco");
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateEndereco(EnderecoRequestModel data) async {
    var url = Uri.parse("$baseUrl/endereco/${data.id}");
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List> getSetores() async {
    var url = Uri.parse("$baseUrl/setors");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer ${_configService.token}',
    });
    if (response.statusCode == 200) {
      List dados = await jsonDecode(response.body);

      return dados;
    } else {
      throw Exception('Falha ao carregar culturas');
    }
  }
}
