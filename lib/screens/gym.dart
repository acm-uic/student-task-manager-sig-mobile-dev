import 'package:flutter/material.dart';
import '../widgets/general/bottom_tab_navigator.dart';

class GymPage extends StatelessWidget {
  const GymPage({super.key});

  final int streak = 0;

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
        children: [
          // Align "Monday" text in top left
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

          // Streak counter with flame icon in top right
          Positioned(
            right: 12.0,
            top: 20.0,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.local_fire_department),
                  color: Colors.orange,
                  onPressed: () {
                    // Streak Code
                  },
                ),
                Text(
                  '$streak',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: bottomTabNavigator(),
    );
  }
}
