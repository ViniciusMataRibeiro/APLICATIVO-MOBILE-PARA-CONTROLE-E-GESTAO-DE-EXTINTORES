class TecnicoRequestModel {
  int id;
  String email;
  String password;
  String name;
  bool bloqueado;

  TecnicoRequestModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.bloqueado,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': name.toString(),
        'email': email.toString(),
        'password': password.toString(),
        'bloqueado': bloqueado,
      };
}
