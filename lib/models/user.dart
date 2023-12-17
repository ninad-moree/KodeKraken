class User {
  String signature;
  String email;
  String password;

  User({
    required this.signature,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      signature: json['signature'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'signature': signature,
      'email': email,
      'password': password,
    };
  }
}
