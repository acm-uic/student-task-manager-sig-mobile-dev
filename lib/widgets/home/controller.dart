import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_list_database.dart';


class MainHomePageController extends GetxController {
  // Map of tasks with keys as tabs and values as SplayTreeMaps(sorted maps) with keys as sections and value as list of tasks
  RxMap<String, SplayTreeMap<String, List<String>>> taskList = RxMap<String, SplayTreeMap<String, List<String>>>({
    'Work': SplayTreeMap<String, List<String>>(),
    'College': SplayTreeMap<String, List<String>>(),
    'Personal': SplayTreeMap<String, List<String>>(),
  });

  RxString filter = "".obs; // filter for search bar

  List<String> tabs = ['Work', 'College', 'Personal']; // list of tabs
  late String tab; // current tab

  final TextEditingController newTaskController = TextEditingController(),
                              dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  RxBool taskSelected = true.obs, dateSelected = true.obs;

  @override
  void onInit() { // called immediately after the widget is allocated memory
    super.onInit();
    _initializeDatabase();
    tab = tabs[0]; // sets default tab to Work
  }

  Future<void> _initializeDatabase() async {
    await DatabaseHelper.instance.initDb();
    Future<List<Map<String, dynamic>>> tasks = DatabaseHelper.instance.queryAllTasks(); // get all tasks from database
    tasks.then((value) { // populates taskList with tasks from database
      for(Map<String, dynamic> task in value) {
        if(!(taskList[task['tab'] as String]?.containsKey(task['section'] as String) ?? false)) { // checks if section exists
          taskList[task['tab'] as String]?[task['section'] as String] = [];
        }
        taskList[task['tab'] as String]?[task['section'] as String]?.add(task['detail'] as String);
      }
      taskList.refresh();
    });
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker( 
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      dateController.text = "${pickedDate.toLocal()}".split(' ')[0]; // Format date as yyyy-mm-dd
    }
  }

  void newTaskPopupBox(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog( // pop-up box to add a new task
          title: const Text('New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() {
                  return TextField(
                  controller: newTaskController,
                  decoration: InputDecoration(
                    hintText: 'Enter task here',
                    errorText: taskSelected.value ? null : 'Please enter a task',
                      ),
                    );
              }),
              Obx(() {
                return TextField(
                  controller: dateController,
                  readOnly: true, // Make it read-only so user can't type
                  decoration: InputDecoration(
                    labelText: 'Due Date',
                    hintText: 'Select due date',
                    suffixIcon: const Icon(Icons.calendar_today),
                    errorText: dateSelected.value ? null : 'Please select a due date',
                  ),
                onTap: () => selectDate(context),
                );
              }),
            ]
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                taskSelected.value = true; // resets error message
                dateSelected.value = true;
                newTaskController.clear();
                dateController.clear();
                Navigator.of(context).pop(); // closes the dialog box
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enter'),
              onPressed: () async {
                if(newTaskController.text.isEmpty || dateController.text.isEmpty) { // require both fields to be filled
                  if(newTaskController.text.isEmpty) {
                    taskSelected.value = false;
                  }
                  if(dateController.text.isEmpty) {
                    dateSelected.value = false;
                  }
                  return; // prevents closing of dialog box if field(s) are empty
                }
                taskSelected.value = true; // resets error message
                dateSelected.value = true;

                Navigator.of(context).pop(); // closes the dialog box
                if(!(taskList[tab]?.containsKey(dateController.text) ?? false)) { // checks if section exists
                  taskList[tab]?[dateController.text] = []; // create new section with empty task list
                }
                taskList[tab]?[dateController.text]?.add(newTaskController.text); 
                taskList[tab]?[dateController.text] = taskList[tab]?[dateController.text]?.toSet().toList() ?? []; // remove duplicates
                await DatabaseHelper.instance.insertTask(Task(tab: tab, section: dateController.text, detail: newTaskController.text));

                newTaskController.clear();
                dateController.clear();
                taskList.refresh();
              },
            ),
          ],
        );
      }
    );
  }

  void deleteTask(String tab, String section, int taskIndex) {
    DatabaseHelper.instance.deleteTask(tab, section, taskList[tab]?[section]?.elementAt(taskIndex) ?? ''); // delete task from database
    if (taskList[tab]?.containsKey(section) ?? false) { // delete task from taskList
      taskList[tab]?[section]?.removeAt(taskIndex);
      if(taskList[tab]?[section]?.isEmpty ?? false) {
        taskList[tab]?.remove(section);
      }
      taskList.refresh();
    }
  }

  @override
  void onClose() {
    newTaskController.dispose();
    dateController.dispose();
    DatabaseHelper.instance.close(); // Close the database
    super.onClose();
  }
}