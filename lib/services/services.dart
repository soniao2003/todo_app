import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/task_model.dart';

class TaskRepository {
  late Box<Task> taskBox;
  late List<Task> taskList;

  List<Task> getAllTasks() {
    taskBox = Hive.box<Task>('tasks');
    taskList = taskBox.values.toList();
    return taskList;
  }

  List<Task> addTask(Task task) {
    taskBox.add(task);
    taskList = taskBox.values.toList();
    print('added');
    return taskList;
  }

  List<Task> removeTask(index) {
    taskBox.deleteAt(index);
    taskList = taskBox.values.toList();
    return taskList;
  }
}

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository();
});
