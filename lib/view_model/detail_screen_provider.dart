import 'package:flutter/material.dart';

class DetailScreenProvider with ChangeNotifier {
  bool isFavorite = false;
  void onTap() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
