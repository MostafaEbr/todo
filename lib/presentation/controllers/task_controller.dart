import 'package:get/get.dart';

import '../../domain/entities/task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/save_tasks.dart';

class TaskController extends GetxController {
  final GetTasks getTasks;
  final SaveTasks saveTasks;

  var tasks = <Task>[].obs;
  var newTaskTitle = ''.obs;

  TaskController({required this.getTasks, required this.saveTasks});

  @override
  void onInit() {
    // loadTasks();
    super.onInit();
  }

  void loadTasks() async {
    tasks.value = await getTasks();
  }

  void addTask() {
    var task_added = <Task>[];

    if (newTaskTitle.value.isNotEmpty) {
      task_added.add(Task(title: newTaskTitle.value));
      task_added.forEach((element) {
        tasks.add(element);

      });
      saveTasks(tasks);
      newTaskTitle.value = '';
    }
  }

  void toggleTaskStatus(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    tasks.refresh();
    saveTasks(tasks);
  }
}
