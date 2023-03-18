class TecnicoRequestModel {
  String email;
  String password;
  String name;

  TecnicoRequestModel({
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'nome': name.toString(),
        'email': email.toString(),
        'password': password.toString(),
      };
}
