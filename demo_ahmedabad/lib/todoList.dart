import 'package:flutter/material.dart';

class todoList extends StatefulWidget {
  const todoList({super.key});

  @override
  State<todoList> createState() => _todoListState();
}

class _todoListState extends State<todoList> {
  TextEditingController name = TextEditingController();
  TextEditingController task = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Text('To Do List'),
              bottom: TabBar(
                tabs: [
                  Text('Pending'),
                  Text('Complete'),
                ],
              )),
          body: TabBarView(
            children: [
              ListView(
                children: [
                  for (int i = 0; i < DataCollection.pendingData.length; i++)
                    Card(
                      child: ListTile(
                        trailing: Icon(Icons.done),
                        onTap: () {
                          setState(() {
                            DataCollection.completeData
                                .add(DataCollection.pendingData[i]);
                            DataCollection.pendingData.removeAt(i);
                          });
                        },
                        title: Text(DataCollection.pendingData[i]['name']),
                        subtitle: Text(DataCollection.pendingData[i]['task']),
                      ),
                    )
                ],
              ),
              ListView(
                children: [
                  for (int i = 0; i < DataCollection.completeData.length; i++)
                    Card(
                      child: ListTile(
                        title: Text(DataCollection.pendingData[i]['name']),
                        subtitle: Text(DataCollection.pendingData[i]['task']),
                      ),
                    )
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('AlertDialog Title'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          TextField(
                            controller: name,
                          ),
                          TextField(
                            controller: task,
                          )
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Add'),
                        onPressed: () {
                          Map<String, dynamic> newTask = {
                            'name': name.text,
                            'task': task.text,
                          };
                          setState(() {
                            DataCollection.pendingData.add(newTask);
                          });

                          print(DataCollection.pendingData);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ));
  }
}

class DataCollection {
  static List<Map<String, dynamic>> pendingData = [];
  static List<Map<String, dynamic>> completeData = [];
}
