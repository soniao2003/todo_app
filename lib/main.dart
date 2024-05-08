import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/ui/new_task_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 250, 239, 237),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(hiveData);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 96, 120),
        title: Text(title, style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: tasks?.length ?? 0,
                itemBuilder: (context, index) {
                  //Task displaytask = tasks?[index];
                  return Card(
                      color: Color.fromARGB(255, 228, 183, 162),
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Container(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.assessment_outlined,
                                  color: Colors.white,
                                )),
                            SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        tasks?[index].description ??
                                            'there are no tasks',
                                        style: TextStyle(color: Colors.white),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //taskProvider.removeTask(index);
                                      //ref.read(taskProvider.notifier).addPerson(Task(
                                      //description: 'hej', id: tasks.length + 1));
                                      print(index);
                                      ref
                                          .read(hiveData.notifier)
                                          .removeTask(index);
                                      // .repo
                                      // .removeTask(index);
                                      //ref.read(taskProvider.notifier).remove(index);
                                    }))
                          ],
                        ),
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => TaskPage(exerciseIndex: index),
                        //     ),
                        //   );
                        // },
                      ));
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: FloatingActionButton(
                    backgroundColor: Color.fromARGB(255, 0, 96, 120),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewTaskPage(),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
