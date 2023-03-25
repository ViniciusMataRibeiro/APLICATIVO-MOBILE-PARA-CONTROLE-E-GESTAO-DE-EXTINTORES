class TecnicoModel {
  int id;
  String email;
  String name;
  int status;
  String qtdVistorias;
  
  TecnicoModel({
    required this.id,
    required this.email,
    required this.name,
    required this.status,
    required this.qtdVistorias,
  });

  factory TecnicoModel.fromJson(Map<String, dynamic> json) => TecnicoModel(
        id: json['id'],
        email: json['email'],
        name: json['nome'].toString(),
        status: json['status'],
        qtdVistorias: json['QtdVistorias'].toString(),
      );
}
