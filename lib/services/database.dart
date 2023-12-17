import 'dart:convert';
import 'dart:developer';
import 'package:kode_kraken/models/assignment.dart';
import 'package:kode_kraken/models/student_assignment.dart';

import '../models/student.dart';
import '../models/teacher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

class Database {
  static final _firestore = FirebaseFirestore.instance;

  static Future<Student?> verifyStudent(String email, String password) async {
    var signature = sha1.convert(utf8.encode(email + password)).toString();
    var result =
        await _firestore.collection('studentAccounts').doc(signature).get();
    if (result.exists) {
      var student = Student.fromJson(result.data()!);
      return student;
    }
    return null;
  }

  static Future<Teacher?> verifyTeacher(String email, String password) async {
    var signature = sha1.convert(utf8.encode(email + password)).toString();
    var result =
        await _firestore.collection('teacherAccounts').doc(signature).get();
    if (result.exists) {
      var teacher = Teacher.fromJson(result.data()!);
      return teacher;
    }
    return null;
  }

  static Future<Map?> getSubjects(Student student) async {
    var result =
        await _firestore.collection('batches').doc(student.batch).get();
    if (result.exists) {
      var data = result.data()!['subjects'] as Map;
      Map map = {};
      data.forEach(
        (key, value) {
          var temp = [];
          for (var element in (value as List)) {
            temp.add(Assignment.fromJson(element));
          }
          map[key] = temp;
        },
      );
      return map;
    } else {
      log('Invalid Batch');
      return null;
    }
  }

  static Future<Map<String, List<Assignment>>?> getAllSubjects(
      String batch) async {
    var result = await _firestore.collection('batches').doc(batch).get();
    if (result.exists) {
      var data = result.data()!['subjects'] as Map;
      Map<String, List<Assignment>> map = {};
      data.forEach(
        (key, value) {
          List<Assignment> temp = [];
          for (var element in (value as List)) {
            temp.add(Assignment.fromJson(element));
          }
          map[key] = temp;
        },
      );
      return map;
    } else {
      log('Invalid Batch');
      return null;
    }
  }

  static Future<List<String>> getBatches() async {
    var result = await _firestore.collection('batches').get();
    List<String> batchName = [];
    List<DocumentSnapshot> docs = result.docs;
    // ignore: avoid_function_literals_in_foreach_calls
    docs.forEach(
      (element) => batchName.add(element.id),
    );
    return batchName;
  }

  static Future<StudentAssignment?> getAssignmentDetails(
      Assignment assignment, Student student) async {
    for (var element in student.assignments) {
      var studentAssignment =
          (await _firestore.collection('assignment').doc(element).get()).data();
      if (studentAssignment != null) {
        if (studentAssignment['number'] == assignment.assignmentNumber) {
          return StudentAssignment.fromJson(studentAssignment);
        }
      }
    }
    return null;
  }

  static Future<StudentAssignment> createStudentAssignment(
      Student student, Assignment assignment, String subject) {
    var studentAssignment = StudentAssignment(
      id: sha1
          .convert(utf8
              .encode(student.email + assignment.assignmentNumber.toString()))
          .toString(),
      number: assignment.assignmentNumber,
      status: 'not submitted',
      versions: [],
      subject: subject,
      //assignemntID: '', //
    );
    return _firestore
        .collection('assignment')
        .add(StudentAssignment.toJson(studentAssignment))
        .then((value) {
      student.assignments.add(value.id);
      _firestore
          .collection('studentAccounts')
          .doc(student.signature)
          .update(student.toJson());
      studentAssignment.id = value.id;
      _firestore
          .collection('assignment')
          .doc(value.id)
          .update(StudentAssignment.toJson(studentAssignment));
      return studentAssignment;
    });
  }

  static Future codeExecutedCorrectly(
      String code, StudentAssignment studentAssignment) async {
    var result = await _firestore
        .collection('assignment')
        .doc(studentAssignment.id)
        .get();
    if (result.exists) {
      var data = result.data()!;
      data['versions'].add({"code": code, "date": Timestamp.now()});
      data['status'] = "accepted";
      await _firestore
          .collection('assignment')
          .doc(studentAssignment.id)
          .update(data);
    }
  }

  static Future codeExecutedIncorrectly(
      String code, StudentAssignment studentAssignment) async {
    var result = await _firestore
        .collection('assignment')
        .doc(studentAssignment.id)
        .get();
    if (result.exists) {
      var data = result.data()!;
      data['status'] = "rejected";
      await _firestore
          .collection('assignment')
          .doc(studentAssignment.id)
          .update(data);
    }
  }

  static Future codeVersionSubmit(
      String code, StudentAssignment studentAssignment) async {
    var result = await _firestore
        .collection('assignment')
        .doc(studentAssignment.id)
        .get();
    if (result.exists) {
      var data = result.data()!;
      data['versions'].add({"code": code, "date": Timestamp.now()});
      data['status'] = "submitted";
      await _firestore
          .collection('assignment')
          .doc(studentAssignment.id)
          .update(data);
    }
  }

  static Future<Assignment?> getAssignmentDetailsFromStudentAssignments(
      String subject, int assignmentNumber, int rollNumber) async {
    var students = (await _firestore.collection('studentAccounts').get()).docs;
    Student student;
    String batch = 'E2';
    for (var element in students) {
      var data = element.data();
      if (data['rollno'] == rollNumber) {
        student = Student.fromJson(data);
        batch = student.batch;
      }
    }
    var subjects = (await _firestore.collection('batches').doc(batch).get())
        .data()!['subjects'];
    List assignments = subjects[subject];
    for (var element in assignments) {
      if (element['number'] == assignmentNumber) {
        return Assignment.fromJson(element);
      }
    }
    return null;
  }

  static Future getStudentAssignments(int rollNo) async {
    final QuerySnapshot result =
        await _firestore.collection('studentAccounts').get();
    final List documents = result.docs;

    for (var element in documents) {
      var data = element.data();
      if (data!['rollno'] == rollNo) {
        List assignmentAddresses = [];
        Map studentAssignments = {};
        assignmentAddresses = data['assignments'];
        for (var assignmentAddress in assignmentAddresses) {
          var result = await _firestore
              .collection('assignment')
              .doc(assignmentAddress)
              .get();
          if (result.exists) {
            var data = result.data()!;
            if (studentAssignments[data['subject']] == null) {
              studentAssignments[data['subject']] = [
                StudentAssignment.fromJson(data)
              ];
            } else {
              studentAssignments[data['subject']]
                  .add(StudentAssignment.fromJson(data));
            }
          }
        }
        return studentAssignments;
      }
    }
  }
}
