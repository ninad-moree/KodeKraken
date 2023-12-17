class Teacher {
  String signature;
  String email;
  String name;
  List batches;

  Teacher(
      {required this.signature, required this.email, required this.name, required this.batches});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      signature: json['signature'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      batches: json['batches'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'signature': signature,
      'email': email,
      'name': name,
      'batches': batches,
    };
  }
}
