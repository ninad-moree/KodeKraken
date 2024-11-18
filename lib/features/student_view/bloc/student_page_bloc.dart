// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../models/student.dart';
import '../../../services/database.dart';

part 'student_page_event.dart';
part 'student_page_state.dart';

class StudentPageBloc extends Bloc<StudentPageEvent, StudentPageState> {
  StudentPageBloc() : super(StudentPageInitial()) {
    on<StudentPageSubjectSelectEvent>(subjectSelected);
  }

  void getAllSubjects(Student student) async {
    emit(StudentPageLoading());
    var result = await Database.getSubjects(student);
    if (result != null) {
      emit(StudentPageLoaded(subjects: result));
    } else {
      emit(StudentPageError(message: 'Invalid Subject'));
    }
  }

  FutureOr<void> subjectSelected(StudentPageSubjectSelectEvent event, Emitter<StudentPageState> emit) {
    emit(StudentPageSubjectSelected(assignments: event.assignments, subject: event.subject));
  }
}
