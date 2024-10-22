import 'package:flutter/material.dart';
// import 'package:student_task_manager/main.dart';

Widget bottomTabNavigator() {
  return BottomNavigationBar(
    items:
      const <BottomNavigationBarItem>[
        BottomNavigationBarItem (
          icon: Icon(Icons.home),
          label: "Home",
          ),
        BottomNavigationBarItem (
          icon: Icon(Icons.chat_bubble),
          label: "Thoughts",
        ),
        BottomNavigationBarItem (
          icon: Icon(Icons.fitness_center),
          label: "Gym",
        ),
      ],
    currentIndex: 0,
    selectedItemColor: Colors.red,
  );
}