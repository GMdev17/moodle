part of 'teachers_bloc.dart';

@immutable
abstract class TeachersEvent {}

class UploadTeachingMaterial extends TeachersEvent {
  final File materialFile;
  final String title;

  UploadTeachingMaterial(this.materialFile, this.title);
}

class UploadVideo extends TeachersEvent {
  final File videoFile;
  final String title;

  UploadVideo(this.videoFile, this.title);
}

class FetchStudentSubmissions extends TeachersEvent {}
