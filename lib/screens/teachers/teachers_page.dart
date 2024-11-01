import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodle/blocs/teachers/teachers_bloc.dart';
import 'package:moodle/repositories/teacher_repo.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  late final TeachersBloc _teachersBloc;

  @override
  void initState() {
    super.initState();
    _teachersBloc = TeachersBloc(TeacherRepository())
      ..add(FetchStudentSubmissions());
  }

  void _uploadTeachingMaterial() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result == null) {
      print("File picking was canceled");
      return;
    }

    File file = File(result.files.single.path!);
    _teachersBloc.add(UploadTeachingMaterial(file, "Teaching Material"));
  }

  void _uploadTeachingVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      _teachersBloc.add(UploadVideo(file, "Teaching Video"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teachers Page")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _uploadTeachingMaterial,
            child: const Text("Upload Teaching Material"),
          ),
          ElevatedButton(
            onPressed: _uploadTeachingVideo,
            child: const Text("Upload Teaching Video"),
          ),
          Expanded(
            child: BlocBuilder<TeachersBloc, TeachersState>(
              bloc: _teachersBloc,
              builder: (context, state) {
                if (state is TeacherLoading) {
                  return const CircularProgressIndicator();
                } else if (state is SubmissionFetched) {
                  return ListView.builder(
                    itemCount: state.submissions.length,
                    itemBuilder: (context, index) {
                      final submission = state.submissions[index];
                      return ListTile(
                        title: Text(submission.submissionTitle),
                        subtitle: Text("Submitted by ${submission.studentId}"),
                      );
                    },
                  );
                } else if (state is TeacherError) {
                  return Center(child: Text("Error: ${state.error}"));
                }
                return const Center(child: Text("No submissions yet."));
              },
            ),
          ),
        ],
      ),
    );
  }
}
