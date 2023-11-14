class EmpresaResponseModel {
  int id;
  String nome;
  String email;
  String telefone;

  EmpresaResponseModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
  });

  factory EmpresaResponseModel.fromJson(Map<String, dynamic> json) =>
      EmpresaResponseModel(
        id: json["id"],
        nome: json["nome"],
        email: json["email"],
        telefone: json["telefone"],
      );
}
