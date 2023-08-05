class EnderecoRequestModel {
  int id;
  // ignore: non_constant_identifier_names
  int empresa_id;
  String cep;
  String rua;
  String bairro;
  String cidade;
  String numero;
  // ignore: non_constant_identifier_names
  String ponto_referencia;
  String uf;

  EnderecoRequestModel({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.empresa_id,
    required this.cep,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.numero,
    // ignore: non_constant_identifier_names
    required this.ponto_referencia,
    required this.uf,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'empresa_id': empresa_id,
        'cep': cep.toString(),
        'rua': rua.toString(),
        'bairro': bairro.toString(),
        'cidade': cidade.toString(),
        'numero': numero.toString(),
        'ponto_referencia': ponto_referencia.toString(),
        'uf': uf.toString(),
      };
}
