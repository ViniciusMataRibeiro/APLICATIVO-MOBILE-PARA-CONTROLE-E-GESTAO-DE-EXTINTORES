class ExtintorRequestModel {
  int id;
  String nome;
  DateTime validadeCasco;
  DateTime validadeExtintor;
  DateTime proximaManutencao;
  int tamanho;
  String tipo;
  bool ativo;
  // ignore: non_constant_identifier_names
  int setor_id;
  String? descricao;

  ExtintorRequestModel({
    required this.id,
    required this.nome,
    required this.validadeCasco,
    required this.validadeExtintor,
    required this.proximaManutencao,
    required this.tamanho,
    required this.tipo,
    required this.ativo,
    // ignore: non_constant_identifier_names
    required this.setor_id,
    this.descricao
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome.toString(),
        'validadeCasco': validadeCasco.toIso8601String(),
        'validadeExtintor': validadeExtintor.toIso8601String(),       
        'proximaManutencao': proximaManutencao.toIso8601String(),
        'tamanho': tamanho,
        'tipoExtintor': tipo.toString(),
        'ativo': ativo,
        'setor_id': setor_id,
        'descricao': descricao.toString(),
      };
}
