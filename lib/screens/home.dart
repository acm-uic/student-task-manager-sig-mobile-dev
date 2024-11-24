import 'package:flutter/material.dart';
import '../widgets/general/bottom_tab_navigator.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text("Welcome to Home!"),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40), // Adjust padding for height
              child: ElevatedButton(
                onPressed: () {
                  // Add your button action here
                  print('Button Pressed');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50), // Width: 200, Height: 50
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: const Text(
                  "+",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomTabNavigator(),
    );
  }
}
