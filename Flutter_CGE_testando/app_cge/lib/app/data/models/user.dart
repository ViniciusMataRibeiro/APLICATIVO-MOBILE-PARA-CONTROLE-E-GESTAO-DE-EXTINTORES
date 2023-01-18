class UserModel {
  String nome;
  String email;
  String phone;

  UserModel({
    required this.nome,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        nome: json['nome'],
        email: json['email'],
        phone: json['phone'],
      );
}
