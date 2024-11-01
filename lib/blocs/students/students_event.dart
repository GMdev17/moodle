part of 'students_bloc.dart';

@immutable
abstract class StudentsEvent {}

class SubmitAssignmentRequested extends StudentsEvent {
  final String assignmentUrl;
  final String assignmentType;

  SubmitAssignmentRequested(this.assignmentUrl, this.assignmentType);
}
