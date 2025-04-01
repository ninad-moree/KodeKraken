// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        title: Row(
          children: [
            SvgPicture.asset(
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
            Expanded(
              child: Center(
                child: Text(
                  rollNumber.toString(),
                  style: const TextStyle(
                    color: ColorConstants.kPrimaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SvgPicture.asset(
              color: ColorConstants.kBackgroundColor,
              'assets/images/logo.svg',
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
            const Text(
              'KodeKraken',
              style: TextStyle(
                color: ColorConstants.kBackgroundColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
                  crossAxisCount: 4,
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
                            subject: (data.values.toList()[index][0]
                                    as StudentAssignment)
                                .subject,
                            assignments: (data[(data.values.toList()[index][0]
                                    as StudentAssignment)
                                .subject]),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: ColorConstants.grey,
                        shadowColor: ColorConstants.lightYellow,
                        elevation: 12,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data.keys.toList()[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: ColorConstants.kPrimaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Assignments: ${data.values.toList()[index].length}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
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
                child: CircularProgressIndicator(
                    color: ColorConstants.kPrimaryColor),
              ),
            );
          }
          return const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                  color: ColorConstants.kPrimaryColor),
            ),
          );
        },
      ),
    );
  }
}
