// ignore_for_file: non_constant_identifier_names

class VistoriaRequestModel {
  int id;
  int extintor_id;
  int tecnico_id;
  DateTime dataManutencao;
  bool manimetro;
  bool sinalizacaoParede;
  bool sinalizacaoPiso;
  bool acesso;
  bool mangueira;
  bool lacre;
  bool aprovado;
  String? descricao;

  VistoriaRequestModel({
    required this.id,
    required this.extintor_id,
    required this.tecnico_id,
    required this.dataManutencao,
    required this.manimetro,
    required this.sinalizacaoParede,
    required this.sinalizacaoPiso,
    required this.acesso,
    required this.mangueira,
    required this.lacre,
    required this.aprovado,
    this.descricao
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'extintor_id': extintor_id,
        'tecnico_id': tecnico_id,
        'dataManutencao': dataManutencao.toIso8601String(),
        'manimetro' : manimetro,
        'sinalizacaoParede' : sinalizacaoParede,
        'sinalizacaoPiso' : sinalizacaoPiso,
        'acesso' : acesso,
        'mangueira' : mangueira,
        'lacre' : lacre,
        'aprovado' : aprovado,
        'descricao': descricao.toString(),
      };
}