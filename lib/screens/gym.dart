import 'package:flutter/material.dart';
import '../widgets/general/bottom_tab_navigator.dart';

class GymPage extends StatelessWidget {
  const GymPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top App Bar section
      appBar: AppBar(
        title: const Text("UIC Task Manager"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Stack(
        // stack layers widgets
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  // Update for a drop-down later
                },
                child: const Text(
                  "Monday",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          // Centered Main Text
          const Center(
            child: Text("Let's get them gains!"),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: bottomTabNavigator(),
    );
  }
}
