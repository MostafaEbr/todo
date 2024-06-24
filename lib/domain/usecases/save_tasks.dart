import '../entities/task.dart';
import '../repositories/task_repository.dart';

class SaveTasks {
  final TaskRepository repository;

  SaveTasks(this.repository);

  Future<void> call(List<Task> tasks) async {
    return await repository.saveTasks(tasks);
  }
}
