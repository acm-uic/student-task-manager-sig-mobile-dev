import 'package:get/get.dart';

class BottomNavigatorController extends GetxController {
  // This will create a persistent state to determine the navigator's selected
  // index and overall maintain which page we are currently on.
  // the .obs tell its to be persistent
  var selectedIndex = 0.obs;

  void setIndex(int index) {
    selectedIndex.value = index;
  }
}