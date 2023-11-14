class UserModel {
  String nome;
  String email;
  String tipo;

  UserModel({
    required this.nome,
    required this.email,
    required this.tipo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        nome: json['nome'],
        email: json['email'],
        tipo: json['tipo'].toString(),
      );
}
