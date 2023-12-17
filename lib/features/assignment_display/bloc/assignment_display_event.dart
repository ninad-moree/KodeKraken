part of 'assignment_display_bloc.dart';

abstract class AssignmentDisplayEvent {}

class AssignmentDisplaySuccessEvent extends AssignmentDisplayEvent {
  final String message;
  AssignmentDisplaySuccessEvent({required this.message});
}

class AssignmentDisplayFailureEvent extends AssignmentDisplayEvent {
  final String message;
  AssignmentDisplayFailureEvent({required this.message});
}
