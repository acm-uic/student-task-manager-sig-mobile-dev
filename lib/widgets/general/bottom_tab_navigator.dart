import 'package:flutter/material.dart';

Widget bottomTabNavigator(Function(int) onItemTapped, int selectedIndex) {

  return BottomNavigationBar(
import 'package:get/get.dart';
import 'package:student_task_manager/widgets/general/bottom_navigator_controller.dart';
// import 'package:student_task_manager/main.dart';

// Changed Navigator to utilize a state controller to maintain the current page
// Creating Obx state that manages nav bar.
Widget bottomTabNavigator() {
  final BottomNavigatorController controller = Get.put(BottomNavigatorController());
  return Obx(() => BottomNavigationBar(
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
    // sets current page value of controller during setup.
    currentIndex: controller.selectedIndex.value,
    selectedItemColor: Colors.red,

    // Added OnTap to a switch specific named page
    // Used Get.offAllNamed instead of Get.to seemed very ambiguous and not structured.
    // Change the value within the controller, which then changes retroactively
    onTap: (currentIndex) {
      controller.setIndex(currentIndex);
      switch (currentIndex) {
        case 0:
          Get.offAllNamed('/home');
        case 1:
          Get.offAllNamed('/thoughts');
        case 2:
          Get.offAllNamed('/gym');
      }
    },
  )
  );
}