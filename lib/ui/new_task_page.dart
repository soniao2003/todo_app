import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';

class NewTaskPage extends ConsumerWidget {
  const NewTaskPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Nowe zadanie ',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 0, 96, 120),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: myController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Wpisz opis zadania',
                    ),
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    onPressed: () async {
                      ref
                          .read(hiveData.notifier)
                          .addTask(Task(description: myController.text));
                      Navigator.of(context).pop();
                    },
                    child: Text('Zapisz',
                        style:
                            TextStyle(color: Color.fromARGB(255, 0, 96, 120)))),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Anuluj',
                        style:
                            TextStyle(color: Color.fromARGB(255, 0, 96, 120))))
              ])
            ])));
  }
}
