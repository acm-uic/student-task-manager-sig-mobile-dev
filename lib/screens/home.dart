import 'package:flutter/material.dart';
import '../widgets/general/bottom_tab_navigator.dart';

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
