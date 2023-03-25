import 'dart:convert';
import 'dart:ffi';

class TecnicoModel {
  int id;
  String email;
  String name;
  int status;
  String QtdVistorias;
  
  TecnicoModel({
    required this.id,
    required this.email,
    required this.name,
    required this.status,
    required this.QtdVistorias,
  });

  factory TecnicoModel.fromJson(Map<String, dynamic> json) => TecnicoModel(
        id: json['id'],
        email: json['email'],
        name: json['nome'].toString(),
        status: json['status'],
        QtdVistorias: json['QtdVistorias'].toString(),
      );
}
