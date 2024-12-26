import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_task_manager/screens/home.dart';
import 'screens/gym.dart';
import 'screens/thoughts.dart';
import 'screens/error.dart';
import 'package:flutter/foundation.dart'; // For checking web plaforms

void main() {
  bool isInit = true;
  String errorMessage = '';
  try {
    if(kIsWeb) { // For web platform
      throw UnsupportedError('Web platforms are not yet supported');     
    }
  } 
  catch(e) {
    debugPrint(e.toString());
    errorMessage = e.toString();
    isInit = false;
  }
  if(isInit) {
    runApp(MyApp(isInit: isInit));
  }
  else {
    runApp(MyApp(isInit: isInit, errorMessage: errorMessage));
  }
}

class MyApp extends StatelessWidget {
  final bool isInit;
  final String? errorMessage;
  const MyApp({super.key, required this.isInit, this.errorMessage});

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
        GetPage(name: '/home', page: () => MainHomePage()),
        GetPage(name: '/gym', page: () => const GymPage()),
        GetPage(name: '/thoughts', page: () => const ThoughtsPage()),
        GetPage(name: '/error', page: () => ErrorPage(errorMessage: errorMessage ?? '')),
      ],
      home: (isInit ? MainHomePage() : ErrorPage(errorMessage: errorMessage ?? '')), 
    );
  }
}
