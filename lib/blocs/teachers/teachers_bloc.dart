import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moodle/models/student_submission.dart';
import 'package:moodle/repositories/teacher_repo.dart';
import 'package:moodle/services/auth_service.dart';

part 'teachers_event.dart';

part 'teachers_state.dart';

class TeachersBloc extends Bloc<TeachersEvent, TeachersState> {
  final TeacherRepository teacherRepository;
  final AuthService authService = AuthService();

  TeachersBloc(this.teacherRepository) : super(TeachersInitial()) {
    on<UploadTeachingMaterial>((event, emit) async {
      emit(TeacherLoading());
      try {
        final teacherId = authService.getCurrentUserId();
        if (teacherId != null) {
          await teacherRepository.uploadTeachingMaterial(
            "teacherId",
            event.materialFile,
            event.title,
          );
          emit(MaterialUploaded());
        } else {
          emit(TeacherError("No authenticated user found"));
        }
      } catch (e) {
        emit(TeacherError(e.toString()));
      }
    });

    on<UploadVideo>((event, emit) async {
      emit(TeacherLoading());
      try {
        await teacherRepository.uploadVideo(
          "teacherI",
          event.videoFile,
          event.title,
        );
        emit(VideoUploaded());
      } catch (e) {
        emit(TeacherError(e.toString()));
      }
    });

    on<FetchStudentSubmissions>((event, emit) async {
      emit(TeacherLoading());
      try {
        final submissions = await teacherRepository.getStudentSubmissions();
        emit(SubmissionFetched(submissions));
      } catch (e) {
        emit(TeacherError(e.toString()));
      }
    });
  }
}
