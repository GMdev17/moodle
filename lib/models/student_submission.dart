import 'package:cloud_firestore/cloud_firestore.dart';

class StudentSubmission {
  final String studentId;
  final String assignmentId;
  final String fileUrl;
  final String submissionTitle;
  final DateTime submittedAt;

  StudentSubmission({
    required this.studentId,
    required this.assignmentId,
    required this.fileUrl,
    required this.submissionTitle,
    required this.submittedAt,
  });

  factory StudentSubmission.fromMap(Map<String, dynamic> data) {
    return StudentSubmission(
      studentId: data["studentId"],
      assignmentId: data["assignmentId"],
      fileUrl: data["fileurl"],
      submissionTitle: data["submissionTitle"],
      submittedAt: (data["submittedAt"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "studentId": studentId,
      "assignmentId": assignmentId,
      "fileUrl": fileUrl,
      "submissionTitle": submissionTitle,
      "submittedAt": submittedAt,
    };
  }
}
