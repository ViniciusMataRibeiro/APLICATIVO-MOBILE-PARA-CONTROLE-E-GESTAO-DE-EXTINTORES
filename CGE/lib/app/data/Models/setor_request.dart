class SetorRequestModel {
  int id;
  String name;
  String descricao;
  bool ativo;

  SetorRequestModel({
    required this.id,
    required this.name,
    required this.descricao,
    required this.ativo,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': name.toString(),
        'descricao': descricao.toString(),
        'ativo': ativo.toString(),
      };
}
