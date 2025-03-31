import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class PlagiarismChecker {
  final String apiUrl = "http://127.0.0.1:8000/check_plagiarism";

  Future<Map<String, dynamic>> checkPlagiarism(String referenceCode, String submittedCode) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "reference_code": referenceCode,
          "submitted_code": submittedCode,
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
}
