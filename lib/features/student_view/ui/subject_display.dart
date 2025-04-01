// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/color_constants.dart';
import '../../../models/student.dart';
import '../../assignment_display/ui/pages/assignment_display.dart';
import '../bloc/student_page_bloc.dart';

class SubjectDisplay extends StatelessWidget {
  final Student student;
  const SubjectDisplay({required this.student, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<StudentPageBloc, StudentPageState>(
        builder: (context, state) {
          if (state is StudentPageInitial) {
            return const Text('Initial');
          } else if (state is StudentPageLoading) {
            return const CircularProgressIndicator(color: ColorConstants.kPrimaryColor);
          } else if (state is StudentPageLoaded) {
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
                  ],
                ),
                backgroundColor: ColorConstants.kBackgroundColor,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: ColorConstants.kPrimaryColor,
                      child: Text(
                        student.name[0].toUpperCase(),
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
              body: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
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
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          color: ColorConstants.grey,
                          shadowColor: ColorConstants.lightYellow,
                          elevation: 12,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  state.subjects.keys.toList()[index],
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
                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.kPrimaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Assignments: ${state.subjects.values.toList()[index].length}",
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
                ),
              ),
            );
          } else if (state is StudentPageSubjectSelected) {
            int numOfAssgn = state.assignments.length;
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
                  ],
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: ColorConstants.kPrimaryColor),
                  onPressed: () {
                    BlocProvider.of<StudentPageBloc>(context).add(StudentPageBackEvent());
                  },
                ),
                backgroundColor: ColorConstants.kBackgroundColor,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: ColorConstants.kPrimaryColor,
                      child: Text(
                        student.name[0].toUpperCase(),
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
              body: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: numOfAssgn == 0
                    ? const Center(
                        child: Text(
                          "No Assignments Available",
                          style: TextStyle(
                            color: Colors.white,
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
                        itemCount: state.assignments.length,
                        itemBuilder: (context, index) {
                          // int numOfAss = state.assignments.length;
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                color: ColorConstants.grey,
                                shadowColor: ColorConstants.lightYellow,
                                elevation: 12,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 100),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                        decoration: const BoxDecoration(
                                          color: ColorConstants.yellow,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                        child: Text(
                                          "${state.assignments[index].assignmentNumber}",
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
                                        "${state.assignments[index].title}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                        ),
                                        textAlign: TextAlign.center,
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
          } else if (state is StudentPageError) {
            return Text(state.message);
          } else {
            return const Text('Error');
          }
        },
      ),
    );
  }
}
