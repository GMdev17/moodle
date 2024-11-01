import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodle/blocs/students/students_bloc.dart';
import 'package:moodle/repositories/student_repo.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  late final StudentsBloc _studentBloc;

  @override
  void initState() {
    super.initState();
    _studentBloc = StudentsBloc(StudentRepository());
  }

  void _submitAssignment() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String assignmentUrl = "";
      String assignmentType = "Homework";
      _studentBloc
          .add(SubmitAssignmentRequested(assignmentUrl, assignmentType));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Students Page")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _submitAssignment,
            child: const Text("Submit Assignment/Homework"),
          ),
          Expanded(
            child: BlocBuilder<StudentsBloc, StudentsState>(
              bloc: _studentBloc,
              builder: (context, state) {
                if (state is AssignmentSubmitting) {
                  return const CircularProgressIndicator();
                } else if (state is AssignmentSubmitted) {
                  return const Center(
                      child: Text("Assignment Submitted Successfully!"));
                } else if (state is AssignmentSubmissionError) {
                  return Text("Error: ${state.error}");
                }
                return const Center(
                    child: Text("Submit an assignment or homework."));
              },
            ),
          ),
        ],
      ),
    );
  }
}
