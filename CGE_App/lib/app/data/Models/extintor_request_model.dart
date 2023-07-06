class ExtintorRequestModel {
  int id;
  String validadeCasco;
  String validadeExtintor;
  int numero;
  String tamanho;
  String tipo;

  ExtintorRequestModel({
    required this.id,
    required this.validadeCasco,
    required this.validadeExtintor,
    required this.numero,
    required this.tamanho,
    required this.tipo,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'validadeCasco': validadeCasco.toString(),
        'validadeExtintor': validadeExtintor.toString(),
        'numero': numero.toString(),
        'tamanho': tamanho.toString(),
        'tipo': tipo.toString(),
      };
}
