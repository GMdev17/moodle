import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodle/services/auth_service.dart';

class StudentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitAssignment(
      String assignmentUrl, String assignmentType) async {
    final userId = AuthService().getCurrentUserId();
    if (userId != null) {
      await _firestore.collection("submissions").add({
        "studentId": userId,
        "type": assignmentType,
        "url": assignmentUrl,
        "submittedAt": FieldValue.serverTimestamp(),
      });
    }
  }
}
