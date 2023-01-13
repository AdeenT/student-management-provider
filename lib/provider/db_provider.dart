import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_sample/db/model/data_model.dart';

class DataBaseProvider with ChangeNotifier {
  List<StudentModel> studentList = [];
  late TextEditingController name;
  late TextEditingController age;
  late TextEditingController register;
  late TextEditingController email;

  void getAllStudent() async {
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    studentList.clear();
    studentList.addAll(studentDb.values);
    notifyListeners();
  }

  void updateStudent(StudentModel model) {
    name = TextEditingController(text: model.name);
    age = TextEditingController(text: model.age);
    register = TextEditingController(text: model.register);
    email = TextEditingController(text: model.email);
    notifyListeners();
  }
}
