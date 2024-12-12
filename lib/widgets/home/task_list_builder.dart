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
        return Column(
          children: [
            ListTile(
              title: Text(
                'Due: ${c.taskList[tab]?.keys.elementAt(sectionIndex) ?? ''}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            sectionList(tab, sectionIndex, c.taskList[tab]?[c.taskList[tab]?.keys.elementAt(sectionIndex)]),
          ],
        );
      }
    );
  });
}

Widget sectionList(String tab, int sectionIndex, List<String>? tasks) {
  final MainHomePageController c = Get.find();
  return ListView.builder(
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    itemCount: tasks?.length ?? 0, // sets itemCount to 0 if tasks is null
    itemBuilder: (context, taskIndex) {
      if(tasks == null || tasks.isEmpty || !tasks[taskIndex].contains(c.filter.value)) {
        return const SizedBox.shrink(); // return empty container if no tasks or filter doesn't match task
      }
      return task(tab, sectionIndex, taskIndex);
    },
  );
}

Widget task(String tab, int sectionIndex, int taskIndex) {
  final MainHomePageController c = Get.find();
  return Card(
    clipBehavior: Clip.hardEdge,
    child: InkWell(
      splashColor: Colors.red.withAlpha(30),
      child: ListTile(
        title: Text(c.taskList[tab]?.values.elementAt(sectionIndex).elementAt(taskIndex) ?? ''),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            c.deleteTask(tab, c.taskList[tab]?.keys.elementAt(sectionIndex) ?? '', taskIndex);
          },
        ),
      ),
    ),
  );
}