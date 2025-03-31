// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';

import '../../../api/check_plagerism.dart';
import '../../../models/assignment.dart';
import '../../../models/student.dart';
import '../../../models/student_assignment.dart';
import '../../../services/database.dart';

part 'assignment_display_event.dart';
part 'assignment_display_state.dart';

class AssignmentDisplayBloc extends Bloc<AssignmentDisplayEvent, AssignmentDisplayState> {
  AssignmentDisplayBloc() : super(AssignmentDisplayInitial());

  FutureOr<void> getAssignmentDetails(Assignment assignment, Student student, String subject) async {
    emit(AssignmentDisplayLoading());
    var studentAssignment = await Database.getAssignmentDetails(assignment, student);
    if (studentAssignment != null) {
      emit(AssignmentDisplayLoaded(studentAssignment: studentAssignment, assignment: assignment, student: student));
      log(studentAssignment.toString());
    } else {
      studentAssignment = await Database.createStudentAssignment(student, assignment, subject);
      emit(AssignmentDisplayLoaded(assignment: assignment, student: student, studentAssignment: studentAssignment));
    }
  }

  FutureOr<void> submitAssignment(
    String code,
    Student student,
    Assignment assignment,
    StudentAssignment studentAssignment,
  ) async {
    emit(AssignmentDisplayLoading());
    var response = await http.post(
      // Uri.parse("https://online-code-compiler.p.rapidapi.com/v1/"),
      Uri.parse("https://code-compiler.p.rapidapi.com/v2"),
      headers: {
        'Content-Type': 'application/json',
        'X-RapidAPI-Key': 'e045d02908msh954c7b914f6d179p1f3208jsndfe0a23306bc',
        'x-rapidapi-host': 'code-compiler.p.rapidapi.com'
      },
      body: jsonEncode({
        'LanguageChoice': 7,
        'Program': code,
        // 'input': assignment.testCases,
        // 'language': assignment.language,
        // 'version': 'latest',
        // 'code': code,
        // 'input': assignment.testCases,
      }),
    );

    // log(response.body); --> {"Errors":null,"Result":"1","Stats":"No Status Available","Files":null}

    if (response.statusCode == 200) {
      String output = jsonDecode(response.body)['Result'];
      output = output.trim().replaceAll("\n", '');
      log("Output: $output");
      log("Expected Output: ${assignment.expectedOutput}");
      if (output == assignment.expectedOutput) {
        emit(AssignmentDisplaySuccess(message: "Correct Answer"));

        // Plagerism
        Map<String, dynamic> plagiarismResponse = await PlagiarismChecker().checkPlagiarism(
          assignment.referenceCode,
          code,
        );

        log("Is Plagerised: ${plagiarismResponse['is_plagiarized']}");
        log("Score: ${plagiarismResponse['similarity_score']}");

        await Database.codeExecutedCorrectly(code, studentAssignment);
      } else {
        emit(AssignmentDisplayFailure(message: "Wrong Answer"));
        await Database.codeExecutedIncorrectly(code, studentAssignment);
      }
      getAssignmentDetails(assignment, student, studentAssignment.subject);
    } else {
      emit(AssignmentDisplayError(message: "Error submitting code"));
    }
  }

  FutureOr<void> submitVersion(String code, Student student, Assignment assignment, StudentAssignment studentAssignment) async {
    emit(AssignmentDisplayLoading());
    await Database.codeVersionSubmit(code, studentAssignment);
    getAssignmentDetails(assignment, student, studentAssignment.subject);
  }
}
