part of 'teachers_bloc.dart';

@immutable
abstract class TeachersState {}

class TeachersInitial extends TeachersState {}

class TeacherLoading extends TeachersState {}

class MaterialUploaded extends TeachersState {}

class VideoUploaded extends TeachersState {}

class SubmissionFetched extends TeachersState {
  final List<StudentSubmission> submissions;

  SubmissionFetched(this.submissions);
}

class TeacherError extends TeachersState {
  final String error;

  TeacherError(this.error);
}
