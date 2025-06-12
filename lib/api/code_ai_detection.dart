import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class CodeAiDetection {
  final String apiUrl = "http://127.0.0.1:8000/detect";

  Future<Map<String, dynamic>> codeDetection(String code) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "text": code,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        log("ISAI response" + data['verdict']);
        return data;
      } else {
        log("Error (isAI): ${response.statusCode} - ${response.body}");
        return {"Error": response.statusCode};
      }
    } catch (e) {
      log("Exception: $e");
      return {"Error": e};
    }
  }
}
