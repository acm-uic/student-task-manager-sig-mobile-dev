import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
import '../widgets/general/bottom_tab_navigator.dart';

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
        return AlertDialog(
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
    if (taskList[tab]?.containsKey(section) ?? false) {
      taskList[tab]?[section]?.removeAt(taskIndex);
      taskList.refresh();
    }
  }
}

class MainHomePage extends StatelessWidget {
  MainHomePage({super.key});

  final MainHomePageController mainController = Get.put(MainHomePageController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 150,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text(
              "Tasks",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: 
                  TextField(
                    controller: mainController.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.red, size: 40),
                  onPressed: () {
                    mainController.addTaskButton(context, mainController.tab);
                  },
                )
              ]
            )
          ]),
          bottom: TabBar(
            onTap: (index) {
              debugPrint('Tab index: $index');
              mainController.tab = ( // set tab to the corresponding string
                index == 0 ? 'Work': 
                index == 1 ? 'College': 
                index == 2 ? 'Personal': 
                throw Exception('Invalid tab index'));
            },
            tabs: const [
              Tab(text: "Work"),
              Tab(text: "College"),
              Tab(text: "Personal"),
            ],
            labelColor: Colors.red,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Colors.red, // Background color for selected tab
                width: 2,
              )
            ),
          ),
        ),
        body: 
            TabBarView(
            children: [
              Center(
                // More components for work tab 
                child: 
                  taskListBuilder('Work'),   
                  // Text('Work tasks')
              ),
              Center(
                child: taskListBuilder('College'),
                // More components for college tab 
                // Text('College tasks')
              ),
              Center(
                child: taskListBuilder('Personal'),
                // More components for personal tab
                // Text('Personal'),
              ),
            ],
          ),
        bottomNavigationBar: bottomTabNavigator(),
      ),
    );
  }
}

Widget taskListBuilder(String tab) {
  final MainHomePageController c = Get.find();
  return Obx(() {
    return ListView.builder(
      itemCount: c.taskList[tab]?.length,
      itemBuilder: (context, sectionIndex) {
        return Column(
          children: [
            ListTile(
              title: Text(
                c.taskList[tab]?.keys.elementAt(sectionIndex) ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subsectionList(tab, sectionIndex, c.taskList[tab]?[c.taskList[tab]?.keys.elementAt(sectionIndex)]),
          ],
        );
      }
    );
  });
}

Widget subsectionList(String tab, int sectionIndex, List<String>? tasks) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    itemCount: tasks?.length ?? 0, // sets itemCount to 0 if tasks is null
    itemBuilder: (context, subsectionIndex) {
      if(tasks == null || tasks.isEmpty) {
        return const SizedBox(); // return empty container if no tasks
      }
      return subsectionTask(tab, sectionIndex, subsectionIndex);
    },
  );
}

Widget subsectionTask(String tab, int sectionIndex, int subsectionIndex) {
  final MainHomePageController c = Get.find();
  return Card(
    clipBehavior: Clip.hardEdge,
    child: InkWell(
      splashColor: Colors.red.withAlpha(30),
      child: ListTile(
        title: Text(c.taskList[tab]?.values.elementAt(sectionIndex).elementAt(subsectionIndex) ?? ''),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // debugPrint('Delete Button Pressed.');
            c.deleteTask(tab, c.taskList[tab]?.keys.elementAt(sectionIndex) ?? '', subsectionIndex);
          },
        ),
      ),
    ),
  );
}