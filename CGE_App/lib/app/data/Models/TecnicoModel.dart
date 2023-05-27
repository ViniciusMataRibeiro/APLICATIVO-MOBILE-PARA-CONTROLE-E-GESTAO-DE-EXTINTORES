// ignore_for_file: file_names

class TecnicoModel {
  int id;
  String email;
  String name;
  String status;
  int qtdVistorias;
  
  TecnicoModel({
    required this.id,
    required this.email,
    required this.name,
    required this.status,
    required this.qtdVistorias,
  });

  factory TecnicoModel.fromJson(Map<String, dynamic> json) => TecnicoModel(
        id: json['id'],
        email: json['email'].toString(),
        name: json['nome'].toString(),
        status: json['status'].toString(),
        qtdVistorias: json['qtdVistorias'], 
      );
}
