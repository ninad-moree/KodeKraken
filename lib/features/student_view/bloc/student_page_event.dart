part of 'student_page_bloc.dart';

abstract class StudentPageEvent {}

class StudentPageInitialEvent extends StudentPageEvent {
  Student student;
  StudentPageInitialEvent({required this.student});
}

class StudentPageSubjectSelectEvent extends StudentPageEvent {
  String subject;
  List assignments;
  StudentPageSubjectSelectEvent({required this.assignments, required this.subject});
}
