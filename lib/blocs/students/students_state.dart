part of 'students_bloc.dart';

@immutable
abstract class StudentsState {}

class StudentsInitial extends StudentsState {}

class AssignmentSubmitting extends StudentsState {}

class AssignmentSubmitted extends StudentsState {}

class AssignmentSubmissionError extends StudentsState {
  final String error;

  AssignmentSubmissionError(this.error);
}
