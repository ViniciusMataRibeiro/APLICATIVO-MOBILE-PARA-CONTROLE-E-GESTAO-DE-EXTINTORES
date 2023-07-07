class ExtintorRequestModel {
  int id;
  String nome;
  String validadeCasco;
  String validadeExtintor;
  String tamanho;
  String tipo;

  ExtintorRequestModel({
    required this.id,
    required this.nome,
    required this.validadeCasco,
    required this.validadeExtintor,
    required this.tamanho,
    required this.tipo,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome.toString(),
        'validadeCasco': validadeCasco.toString(),
        'validadeExtintor': validadeExtintor.toString(),       
        'tamanho': tamanho.toString(),
        'tipo': tipo.toString(),
      };
}
