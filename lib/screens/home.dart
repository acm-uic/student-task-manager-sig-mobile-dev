import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/general/bottom_tab_navigator.dart';
import '../widgets/home/home_controller.dart';
import '../widgets/home/task_list_builder.dart';

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
                  TextField( // search bar
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
                throw Exception('Invalid tab index')
                );
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