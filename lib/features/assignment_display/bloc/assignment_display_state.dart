part of 'assignment_display_bloc.dart';

abstract class AssignmentDisplayState {}

class AssignmentDisplayInitial extends AssignmentDisplayState {}

class AssignmentDisplayLoading extends AssignmentDisplayState {}

class AssignmentDisplayLoaded extends AssignmentDisplayState {
  final Student student;
  final Assignment assignment;
  final StudentAssignment? studentAssignment;
  AssignmentDisplayLoaded(
      {required this.student, this.studentAssignment, required this.assignment});
}

class AssignmentDisplayError extends AssignmentDisplayState {
  final String message;
  AssignmentDisplayError({required this.message});
}

class AssignmentDisplaySuccess extends AssignmentDisplayState {
  final String message;
  AssignmentDisplaySuccess({required this.message});
}

class AssignmentDisplayFailure extends AssignmentDisplayState {
  final String message;
  AssignmentDisplayFailure({required this.message});
}