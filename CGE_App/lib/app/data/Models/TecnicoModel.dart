class TecnicoModel {
  String email;
  String password;
  String name;

  TecnicoModel({
    required this.email,
    required this.password,
    required this.name,
  });

  factory TecnicoModel.fromJson(Map<String, dynamic> json) => TecnicoModel(
        email: json['email'],
        password: json['password'],
        name: json['nome'].toString(),
      );
}
