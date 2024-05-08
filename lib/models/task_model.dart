// class Task {
//   final int id;
//   final String description;
//   bool isDone;

//   Task({
//     required this.id,
//     required this.description,
//     this.isDone = false,
//   });
// }

import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  Task({
    required this.description,
    this.isDone = false,
  });

  @HiveField(0)
  final String description;

  @HiveField(1)
  final bool isDone;

  Task copyWith({
    String? id,
    String? description,
    bool? isDone,
  }) {
    return Task(
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}
