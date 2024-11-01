import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodle/models/student_submission.dart';

class TeacherRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadTeachingMaterial(
      String teacherId, File materialFile, String title) async {
    String fileUrl = "";

    await _firestore.collection("teachingMaterials").add({
      "teacherId": teacherId,
      "title": title,
      "fileUrl": fileUrl,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<void> uploadVideo(
      String teacherId, File videoFile, String title) async {
    String videoUrl = "";

    await _firestore.collection("teachingVideos").add({
      "teacherId": teacherId,
      "title": title,
      "videoUrl": videoUrl,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<List<StudentSubmission>> getStudentSubmissions() async {
    QuerySnapshot snapshot =
        await _firestore.collection("studentSubmissions").get();

    return snapshot.docs.map((doc) {
      return StudentSubmission.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
