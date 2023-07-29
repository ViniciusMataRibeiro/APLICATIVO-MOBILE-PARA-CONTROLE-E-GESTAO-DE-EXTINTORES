class EmpresaResquestModel {
  int id;
  String nome;
  String email;
  String password;
  String telefone;

  EmpresaResquestModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.password,
    required this.telefone,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome.toString(),
        'email': email.toString(),
        'password': password.toString(),
        'telefone': telefone.toString(),
      };
}
