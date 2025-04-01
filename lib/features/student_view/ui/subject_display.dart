import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kode_kraken/constants/color_constants.dart';
import 'package:kode_kraken/features/student_view/bloc/student_page_bloc.dart';

import '../../../models/student.dart';
import '../../assignment_display/ui/pages/assignment_display.dart';

class SubjectDisplay extends StatelessWidget {
  final Student student;
  const SubjectDisplay({required this.student, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          student.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                student.name[0].toUpperCase(),
                style: const TextStyle(
                    color: ColorConstants.kPrimaryColor, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<StudentPageBloc, StudentPageState>(
          builder: (context, state) {
            if (state is StudentPageInitial) {
              return const Text('Initial');
            } else if (state is StudentPageLoading) {
              return const CircularProgressIndicator();
            } else if (state is StudentPageLoaded) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                itemCount: state.subjects.keys.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<StudentPageBloc>(context).add(
                        StudentPageSubjectSelectEvent(
                          subject: state.subjects.keys.toList()[index],
                          assignments: state.subjects.values.toList()[index],
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
                              state.subjects.keys.toList()[index],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                                "Assignments: ${state.subjects.values.toList()[index].length}")
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is StudentPageSubjectSelected) {
              return Scaffold(
                body: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  itemCount: state.assignments.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssignmentDisplay(
                              assignment: state.assignments[index],
                              student: student,
                              subject: state.subject,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${state.assignments[index].assignmentNumber}. ${state.assignments[index].title}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                state.assignments[index].description.toString(),
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is StudentPageError) {
              return Text(state.message);
            } else {
              return const Text('Error');
            }
          },
        ),
      ),
    );
  }
}
