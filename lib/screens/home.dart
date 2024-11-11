import 'package:flutter/material.dart';
import '../widgets/general/bottom_tab_navigator.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome To Home!"), 
            SizedBox(height: 20), 
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Button clicked!')),
                );
              },
              child: Text('+'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomTabNavigator(),
    );
  }
}