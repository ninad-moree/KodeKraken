// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:kode_kraken/features/teacher_view/ui/assignment_status.dart';
import 'package:kode_kraken/models/student_assignment.dart';
import 'package:kode_kraken/services/database.dart';

import '../../../constants/color_constants.dart';

class SubmittedAssignments extends StatelessWidget {
  final String rollNumber;
  const SubmittedAssignments({super.key, required this.rollNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rollNumber.toString()),
      ),
      body: FutureBuilder(
        future: Database.getStudentAssignments(
          int.parse(rollNumber),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map data = snapshot.data;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                itemCount: data.keys.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => AssignmentStatus(
                            rollNumber: rollNumber.toString(),
                            subject: (data.values.toList()[index][0] as StudentAssignment).subject,
                            assignments: (data[(data.values.toList()[index][0] as StudentAssignment).subject]),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 12,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              data.keys.toList()[index],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Assignments: ${data.values.toList()[index].length}")
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("No Assignments"),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(color: ColorConstants.kPrimaryColor),
              ),
            );
          }
          return const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(color: ColorConstants.kPrimaryColor),
            ),
          );
        },
      ),
    );
  }
}
