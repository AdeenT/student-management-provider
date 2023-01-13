import 'package:hive_flutter/hive_flutter.dart';

part "data_model.g.dart";

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String register;

  StudentModel(
      {required this.name,
      required this.age,
      required this.email,
      required this.register,
      required this.id});
}
