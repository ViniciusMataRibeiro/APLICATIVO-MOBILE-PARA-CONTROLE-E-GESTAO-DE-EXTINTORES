class SetorResponseModel {
  int id;
  String name;
  String descricao;
  bool ativo;

  SetorResponseModel({
    required this.id,
    required this.name,
    required this.descricao,
    required this.ativo,
  });

  factory SetorResponseModel.fromJson(Map<String, dynamic> json) =>
      SetorResponseModel(
        id: json['id'],
        name: json['nome'],
        descricao: json['descricao'],
        ativo: json['ativo'],
      );
}
