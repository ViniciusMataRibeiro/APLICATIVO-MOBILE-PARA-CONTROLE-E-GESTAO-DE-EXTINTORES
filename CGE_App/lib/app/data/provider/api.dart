import 'dart:convert';
import 'package:cge_app/app/data/Models/setor_request.dart';
import 'package:cge_app/app/data/Models/vistoria_request_model.dart';
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
  final baseUrl = "http://44.203.70.86:3333";

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

  Future<Map> getTecnico() async {
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
      return {"dados": d};
    } else {
      return {"dados": []};
    }
  }

  Future<bool> deleteTecnico(int idTecnico) async {
    var url = Uri.parse("$baseUrl/tecnico/$idTecnico");
    var response = await http.delete(
      url,
      headers: {
        'authorization': 'Bearer ${_configService.token}',
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
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

  Future<int> insertSetor(SetorRequestModel data) async {
    var url = Uri.parse("$baseUrl/setor");
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      var resultId = await jsonDecode(response.body);
      return resultId['id'];
    } else {
      return 0;
    }
  }

  Future<int> updateSetor(SetorRequestModel data) async {
    var url = Uri.parse("$baseUrl/setor/${data.id}");
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return data.id;
    } else {
      return 0;
    }
  }

  Future<Map> getAllExtintor(bool isAtivo) async {
    var url = Uri.parse("$baseUrl/extintorsAll");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer ${_configService.token}',
    });
    if (response.statusCode == 200) {
      List d = [];
      List dados = await jsonDecode(response.body);
      if (isAtivo) {
        await Future.forEach(dados, (element) {
          Map<String, dynamic> t = Map.from(element);
          if (t['ativo'] == 1) {
            d.add(t);
          }
        });
      } else {
        await Future.forEach(dados, (element) {
          Map<String, dynamic> t = Map.from(element);
          if (t['ativo'] == 0) {
            d.add(t);
          }
        });
      }
      return {"dados": d};
    } else {
      return {"dados": []};
    }
  }

  Future<Map> getExtintorSetor(int idSetor) async {
    var url = Uri.parse("$baseUrl/extintorsSetor/$idSetor");
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

  Future<Map> getByIdExtintor(int id) async {
    var url = Uri.parse("$baseUrl/extintorById/$id");
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

  Future<int> insertExtintor(ExtintorRequestModel extintor) async {
    var url = Uri.parse("$baseUrl/extintor");
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(extintor.toJson()));
    if (response.statusCode == 201) {
      var resultId = await jsonDecode(response.body);
      return resultId['id'];
    } else {
      return 0;
    }
  }

  Future<int> updateExtintor(ExtintorRequestModel extintor) async {
    var url = Uri.parse("$baseUrl/extintor/${extintor.id}");
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(extintor.toJson()));
    if (response.statusCode == 200) {
      return extintor.id;
    } else {
      return 0;
    }
  }

  Future<bool> deleteExtintor(int idExtintor) async {
    var url = Uri.parse("$baseUrl/extintor/$idExtintor");
    var response = await http.delete(
      url,
      headers: {
        'authorization': 'Bearer ${_configService.token}',
      },
    );
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

  Future<Map> getEnderecoEmpresa() async {
    var url = Uri.parse("$baseUrl/empresaEndereco");
    var response = await http.get(url, headers: {
      'authorization': 'Bearer ${_configService.token}',
    });
    if (response.statusCode == 200) {
      var a = await jsonDecode(response.body);

      return {"dados": a};
    } else {
      return {"dados": []};
    }
  }

  Future<bool> insertEndereco(EnderecoRequestModel data) async {
    var url = Uri.parse("$baseUrl/empresaEndereco");
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
    var url = Uri.parse("$baseUrl/empresaEndereco/${data.id}");
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

  Future<Map> getSetores() async {
    var url = Uri.parse("$baseUrl/setors");
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

      return {"dadosSetores": d};
    } else {
      return {"dadosSetores": []};
    }
  }

  Future<List> getExtintorVistoria(int idSetor) async {
    var url = Uri.parse("$baseUrl/extintorsSetor/$idSetor");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer ${_configService.token}',
    });
    if (response.statusCode == 200) {
      List dados = await jsonDecode(response.body);

      return dados;
    } else {
      throw Exception('Falha ao carregar extintores');
    }
  }

  Future<Map> getAllManutencao() async {
    var url = Uri.parse("$baseUrl/manutencao");
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

  Future<bool> insertVistoria(VistoriaRequestModel vistoria) async {
    var url = Uri.parse("$baseUrl/manutencao");
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(vistoria.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateVistoria(VistoriaRequestModel vistoria) async {
    var url = Uri.parse("$baseUrl/manutencao/${vistoria.id}");
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(vistoria.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
