class StudentAssignment {
  String id;
  int number;
  String status;
  List versions;
  String subject;
  bool isPlagiarized;
  double plagiarismScore;
  String learnerType;
  //String assignemntID; //

  StudentAssignment({
    required this.id,
    required this.number,
    required this.status,
    required this.versions,
    required this.subject,
    required this.isPlagiarized,
    required this.plagiarismScore,
    required this.learnerType,
    //required this.assignemntID
  });

  factory StudentAssignment.fromJson(Map<String, dynamic> json) {
    return StudentAssignment(
      id: json['id'] ?? '',
      number: json['number'] ?? 0,
      status: json['status'] ?? '',
      versions: json['versions'] ?? [],
      subject: json['subject'] ?? '',
      isPlagiarized: json['isPlagerised'] ?? false,
      plagiarismScore: json['plagerismScore'] ?? 0.0,
      learnerType: json['learnerType'] ?? '',
      //assignemntID: json['assignmentID'] ?? '', //
    );
  }

  static Map<String, dynamic> toJson(StudentAssignment studentAssignment) {
    return {
      'id': studentAssignment.id,
      'number': studentAssignment.number,
      'status': studentAssignment.status,
      'versions': studentAssignment.versions,
      'subject': studentAssignment.subject,
      'isPlagerised': studentAssignment.isPlagiarized,
      'plagerismScore': studentAssignment.plagiarismScore,
      'learnerType': studentAssignment.learnerType,
      //'assignmentID': studentAssignment.assignemntID,
    };
  }
}
