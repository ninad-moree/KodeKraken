import 'package:code_text_field/code_text_field.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kode_kraken/constants/color_constants.dart';
// import 'package:highlight/languages/python.dart';
// import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

import '../../../../models/assignment.dart';
import '../../../../models/student.dart';
import '../../../../models/student_assignment.dart';
import '../../bloc/assignment_display_bloc.dart';
import '../widgets/version_display.dart';

class AssignmentDataDisplayPage extends StatefulWidget {
  final Assignment assignment;
  final StudentAssignment? studentAssignment;
  final Student student;
  const AssignmentDataDisplayPage({
    super.key,
    required this.assignment,
    required this.studentAssignment,
    required this.student,
  });

  @override
  State<AssignmentDataDisplayPage> createState() => _AssignmentDataDisplayPageState();
}

class _AssignmentDataDisplayPageState extends State<AssignmentDataDisplayPage> {
  final TextEditingController codeController = TextEditingController();
  late ConfettiController confettiController;
  late CodeController _codeController;

  void playConfetti() async {
    if (widget.studentAssignment!.status == "accepted") {
      confettiController.play();
    }
  }

  @override
  void initState() {
    confettiController = ConfettiController(duration: const Duration(seconds: 1));
    playConfetti();
    super.initState();

    const source = "";
    _codeController = CodeController(
      text: source,
      language: cpp,
      theme: monokaiSublimeTheme,
    );
  }

  @override
  void dispose() {
    confettiController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: ColorConstants.kPrimaryColor),
            backgroundColor: ColorConstants.kBackgroundColor,
            title: Text(
              "${widget.assignment.assignmentNumber}. ${widget.assignment.title}",
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
                    color: widget.studentAssignment!.status == "accepted"
                        ? Colors.green
                        : widget.studentAssignment!.status == "rejected"
                            ? Colors.red
                            : Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      widget.studentAssignment!.status == "accepted"
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : widget.studentAssignment!.status == "rejected"
                              ? const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )
                              : Container(),
                      Text(
                        widget.studentAssignment!.status.toUpperCase(),
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
          body: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.assignment.description,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.studentAssignment!.isPlagiarized ? 'Plagiarism detected' : '',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        widget.studentAssignment!.isPlagiarized ? const SizedBox(height: 20) : const SizedBox(height: 0),
                        const Text(
                          "Submissions:",
                          style: TextStyle(
                            color: ColorConstants.kPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        widget.studentAssignment!.versions.isEmpty
                            ? const Center(
                                child: Text(
                                  'No submissions have been made yet.',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  widget.studentAssignment!.versions.length,
                                  (index) => VersionDisplay(
                                    widget.studentAssignment!.versions[index],
                                    widget.assignment.language,
                                  ),
                                ),
                              ),
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
                  // Expanded(
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width / 2,
                  //     decoration: BoxDecoration(
                  //       color: ColorConstants.grey,
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 12),
                  //       child: TextField(
                  //         cursorColor: ColorConstants.kPrimaryColor,
                  //         decoration: const InputDecoration(
                  //           border: InputBorder.none,
                  //           hintText: 'Enter your code here',
                  //         ),
                  //         style: const TextStyle(
                  //           color: Colors.white,
                  //         ),
                  //         maxLines: null,
                  //         keyboardType: TextInputType.multiline,
                  //         controller: codeController,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            String code = _codeController.text.replaceAll('·', ' ');
                            BlocProvider.of<AssignmentDisplayBloc>(context).submitVersion(
                              code,
                              widget.student,
                              widget.assignment,
                              widget.studentAssignment!,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.lightYellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Submit Version',
                            style: TextStyle(
                              color: ColorConstants.kBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            String code = _codeController.text.replaceAll('·', ' ');
                            BlocProvider.of<AssignmentDisplayBloc>(context).submitAssignment(
                              code,
                              widget.student,
                              widget.assignment,
                              widget.studentAssignment!,
                            );
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
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ConfettiWidget(
                confettiController: confettiController,
                maxBlastForce: 5, // set a lower max blast force
                minBlastForce: 2, // set a lower min blast force
                emissionFrequency: 0.01,
                numberOfParticles: 50, // a lot of particles at once
                gravity: 0.69,
                blastDirectionality: BlastDirectionality.explosive,
              ),
              ConfettiWidget(
                confettiController: confettiController,
                maxBlastForce: 5, // set a lower max blast force
                minBlastForce: 2, // set a lower min blast force
                emissionFrequency: 0.01,
                numberOfParticles: 50, // a lot of particles at once
                gravity: 0.69,
                blastDirectionality: BlastDirectionality.explosive,
              ),
              ConfettiWidget(
                confettiController: confettiController,
                maxBlastForce: 5, // set a lower max blast force
                minBlastForce: 2, // set a lower min blast force
                emissionFrequency: 0.01,
                numberOfParticles: 50, // a lot of particles at once
                gravity: 0.69,
                blastDirectionality: BlastDirectionality.explosive,
              ),
              ConfettiWidget(
                confettiController: confettiController,
                maxBlastForce: 5, // set a lower max blast force
                minBlastForce: 2, // set a lower min blast force
                emissionFrequency: 0.01,
                numberOfParticles: 50, // a lot of particles at once
                gravity: 0.69,
                blastDirectionality: BlastDirectionality.explosive,
              ),
              ConfettiWidget(
                confettiController: confettiController,
                maxBlastForce: 5, // set a lower max blast force
                minBlastForce: 2, // set a lower min blast force
                emissionFrequency: 0.01,
                numberOfParticles: 50, // a lot of particles at once
                gravity: 0.69,
                blastDirectionality: BlastDirectionality.explosive,
              ),
              ConfettiWidget(
                confettiController: confettiController,
                maxBlastForce: 5, // set a lower max blast force
                minBlastForce: 2, // set a lower min blast force
                emissionFrequency: 0.01,
                numberOfParticles: 50, // a lot of particles at once
                gravity: 0.69,
                blastDirectionality: BlastDirectionality.explosive,
              ),
              ConfettiWidget(
                confettiController: confettiController,
                maxBlastForce: 5, // set a lower max blast force
                minBlastForce: 2, // set a lower min blast force
                emissionFrequency: 0.01,
                numberOfParticles: 50, // a lot of particles at once
                gravity: 0.69,
                blastDirectionality: BlastDirectionality.explosive,
              ),
              ConfettiWidget(
                confettiController: confettiController,
                maxBlastForce: 5, // set a lower max blast force
                minBlastForce: 2, // set a lower min blast force
                emissionFrequency: 0.01,
                numberOfParticles: 50, // a lot of particles at once
                gravity: 0.69,
                blastDirectionality: BlastDirectionality.explosive,
              ),
              ConfettiWidget(
                confettiController: confettiController,
                maxBlastForce: 5, // set a lower max blast force
                minBlastForce: 2, // set a lower min blast force
                emissionFrequency: 0.01,
                numberOfParticles: 50, // a lot of particles at once
                gravity: 0.69,
                blastDirectionality: BlastDirectionality.explosive,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
