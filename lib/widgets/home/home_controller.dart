import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomePageController extends GetxController {
  RxMap<String, Map<String, List<String>>> taskList = {
    'Work': {
      'Today':['Wake up', 'Eat breakfast', 'Go to work'], 
      'Tomorrow':['Task 3', 'Task 4'],
    },
    'College': {
      'Today':['Do homework', 'Go to UIC'],
    },
    'Personal': {
      'Today':['Do chores', 'Cook dinner'],
    },
  }.obs; // hard coded tasks
  
  String tab = 'Work';

  final TextEditingController searchController = TextEditingController();
  final TextEditingController addTaskController = TextEditingController();

  void addTaskButton(BuildContext context, String tab) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog( // pop-up box to add a new task
          title: const Text('New Task'),
          content: TextField(
            controller: addTaskController,
            decoration: const InputDecoration(
              hintText: 'Enter task here',
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                addTaskController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enter'),
              onPressed: () {
                debugPrint("Adding task to $tab");
                taskList[tab]?['Today']?.add(addTaskController.text); // hard coded to 'Today' for now
                taskList[tab]?['Today'] = taskList[tab]?['Today']?.toSet().toList() ?? []; // remove duplicates
                taskList.refresh();
                addTaskController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteTask(String tab, String section, int taskIndex) {
    if (taskList[tab]?.containsKey(section) ?? false) { // check if section exists
      taskList[tab]?[section]?.removeAt(taskIndex);
      taskList.refresh();
    }
  }
}