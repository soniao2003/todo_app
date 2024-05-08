import 'package:todo_app/models/task_model.dart';
import 'package:riverpod/riverpod.dart';
import 'package:todo_app/services/services.dart';

class taskDatabase extends StateNotifier<List<Task>> {
  late StateNotifierProviderRef ref;
  late TaskRepository repo;

  taskDatabase(StateNotifierProviderRef ref) : super([]) {
    repo = ref.read(taskRepositoryProvider);
    getTasksData();
  }

  void getTasksData() {
    state = repo.getAllTasks();
  }

  void addTask(Task task) {
    //state = repo.addTask(task);
    state = [...state, task];
    print('added');
  }

  void removeTask(index) {
    //state = repo.removeTask(index);
    state = [...state]..removeAt(index);
    print('removed');
  }
}

final hiveData = StateNotifierProvider<taskDatabase, List<Task>?>(
    (ref) => taskDatabase(ref));
