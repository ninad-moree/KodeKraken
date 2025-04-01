// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../models/student.dart';
import '../../../services/database.dart';

part 'student_page_event.dart';
part 'student_page_state.dart';

class StudentPageBloc extends Bloc<StudentPageEvent, StudentPageState> {
  final List<StudentPageState> _history = [];

  StudentPageBloc() : super(StudentPageInitial()) {
    on<StudentPageSubjectSelectEvent>(subjectSelected);
    on<StudentPageBackEvent>(goBack);
  }

  void getAllSubjects(Student student) async {
    emit(StudentPageLoading());
    var result = await Database.getSubjects(student);
    if (result != null) {
      _history.clear();
      _history.add(StudentPageLoaded(subjects: result));
      emit(StudentPageLoaded(subjects: result));
    } else {
      emit(StudentPageError(message: 'Invalid Subject'));
    }
  }

  FutureOr<void> subjectSelected(StudentPageSubjectSelectEvent event, Emitter<StudentPageState> emit) {
    _history.add(state);
    emit(StudentPageSubjectSelected(assignments: event.assignments, subject: event.subject));
  }

  FutureOr<void> goBack(StudentPageBackEvent event, Emitter<StudentPageState> emit) async {
    if (_history.isNotEmpty) {
      _history.removeLast();
      emit(_history.isNotEmpty ? _history.last : StudentPageInitial());
    }
  }
}
