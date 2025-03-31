import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ClassifyLearner {
  final String apiUrl = "http://127.0.0.1:8000/classify_learner";

  Future<Map<String, dynamic>> classifyLearner(int totalVersions, double timeDifference, double plagerismScore) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "total_versions": totalVersions,
          "time_difference": timeDifference,
          "plagiarism_score": plagerismScore,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        log("Error: ${response.statusCode} - ${response.body}");
        return {"Error": response.statusCode};
      }
    } catch (e) {
      log("Exception: $e");
      return {"Error": e};
    }
  }

  int getTimeDifferenceInMinutes(DateTime lastVersionDate) {
    DateTime currentDateTime = DateTime.now();

    Duration difference = currentDateTime.difference(lastVersionDate);
    int differenceInMinutes = difference.inMinutes;

    return differenceInMinutes;
  }
}
