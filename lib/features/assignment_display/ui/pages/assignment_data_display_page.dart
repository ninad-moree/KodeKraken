import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kode_kraken/features/assignment_display/bloc/assignment_display_bloc.dart';
import 'package:kode_kraken/models/assignment.dart';

import '../../../../models/student.dart';
import '../../../../models/student_assignment.dart';
import '../widgets/version_display.dart';

class AssignmentDataDisplayPage extends StatefulWidget {
  final Assignment assignment;
  final StudentAssignment? studentAssignment;
  final Student student;
  const AssignmentDataDisplayPage(
      {super.key,
      required this.assignment,
      required this.studentAssignment,
      required this.student});

  @override
  State<AssignmentDataDisplayPage> createState() =>
      _AssignmentDataDisplayPageState();
}

class _AssignmentDataDisplayPageState extends State<AssignmentDataDisplayPage> {
  final TextEditingController codeController = TextEditingController();
  late ConfettiController confettiController;

  void playConfetti() async {
    if (widget.studentAssignment!.status == "accepted") {
      confettiController.play();
    }
  }

  @override
  void initState() {
    confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    playConfetti();
    super.initState();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
                "${widget.assignment.assignmentNumber}. ${widget.assignment.title}"),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.assignment.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: widget.studentAssignment!.status ==
                                        "accepted"
                                    ? Colors.green
                                    : widget.studentAssignment!.status ==
                                            "rejected"
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
                                      : widget.studentAssignment!.status ==
                                              "rejected"
                                          ? const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            )
                                          : Container(),
                                  Text(
                                    widget.studentAssignment!.status
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.assignment.description,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Submissions:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        widget.studentAssignment!.versions.isEmpty
                            ? const Center(
                                child:
                                    Text('No submissions have been made yet.'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () =>
                              BlocProvider.of<AssignmentDisplayBloc>(context)
                                  .submitVersion(
                                      codeController.text,
                                      widget.student,
                                      widget.assignment,
                                      widget.studentAssignment!),
                          child: const Text('Submit Version'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () =>
                              BlocProvider.of<AssignmentDisplayBloc>(context)
                                  .submitAssignment(
                            codeController.text,
                            widget.student,
                            widget.assignment,
                            widget.studentAssignment!,
                          ),
                          child: const Text('Submit Assignment'),
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
          child: ConfettiWidget(
            confettiController: confettiController,
            maxBlastForce: 5, // set a lower max blast force
            minBlastForce: 2, // set a lower min blast force
            emissionFrequency: 0.01,
            numberOfParticles: 100, // a lot of particles at once
            gravity: 0.69,
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ),
      ],
    );
  }
}
