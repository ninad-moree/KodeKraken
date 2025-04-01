import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kode_kraken/features/teacher_view/ui/add_assignment.dart';
import 'package:kode_kraken/features/teacher_view/ui/edit_assignment.dart';
import 'package:kode_kraken/models/assignment.dart';

import '../../../constants/color_constants.dart';

class SubjectAssignment extends StatelessWidget {
  const SubjectAssignment({
    super.key,
    required this.subject,
    required this.subjectAssignments,
    required this.batch,
  });

  final List<Assignment> subjectAssignments;
  final String subject;
  final String batch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              // ignore: deprecated_member_use
              color: ColorConstants.kPrimaryColor,
              'assets/images/logo.svg',
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
            const Text(
              'KodeKraken',
              style: TextStyle(
                color: ColorConstants.kPrimaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => AddAssignmentPage(subject: subject, batch: batch),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Add Assignment',
                      style: TextStyle(
                        color: ColorConstants.kPrimaryColor,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.add)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 15),
        child: subjectAssignments.isEmpty
            ? const Center(
                child: Text(
                  "No Assignments Present",
                  style: TextStyle(
                    color: ColorConstants.yellow,
                    fontSize: 32,
                  ),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                itemCount: subjectAssignments.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        color: ColorConstants.grey,
                        shadowColor: ColorConstants.lightYellow,
                        elevation: 12,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: const Icon(Icons.edit, color: ColorConstants.kPrimaryColor),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => EditAssignmentPage(
                                          subject: subject,
                                          description: subjectAssignments[index].description.toString(),
                                          expectedOutput: subjectAssignments[index].expectedOutput.toString(),
                                          language: subjectAssignments[index].language,
                                          number: subjectAssignments[index].assignmentNumber,
                                          testCases: subjectAssignments[index].testCases,
                                          title: subjectAssignments[index].title,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    decoration: const BoxDecoration(
                                      color: ColorConstants.yellow,
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(
                                      "${subjectAssignments[index].assignmentNumber}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    subjectAssignments[index].title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  // Container(
                                  //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                                  //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: ColorConstants.kPrimaryColor),
                                  //   child: Text(
                                  //     "${subjectAssignments[index].assignmentNumber}",
                                  //     style: const TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: 20,
                                  //       fontWeight: FontWeight.bold,
                                  //       letterSpacing: 1.2,
                                  //     ),
                                  //     textAlign: TextAlign.center,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 12),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(horizontal: 12),
                                  //   child: Text(
                                  //     subjectAssignments[index].title,
                                  //     // subjectAssignments[index].description.toString(),
                                  //     style: const TextStyle(
                                  //       color: Colors.white,
                                  //       overflow: TextOverflow.ellipsis,
                                  //     ),
                                  //     maxLines: 5,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
