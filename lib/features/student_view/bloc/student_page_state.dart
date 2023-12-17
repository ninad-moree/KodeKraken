part of 'student_page_bloc.dart';

abstract class StudentPageState {}

abstract class StudentPageActionState extends StudentPageState {}

class StudentPageInitial extends StudentPageState {}

class StudentPageLoading extends StudentPageState {}

class StudentPageLoaded extends StudentPageState {
  final Map subjects;

  StudentPageLoaded({
    required this.subjects,
  });
}

class StudentPageError extends StudentPageState {
  final String message;

  StudentPageError({
    required this.message,
  });
}

class StudentPageSubjectSelected extends StudentPageActionState {
  final String subject;
  final List assignments;

  StudentPageSubjectSelected({
    required this.assignments,
    required this.subject,
  });
}
