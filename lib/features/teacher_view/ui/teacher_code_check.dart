import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kode_kraken/models/student_assignment.dart';

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
  final TextEditingController codeController = TextEditingController();
  String output = 'Waiting for output';

  @override
  void initState() {
    runCode(widget.studentAssignment.versions.last['code']);
    codeController.text = widget.studentAssignment.versions.last['code'];
    super.initState();
  }

  Future runCode(String code) async {
    var response = await http.post(
      Uri.parse("https://online-code-compiler.p.rapidapi.com/v1/"),
      headers: {
        'content-type': 'application/json',
        'X-RapidAPI-Key': '8c8aadd9b2msh97b85b5bf821197p1ea1a1jsn28f28c753386',
        'X-RapidAPI-Host': 'online-code-compiler.p.rapidapi.com'
      },
      body: jsonEncode({
        'language': widget.assignment!.language,
        'version': 'latest',
        'code': code,
        'input': widget.assignment!.testCases,
      }),
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      String codeOutput = jsonDecode(response.body)['output'];
      codeOutput = codeOutput.trim().replaceAll("\n", '');
      log("Output: $codeOutput");
      log("Expected Output: ${widget.assignment!.expectedOutput}");
      setState(() {
        output = codeOutput;
        codeController.text = code;
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
        title: Text(widget.rollNumber),
      ),
      body: widget.assignment == null
          ? const Center(
              child: Text('There was an isssue loading the assignment.'),
            )
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.assignment!.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.assignment!.description,
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          widget.studentAssignment.versions.isEmpty
                              ? const Center(
                                  child: Text(
                                      'No submissions have been made yet.'),
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
                        color: Colors.grey[300],
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your code here',
                            ),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            controller: codeController,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Test Cases: ${widget.assignment!.testCases}',
                      maxLines: 1,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
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
                            'Expected Output: ${widget.assignment!.expectedOutput}'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Actual Output: $output'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          runCode(codeController.text);
                        },
                        child: const Text('Submit Assignment'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
