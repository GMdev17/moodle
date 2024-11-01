import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moodle/repositories/student_repo.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  final StudentRepository studentRepository;

  StudentsBloc(this.studentRepository) : super(StudentsInitial()) {
    on<SubmitAssignmentRequested>((event, emit) async {
      emit(AssignmentSubmitting());
      try {
        await studentRepository.submitAssignment(
            event.assignmentUrl, event.assignmentType);
        emit(AssignmentSubmitted());
      } catch (e) {
        emit(AssignmentSubmissionError(
            "Failed to submit assignment: ${e.toString()}"));
      }
    });
  }
}
