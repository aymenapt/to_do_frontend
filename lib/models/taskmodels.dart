import 'package:flutter/foundation.dart';

class TaskModels {
  final int id ;
  final String title;
  final String descreption;
  final String task_date;

  TaskModels(
      {
        required this.id ,
        required this.title,
      required this.descreption,
      required this.task_date});

  factory TaskModels.fromJson(Map<String, dynamic> jsonData) {
    return TaskModels(
      id: jsonData['id'],
        title: jsonData['title'],
        descreption: jsonData['description'],
        task_date: jsonData['task_date']);
  }
}
