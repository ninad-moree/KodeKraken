import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kode_kraken/features/teacher_view/ui/subject_assignment.dart';

import '../../../constants/color_constants.dart';
import '../../../services/database.dart';

class AssignmentBatchSubject extends StatelessWidget {
  const AssignmentBatchSubject({super.key, required this.batch});

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
            child: CircleAvatar(
              backgroundColor: ColorConstants.kPrimaryColor,
              child: Text(
                batch,
                style: const TextStyle(
                  color: ColorConstants.kBackgroundColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Database.getAllSubjects(batch),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: ColorConstants.kPrimaryColor),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // crossAxisCount: 4,
                    // childAspectRatio: 1.5,
                    crossAxisCount: 4,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => SubjectAssignment(
                              batch: batch,
                              subject: snapshot.data!.keys.toList()[index],
                              subjectAssignments: snapshot.data![snapshot.data!.keys.toList()[index]]!,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          color: ColorConstants.grey,
                          shadowColor: ColorConstants.lightYellow,
                          elevation: 12,
                          child: Center(
                            child: Text(
                              snapshot.data!.keys.toList()[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "No batches found.",
                  style: TextStyle(
                    color: ColorConstants.kPrimaryColor,
                    fontSize: 32,
                  ),
                ),
              );
            }
          }
          return const CircularProgressIndicator(color: ColorConstants.kPrimaryColor);
        },
      ),
    );
  }
}
