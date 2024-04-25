import 'package:flutter/material.dart';

class BottomBarViewModel with ChangeNotifier {
  int selectedIndex = 1;
  void tabIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
