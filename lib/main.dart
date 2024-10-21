import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      home: const MyHomePage(title: 'UIC'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Welcome to UIC!")
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      )
    );
  }
}
