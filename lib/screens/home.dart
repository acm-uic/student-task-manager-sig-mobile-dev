import 'package:flutter/material.dart';
import '../widgets/general/bottom_tab_navigator.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

   @override
  MainHomePageState createState() => MainHomePageState();
}

class MainHomePageState extends State<MainHomePage> {
  Map<String, List<String>> tasksBySections = {'Today':["Wake up", "Eat breakfast", "Go to UIC"], 'Tomorrow':["Task 4", "Task 5"]}; // hard coded for now
  List<String> sections = ['Today', 'Tomorrow'];

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text("UIC Task Manager"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: sections.length,
          itemBuilder: (context, sectionIndex) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    sections[sectionIndex],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subsectionList(sectionIndex, tasksBySections[sections[sectionIndex]]),
              ],
            );
          }
        ),
      ),       
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Add Task Button Pressed.');
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('New Task'),
                content: TextField(
                  controller: _controller,
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
                      _controller.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Enter'),
                    onPressed: () {
                      setState(() {
                        tasksBySections['Today']!.add(_controller.text); // hard coded to 'Today' for now
                        tasksBySections['Today']!.toSet().toList(); // remove duplicates
                        debugPrint('Task added: ${_controller.text}, new list: ${tasksBySections['Today']}');
                      });
                      _controller.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: bottomTabNavigator(),
    ); // placeholder text in center of the screen
  }
}

Widget sectionList(Map<String, List<String>> tasksBySections, List<String> sections) {
  return ListView.builder(
    itemCount: sections.length,
    itemBuilder: (context, sectionIndex) {
      return Column(
        children: [
          ListTile(
            title: Text(
              sections[sectionIndex],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subsectionList(sectionIndex, tasksBySections[sections[sectionIndex]]),
        ],
      );
    }
  );
}

Widget subsectionList(int sectionIndex, List<String>? tasks) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    itemCount: tasks?.length ?? 0, // sets itemCount to 0 if tasks is null
    itemBuilder: (context, subsectionIndex) {
      if(tasks == null || tasks.isEmpty) {
        return const SizedBox(); // return empty container if no tasks
      }

      return subsectionTask(subsectionIndex, tasks[subsectionIndex]);
    },
  );
}

Widget subsectionTask(int subsectionIndex, String task) {
  return Card(
    clipBehavior: Clip.hardEdge,
    child: InkWell(
      splashColor: Colors.red.withAlpha(30),
      onTap: () {
        debugPrint('Card \'$task\' tapped.'); /* if needed: clicking on card goes here */
      },
      child: ListTile(
        title: Text(task),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            debugPrint('Delete Button Pressed.');
            // setState(() {
              // tasksBySections['Today']!.removeAt(subsectionIndex); // hard coded to 'Today' for now
            //   debugPrint('Task removed: $task, new list: ${tasksBySections['Today']}');
            // });
          },
        ),
      ),
    ),
  );
}

Widget addTaskButton(BuildContext context, Map<String, List<String>> tasksBySections) {
  return FloatingActionButton(
    onPressed: () {
      debugPrint('Add Task Button Pressed.');
      taskBuilder(context, tasksBySections);
    },
    backgroundColor: Colors.red,
    child: const Icon(Icons.add),
  );
}

final TextEditingController _controller = TextEditingController();

Future<void> taskBuilder(BuildContext context, Map<String, List<String>> tasksBySections) {
  
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('New Task'),
        content: TextField(
          controller: _controller,
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
              _controller.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Enter'),
            onPressed: () {
              tasksBySections['Today']!.add(_controller.text); // hard coded to 'Today' for now
              debugPrint('Task added: ${_controller.text}, new list: ${tasksBySections['Today']}');
              _controller.clear();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
