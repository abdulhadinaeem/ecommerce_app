import 'package:flutter/material.dart';

class BottomBarViewModel with ChangeNotifier {
  int selectedIndex = 0;
  void tabIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
