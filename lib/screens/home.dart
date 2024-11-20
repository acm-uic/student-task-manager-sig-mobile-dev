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
class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return (DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 150,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
              "Tasks",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: 
                  TextField(
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
                  icon: Icon(Icons.add_circle, color: Colors.red, size: 40,),
                  onPressed: () {
                    // add more task here??
                  },
                )
              ]
            )
          ]),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Work"),
              Tab(text: "College"),
              Tab(text: "Personal"),
            ],
            labelColor: Colors.red,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Colors.red, // Background color for selected tab
                width: 2,
              )
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: 
              // More components for work tab
              Text('Work tasks')
            ),
            Center(child:
              // More components for college tab 
              Text('College tasks')
            ),
            Center(child: 
              // More components for personal tab
              Text('Personal tasks')
            )
          ],
        ),
        bottomNavigationBar: bottomTabNavigator(),
      ))
    );
  }

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
