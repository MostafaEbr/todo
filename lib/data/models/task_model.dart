
import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required String title,
    bool isCompleted = false,
  }) : super(title: title, isCompleted: isCompleted);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}
