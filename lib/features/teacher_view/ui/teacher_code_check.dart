import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/python.dart';
import 'package:kode_kraken/models/student_assignment.dart';

import '../../../constants/color_constants.dart';
import '../../../models/assignment.dart';
import '../../assignment_display/ui/widgets/version_display.dart';
import 'package:http/http.dart' as http;

class CodeDisplayPage extends StatefulWidget {
  final StudentAssignment studentAssignment;
  final String rollNumber;
  final Assignment? assignment;

  const CodeDisplayPage({
    super.key,
    required this.studentAssignment,
    required this.rollNumber,
    required this.assignment,
  });

  @override
  State<CodeDisplayPage> createState() => _CodeDisplayPageState();
}

class _CodeDisplayPageState extends State<CodeDisplayPage> {
  String output = 'Waiting for output';
  late CodeController _codeController;

  final String _selectedLanguage = 'cpp';

  final Map<String, dynamic> languageOptions = {
    'cpp': cpp,
    'python': python,
    'java': java,
  };

  final Map<String, dynamic> languageId = {
    'cpp': 7,
    'python': 5,
    'java': 4,
  };

  Future<void> fetchUpdatedAssignment() async {
    var result = await FirebaseFirestore.instance.collection('assignment').doc(widget.studentAssignment.id).get();

    if (result.exists) {
      var data = result.data()!;
      log("FETCHED FROM FIREBASE:");
      log("isPlagiarized: ${data['isPlagiarized']}");
      log("plagiarismScore: ${data['plagiarismScore']}");
      log("learner type: ${data['learnerType']}");

      setState(() {
        widget.studentAssignment.isPlagiarized = data['isPlagiarized'];
        widget.studentAssignment.plagiarismScore = (data['plagiarismScore'] as num?)?.toDouble() ?? 0.0;
        // widget.studentAssignment.learnerType = (data['learnerType']);
      });
    } else {
      log("No Data available");
    }
  }

  @override
  void initState() {
    // runCode(widget.studentAssignment.versions.last['code']);
    // _codeController = CodeController(
    //   text: widget.studentAssignment.versions.last['code'],
    //   // language: cpp,
    //   language: languageOptions[_selectedLanguage],
    //   theme: monokaiSublimeTheme,
    // );
    if (widget.studentAssignment.versions.isNotEmpty) {
      runCode(widget.studentAssignment.versions.last['code']);
      _codeController = CodeController(
        text: widget.studentAssignment.versions.last['code'],
        language: languageOptions[_selectedLanguage],
        theme: monokaiSublimeTheme,
      );
    } else {
      log("No versions found for this assignment!");
      _codeController = CodeController(
        text: "",
        language: languageOptions[_selectedLanguage],
        theme: monokaiSublimeTheme,
      );
    }
    super.initState();
    fetchUpdatedAssignment();
    log(widget.studentAssignment.plagiarismScore.toStringAsFixed(5).toString());
  }

  Future runCode(String code) async {
    var response = await http.post(
      Uri.parse("https://code-compiler.p.rapidapi.com/v2"),
      headers: {
        'Content-Type': 'application/json',
        'X-RapidAPI-Key': 'e045d02908msh954c7b914f6d179p1f3208jsndfe0a23306bc',
        'x-rapidapi-host': 'code-compiler.p.rapidapi.com'
      },
      body: jsonEncode({
        'LanguageChoice': languageId[_selectedLanguage],
        'Program': code,
        // 'input': assignment.testCases,
        // 'language': assignment.language,
        // 'version': 'latest',
        // 'code': code,
        // 'input': assignment.testCases,
      }),
    );

    log(response.body);

    if (response.statusCode == 200) {
      String codeOutput = jsonDecode(response.body)['Result'];
      codeOutput = codeOutput.trim().replaceAll("\n", '');
      log("Output: $codeOutput");
      log("Expected Output: ${widget.assignment!.expectedOutput}");
      setState(() {
        output = codeOutput;
        _codeController.text = code;
      });
    } else {
      setState(() {
        output = 'Unexpected error occured while executing code';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log(widget.assignment!.testCases);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorConstants.kPrimaryColor),
        backgroundColor: ColorConstants.kBackgroundColor,
        title: Text(
          "${widget.assignment!.assignmentNumber}. ${widget.assignment!.title}",
          style: const TextStyle(
            color: ColorConstants.kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: widget.studentAssignment.status == "accepted"
                    ? Colors.green
                    : widget.studentAssignment.status == "rejected"
                        ? Colors.red
                        : Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  widget.studentAssignment.status == "accepted"
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : widget.studentAssignment.status == "rejected"
                          ? const Icon(
                              Icons.close,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.block,
                              color: Colors.white,
                            ),
                  Text(
                    widget.studentAssignment.status.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: widget.assignment == null
          ? const Center(child: Text('There was an issue loading the assignment.'))
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.assignment!.description,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          widget.studentAssignment.learnerType.isEmpty
                              ? Container()
                              : Text(
                                  widget.studentAssignment.isPlagiarized ? "Plagiarism Detected" : "No Plagiarism",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: widget.studentAssignment.isPlagiarized ? Colors.red : Colors.green,
                                  ),
                                ),
                          widget.studentAssignment.learnerType.isEmpty
                              ? Container()
                              : Text(
                                  "Plagiarism Score: ${widget.studentAssignment.plagiarismScore.toStringAsFixed(5)}",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                          widget.studentAssignment.learnerType.isEmpty
                              ? Container()
                              : Text(
                                  "Learner Type: ${widget.studentAssignment.learnerType.toUpperCase()}",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                          Text(
                            widget.studentAssignment.isAI,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                          widget.studentAssignment.learnerType.isEmpty ? Container() : const SizedBox(height: 20),
                          widget.studentAssignment.versions.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No submissions have been made yet.',
                                    style: TextStyle(
                                      color: ColorConstants.kPrimaryColor,
                                      fontSize: 24,
                                    ),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    widget.studentAssignment.versions.length,
                                    (index) => VersionDisplay(
                                      widget.studentAssignment.versions[index],
                                      widget.assignment!.language,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: ColorConstants.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SingleChildScrollView(
                          child: CodeField(
                            maxLines: null,
                            controller: _codeController,
                            textStyle: const TextStyle(fontFamily: 'SourceCode'),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Test Cases: ${widget.assignment!.testCases}',
                      maxLines: 1,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Expected Output: ${widget.assignment!.expectedOutput}',
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Actual Output: $output',
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          String code = _codeController.text.replaceAll('·', ' ');
                          runCode(code);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Submit Assignment',
                          style: TextStyle(
                            color: ColorConstants.kBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
