import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/general/bottom_tab_navigator.dart';
import '../widgets/home/controller.dart';
import '../widgets/home/task_list_builder.dart';

class MainHomePage extends StatelessWidget {
  MainHomePage({super.key});

  final MainHomePageController homeController = Get.put(MainHomePageController());

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
                    controller: homeController.searchController,
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
                    // homeController.newTaskPopupBox(context, homeController.tab);
                    homeController.newTaskPopupBox(context);
                  },
                )
              ]
            )
          ]),
          bottom: TabBar(
            onTap: (index) {
              homeController.tab = homeController.tabs[index];
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
                child: taskListBuilder('Work'),
              ),
              Center(
                child: taskListBuilder('College'),
              ),
              Center(
                child: taskListBuilder('Personal'),
              ),
            ],
          ),
        bottomNavigationBar: bottomTabNavigator(),
      ),
    );
  }
}