import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_task_manager/screens/home.dart';
import 'screens/gym.dart';
import 'screens/thoughts.dart';
import 'widgets/general/bottom_tab_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'UIC Student Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Establishes named routes for the other pages we have.
      getPages: [
        GetPage(name: '/home', page: () => const MainHomePage()),
        GetPage(name: '/gym', page: () => const GymPage()),
        GetPage(name: '/thoughts', page: () => const ThoughtsPage())
      ],
      home: const MainHomePage(),
    );
  }
}