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
      home: const MyPage(title: 'UIC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyPage({super.key, required this.title});

  final String title;

  @override
  State<MyPage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {

  int selectedIndex = 0; // For the bottom tab navigator

  void onItemTapped(int index) { // For the bottom tab navigator
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const MyHomePage();
      case 1:
        page = const ThoughtsPage();
      case 2: 
        page = const GymPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: page,
      ),
      bottomNavigationBar: bottomTabNavigator(onItemTapped, selectedIndex),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Welcome to UIC!")
    );
  }
}

class ThoughtsPage extends StatelessWidget {
  const ThoughtsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Thoughts Page"),
    );
  }
}

class GymPage extends StatelessWidget {
  const GymPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Gym Page"),
    );
  }
}
