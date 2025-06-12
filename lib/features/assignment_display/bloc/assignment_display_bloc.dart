// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:kode_kraken/api/classify_learner.dart';
import 'package:kode_kraken/api/code_ai_detection.dart';

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
    int langId,
    Student student,
    Assignment assignment,
    StudentAssignment studentAssignment,
  ) async {
    emit(AssignmentDisplayLoading());
    var response = await http.post(
      Uri.parse("https://code-compiler.p.rapidapi.com/v2"),
      headers: {
        'Content-Type': 'application/json',
        'X-RapidAPI-Key': 'e045d02908msh954c7b914f6d179p1f3208jsndfe0a23306bc',
        'x-rapidapi-host': 'code-compiler.p.rapidapi.com'
      },
      body: jsonEncode({
        'LanguageChoice': langId,
        'Program': code,
        // 'input': assignment.testCases,
        // 'language': assignment.language,
        // 'version': 'latest',
        // 'code': code,
        // 'input': assignment.testCases,
      }),
    );

    log(response.body); // --> {"Errors":null,"Result":"1","Stats":"No Status Available","Files":null}

    if (response.statusCode == 200) {
      String output = jsonDecode(response.body)['Result'].toString();
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

        Map<String, dynamic> learnerResponse = await ClassifyLearner().classifyLearner(
          studentAssignment.versions.length + 1,
          studentAssignment.versions.isEmpty
              ? 0
              : ClassifyLearner()
                  .getTimeDifferenceInMinutes((studentAssignment.versions[studentAssignment.versions.length - 1]['date'] as Timestamp).toDate())
                  .toDouble(),
          plagiarismResponse['plagerism_score'],
        );

        Map<String, dynamic> codeDetection = await CodeAiDetection().codeDetection(code);

        log("Is Plagerised: ${plagiarismResponse['is_plagiarized']}");
        log("Score: ${plagiarismResponse['plagerism_score']}");
        log(("Learner: ${learnerResponse['learner_type']}"));

        await Database.codeExecutedCorrectly(
          code,
          studentAssignment,
          plagiarismResponse['is_plagiarized'],
          plagiarismResponse['plagerism_score'],
          learnerResponse['learner_type'],
          codeDetection['verdict'],
        );
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
