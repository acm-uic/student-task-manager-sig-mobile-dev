import 'package:flutter/material.dart';

Widget bottomTabNavigator(Function(int) onItemTapped, int selectedIndex) {

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
    currentIndex: selectedIndex,
    selectedItemColor: Colors.red,
    onTap: onItemTapped,
  );
}