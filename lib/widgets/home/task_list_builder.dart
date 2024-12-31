import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_task_manager/widgets/home/controller.dart';

Widget taskListBuilder(String tab) {
  final MainHomePageController c = Get.find();
  return Obx(() {
    if(c.taskList[tab]?.isEmpty ?? true) { // default display message if no tasks in current tab
      return const Center(
        child: Text('No tasks to display'),
      );
    }
    return ListView.builder(
      itemCount: c.taskList[tab]?.length,
      itemBuilder: (context, sectionIndex) {
        String currSection = c.taskList[tab]?.keys.elementAt(sectionIndex) ?? '';
        return Column(
          children: [
            ListTile(
              title: Text(
                'Due: $currSection',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            sectionList(tab, currSection, c.taskList[tab]?[c.taskList[tab]?.keys.elementAt(sectionIndex)]),
          ],
        );
      }
    );
  });
}

Widget sectionList(String tab, String section, Map<String, String>? tasks) {
  final MainHomePageController c = Get.find();
  return ListView.builder(
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    itemCount: tasks?.length ?? 0, // sets itemCount to 0 if tasks is null
    itemBuilder: (context, taskIndex) {
      String currTask = tasks?.keys.elementAt(taskIndex) ?? '';
      if(tasks == null || tasks.isEmpty || currTask.contains(c.filter.value) != true) {
        return const SizedBox.shrink(); // return empty container if no tasks or filter doesn't match task
      }
      return task(tab, section, currTask);
    },
  );
}

Widget task(String tab, String section, String task) {
  final MainHomePageController c = Get.find();
  c.descriptionController.text = c.taskList[tab]?[section]?[task] ?? '';
  return Card(
    clipBehavior: Clip.hardEdge,
    child: InkWell(
      splashColor: Colors.red.withAlpha(30),
      child: ExpansionTile(
        title: Text(task),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            c.deleteTask(tab, section, task);
          },
        ),
        children: [
          ListTile(
            title: TextFormField(
                controller: c.descriptionController,
                readOnly: c.isReadOnly.value,
                maxLines: null, // Allow multiline input
                keyboardType: TextInputType.multiline, // Set keyboard type to multiline
                decoration: InputDecoration(
                  hintText: 'No description',
                ),
              ),
              trailing: IconButton(
                icon: c.isReadOnly.value ? Icon(Icons.edit) : Icon(Icons.save),
                onPressed: () {
                  c.updateTask(tab, section, task);
                  c.isReadOnly.value = !c.isReadOnly.value;
                  c.taskList.refresh();
                },
            ),
          ),
        ],
      ),
    ),
  );
}