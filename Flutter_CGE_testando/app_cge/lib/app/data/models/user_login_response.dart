class UserLoginResponseModel {
  String token;
  String expiresAt;

  UserLoginResponseModel({
    required this.token,
    required this.expiresAt,
  });

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseModel(
        token: json['token'].toString(),
        expiresAt: json['expires_at'].toString(),
      );
}
