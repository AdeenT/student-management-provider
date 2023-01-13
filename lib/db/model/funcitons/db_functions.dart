import 'package:hive_flutter/adapters.dart';
import 'package:hive_sample/db/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_sample/provider/db_provider.dart';
import 'package:provider/provider.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<int> addStudent(StudentModel value) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  studentDb.put(value.id, value);
  return 0;
}

Future<void> deleteStudent(context, String id) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  await studentDb.delete(id);
  WidgetsBinding.instance.addPostFrameCallback(
    (timeStamp) =>
        Provider.of<DataBaseProvider>(context, listen: false).getAllStudent(),
  );
}

Future<void> updateStudent(StudentModel model) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.put(model.id, model);
}
