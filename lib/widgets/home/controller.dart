import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomePageController extends GetxController {
  // Map of tasks with keys as tabs and values as SplayTreeMaps(sorted maps) with keys as sections and value as list of tasks
  RxMap<String, SplayTreeMap<String, List<String>>> taskList = RxMap<String, SplayTreeMap<String, List<String>>>({
    'Work': SplayTreeMap<String, List<String>>(),
    'College': SplayTreeMap<String, List<String>>(),
    'Personal': SplayTreeMap<String, List<String>>(),
  });

  String tab = 'Work'; // current tab, default to 'Work' when clicking on home screen

  final TextEditingController searchController = TextEditingController(), 
                              newTaskController = TextEditingController(),
                              dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  RxBool taskSelected = true.obs, dateSelected = true.obs;

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

  void newTaskPopupBox(BuildContext context, String tab) {
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
              onPressed: () {
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
                if(!(taskList[tab]?.containsKey(dateController.text) ?? false)) { // checks if section exists
                  taskList[tab]?[dateController.text] = []; // create new section with empty task list
                }
                taskList[tab]?[dateController.text]?.add(newTaskController.text); 
                taskList[tab]?[dateController.text] = taskList[tab]?[dateController.text]?.toSet().toList() ?? []; // remove duplicates
                newTaskController.clear();
                dateController.clear();
                taskList.refresh();
                Navigator.of(context).pop(); // closes the dialog box
              },
            ),
          ],
        );
      }
    );
  }

  void deleteTask(String tab, String section, int taskIndex) {
    if (taskList[tab]?.containsKey(section) ?? false) { // check if section exists
      taskList[tab]?[section]?.removeAt(taskIndex);
      if(taskList[tab]?[section]?.isEmpty ?? false) {
        taskList[tab]?.remove(section);
      }
      taskList.refresh();
    }
  }
}