import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/assignment.dart';
import '../../../../models/student.dart';
import '../../bloc/assignment_display_bloc.dart';
import 'assignment_data_display_page.dart';

class AssignmentDisplay extends StatelessWidget {
  final Assignment assignment;
  final Student student;
  final String subject;
  const AssignmentDisplay({
    super.key,
    required this.assignment,
    required this.student,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignmentDisplayBloc()..getAssignmentDetails(assignment, student, subject),
      child: BlocConsumer<AssignmentDisplayBloc, AssignmentDisplayState>(
        listener: (context, state) {
          if (state is AssignmentDisplaySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(state.message),
              ),
            );
          } else if (state is AssignmentDisplayFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AssignmentDisplayLoading) {
            return const Scaffold(
              body: Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (state is AssignmentDisplayLoaded) {
            return AssignmentDataDisplayPage(
              assignment: state.assignment,
              studentAssignment: state.studentAssignment,
              student: state.student,
            );
          } else if (state is AssignmentDisplayError) {
            return Scaffold(
              body: Center(
                child: Text(state.message),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text("Something went wrong"),
            ),
          );
        },
      ),
    );
  }
}
