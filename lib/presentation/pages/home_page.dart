import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title:const Text('To-Do List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.tasks.length,
                itemBuilder: (context, index) {
                  final task = controller.tasks[index];
                  return ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) => controller.toggleTaskStatus(index),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => controller.newTaskTitle.value = value,
                    decoration:const InputDecoration(hintText: 'New Task'),
                  ),
                ),
                IconButton(
                  icon:const Icon(Icons.add),
                  onPressed: controller.addTask,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
