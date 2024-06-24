
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<List<Task>> getTasks() async {
    return await localDataSource.getTasks();
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
      await localDataSource.saveTasks(tasks.map((task) => TaskModel(title: task.title, isCompleted: task.isCompleted)).toList());
  }
}
