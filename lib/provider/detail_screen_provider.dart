import 'package:flutter/material.dart';

class DetailScreenProvider extends ChangeNotifier {
  bool isFavorite = false;
  void onTap() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
