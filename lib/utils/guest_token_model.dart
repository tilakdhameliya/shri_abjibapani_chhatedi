// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  int status;
  String message;
  TokenResult result;

  Token({
    required this.status,
    required this.message,
    required this.result,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    status: json["status"],
    message: json["message"],
    result: TokenResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result.toJson(),
  };
}

class TokenResult {
  String name;
  String firstName;
  String lastName;
  String image;
  bool emailVerified;
  String email;
  String userId;
  String token;

  TokenResult({
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.emailVerified,
    required this.email,
    required this.userId,
    required this.token,
  });

  factory TokenResult.fromJson(Map<String, dynamic> json) => TokenResult(
    name: json["name"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    image: json["image"],
    emailVerified: json["emailVerified"],
    email: json["email"],
    userId: json["userId"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "firstName": firstName,
    "lastName": lastName,
    "image": image,
    "emailVerified": emailVerified,
    "email": email,
    "userId": userId,
    "token": token,
  };
}
