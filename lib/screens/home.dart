import 'package:flutter/material.dart';
import '../widgets/general/bottom_tab_navigator.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({ super.key });

  @override
  Widget build(BuildContext context) {
    return (
      Scaffold (
        body: const Center (
          child: Text ("Welcome to Home!")
        ),
        bottomNavigationBar: bottomTabNavigator(),
      )
    );
  }
}