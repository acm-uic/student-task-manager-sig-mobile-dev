import 'package:flutter/material.dart';
import '../widgets/general/bottom_tab_navigator.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
          title: Text("UIC Task Manager"),
          backgroundColor: Colors.red,
          centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Welcome to the UIC Student Task Manager!"
        ),
      ),
      bottomNavigationBar: bottomTabNavigator(),
    ); // placeholder text in center of the screen
  }
}