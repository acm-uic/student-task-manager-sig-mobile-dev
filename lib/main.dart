import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text("Welcome to UIC!")
      ),
      // bottomTabNavigator() is a component from lib/widgets/general/bottom_tab_navigator.dart
      bottomNavigationBar: bottomTabNavigator(),
    );
  }
}
