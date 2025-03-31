class Assignment {
  String title;
  String description;
  int assignmentNumber;
  String expectedOutput;
  String testCases;
  String language;
  bool isPlagerised;
  double plagerismScore;
  String referenceCode;

  Assignment({
    required this.title,
    required this.description,
    required this.assignmentNumber,
    required this.expectedOutput,
    required this.testCases,
    required this.language,
    required this.isPlagerised,
    required this.plagerismScore,
    required this.referenceCode,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      assignmentNumber: json['number'] ?? 0,
      expectedOutput: json['expectedOutput'] ?? '',
      testCases: json['testcases'] ?? '',
      language: json['language'] ?? '',
      isPlagerised: json['isPlagerised'] ?? false,
      plagerismScore: json['plagerismScore'] ?? 0.0,
      referenceCode: json['referenceCode'] ?? '',
    );
  }
}
