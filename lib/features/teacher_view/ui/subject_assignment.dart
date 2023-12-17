import 'package:flutter/material.dart';
import 'package:kode_kraken/features/teacher_view/ui/add_assignment.dart';
import 'package:kode_kraken/features/teacher_view/ui/edit_assignment.dart';
import 'package:kode_kraken/models/assignment.dart';

class SubjectAssignment extends StatelessWidget {
  const SubjectAssignment(
      {super.key,
      required this.subject,
      required this.subjectAssignments,
      required this.batch});

  final List<Assignment> subjectAssignments;
  final String subject;
  final String batch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$batch - $subject'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        AddAssignmentPage(subject: subject, batch: batch),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Add Assignment'),
                    SizedBox(width: 5),
                    Icon(Icons.add)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        itemCount: subjectAssignments.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Card(
              elevation: 12,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    EditAssignmentPage(
                                        subject: subject,
                                        description: subjectAssignments[index]
                                            .description
                                            .toString(),
                                        expectedOutput:
                                            subjectAssignments[index]
                                                .expectedOutput
                                                .toString(),
                                        language:
                                            subjectAssignments[index].language,
                                        number: subjectAssignments[index]
                                            .assignmentNumber,
                                        testCases:
                                            subjectAssignments[index].testCases,
                                        title:
                                            subjectAssignments[index].title)),
                          );
                        },
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${subjectAssignments[index].assignmentNumber}. ${subjectAssignments[index].title}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            subjectAssignments[index].description.toString(),
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
