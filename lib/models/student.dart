class Student {
  String name;
  String signature;
  String batch;
  String email;
  int rollno;
  List assignments;

  Student({
    required this.name,
    required this.signature,
    required this.batch,
    required this.email,
    required this.rollno,
    required this.assignments,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'] ?? '',
      signature: json['signature'] ?? '',
      batch: json['batch'] ?? '',
      email: json['email'] ?? '',
      rollno: json['rollno'] ?? 0,
      assignments: json['assignments'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'signature': signature,
      'batch': batch,
      'email': email,
      'rollno': rollno,
      'assignments': assignments,
    };
  }
}
