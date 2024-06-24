import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/presentation/controllers/task_controller.dart';

import 'data/datasources/task_local_data_source.dart';
import 'data/repositories/task_repository_impl.dart';
import 'domain/usecases/get_tasks.dart';
import 'domain/usecases/save_tasks.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final taskLocalDataSource = TaskLocalDataSourceImpl(sharedPreferences);
  final taskRepository = TaskRepositoryImpl(taskLocalDataSource);
  final getTasks = GetTasks(taskRepository);
  final saveTasks = SaveTasks(taskRepository);

  Get.put(TaskController(getTasks: getTasks, saveTasks: saveTasks));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
