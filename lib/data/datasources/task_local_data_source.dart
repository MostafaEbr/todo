import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> saveTasks(List<TaskModel> tasks);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String TASKS_KEY = 'TASKS';

  TaskLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<TaskModel>> getTasks() async {
    final jsonString = sharedPreferences.getString(TASKS_KEY);
    if (jsonString != null) {
      final List decoded = json.decode(jsonString);
      return decoded.map((task) => TaskModel.fromJson(task)).toList();
    }
    return [];
  }

  @override
  Future<void> saveTasks(List<TaskModel> tasks) async {
    final String jsonString = json.encode(tasks.map((task) => task.toJson()).toList());
    sharedPreferences.setString(TASKS_KEY, jsonString);
  }
}
