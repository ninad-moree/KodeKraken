// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kode_kraken/features/teacher_view/ui/teacher_code_check.dart';
import 'package:kode_kraken/services/database.dart';
import '../../../constants/color_constants.dart';
import '../../../models/assignment.dart';
import '../../../models/student_assignment.dart';

class AssignmentStatus extends StatelessWidget {
  const AssignmentStatus({
    Key? key,
    required this.rollNumber,
    required this.subject,
    required this.assignments,
  }) : super(key: key);

  final String rollNumber;
  final String subject;
  final List<StudentAssignment>? assignments;

  @override
  Widget build(BuildContext context) {
    if (assignments != null) {
      assignments!.sort((a, b) {
        return a.number.compareTo(b.number);
      });
    }
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
                  '$rollNumber-$subject',
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
      body: assignments == null || assignments!.isEmpty
          ? const Center(
              child: Text('No assignments assigned'),
            )
          : ListView.builder(
              itemCount: assignments!.length,
              itemBuilder: (context, index) {
                var studentAssignment =
                    assignments![index] as StudentAssignment;

                return ListTile(
                  onTap: () async {
                    Assignment? assignment = await Database
                        .getAssignmentDetailsFromStudentAssignments(
                      studentAssignment.subject,
                      studentAssignment.number,
                      int.parse(rollNumber),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CodeDisplayPage(
                          studentAssignment: studentAssignment,
                          rollNumber: rollNumber.toString(),
                          assignment: assignment,
                        ),
                      ),
                    );
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Assignment ${studentAssignment.number.toString()}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: studentAssignment.status == "accepted"
                              ? Colors.green
                              : studentAssignment.status == "rejected"
                                  ? Colors.red
                                  : Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            studentAssignment.status == "accepted"
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                : studentAssignment.status == "rejected"
                                    ? const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      )
                                    : Container(),
                            Text(
                              studentAssignment.status.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}

// // ignore_for_file: use_build_context_synchronously
// import 'package:flutter/material.dart';
// import 'package:kode_kraken/features/teacher_view/ui/teacher_code_check.dart';
// import 'package:kode_kraken/services/database.dart';
// import '../../../models/assignment.dart';
// import '../../../models/student_assignment.dart';

// class AssignmentStatus extends StatelessWidget {
//   const AssignmentStatus({
//     Key? key,
//     required this.rollNumber,
//     required this.subject,
//     required this.assignments,
//   }) : super(key: key);

//   final String rollNumber;
//   final String subject;
//   final List? assignments;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$rollNumber-$subject'),
//       ),
//       body: FutureBuilder(
//         future: Database.getBatches(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: assignments!.length,
//                 itemBuilder: (context, index) {
//                   var studentAssignment =
//                       assignments![index] as StudentAssignment;

//                   return ListTile(
//                     onTap: () async {
//                       Assignment? assignment = await Database
//                           .getAssignmentDetailsFromStudentAssignments(
//                         studentAssignment.subject,
//                         studentAssignment.number,
//                         int.parse(rollNumber),
//                       );
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CodeDisplayPage(
//                             studentAssignment: studentAssignment,
//                             rollNumber: rollNumber.toString(),
//                             assignment: assignment,
//                           ),
//                         ),
//                       );
//                     },
//                     title: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                             'Assignment ${studentAssignment.number.toString()}'),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: studentAssignment.status == "accepted"
//                                 ? Colors.green
//                                 : studentAssignment.status == "rejected"
//                                     ? Colors.red
//                                     : Colors.blue,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           padding: const EdgeInsets.all(8),
//                           child: Row(
//                             children: [
//                               studentAssignment.status == "accepted"
//                                   ? const Icon(
//                                       Icons.check,
//                                       color: Colors.white,
//                                     )
//                                   : studentAssignment.status == "rejected"
//                                       ? const Icon(
//                                           Icons.close,
//                                           color: Colors.white,
//                                         )
//                                       : Container(),
//                               Text(
//                                 studentAssignment.status.toUpperCase(),
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return const Center(
//                 child: Text("No batches found."),
//               );
//             }
//           }
//           return const CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }
