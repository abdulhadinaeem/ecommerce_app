import 'dart:convert';
import 'package:ecommerce_app/model/shoping_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartScreenProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  bool get loading => isLoading;
  bool isSearching = false;
  String? dropdownValue;
  List<Products> foundUser = [];
  bool isDescending = false;

  List<Products> data = [];
  List<Products>? result = [];

  double get totalAmmount => data.fold(
        0,
        (sum, item) => sum + (item.price ?? 0),
      );

  Future<List<Products>?> getGetApiResponce() async {
    isLoading = true;
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/carts'),
      );

      if (response.statusCode == 200) {
        final cart = jsonDecode(response.body);
        List cartItems = cart['carts'];

        for (int i = 0; i < cartItems.length; i++) {
          for (var product in cartItems[i]['products']) {
            data.add(
              Products(
                id: product['id'],
                thumbnail: product['thumbnail'],
                price: product['price'],
                title: product['title'],
                quantity: product['quantity'],
                total: product['total'],
                discountPercentage: product['discountPercentage'],
                discountedPrice: product['discountedPrice'],
              ),
            );
          }
          isLoading = false;
          notifyListeners();
        }

        return data;
      } else {
        debugPrint(response.statusCode.toString());
        return null;
      }
    } catch (e) {
      Exception(e.toString());
      return null;
    }
  }

  void runFilter(String enteredText) {
    if (enteredText.isEmpty) {
      result = data;
    } else {
      result = data
          .where(
            (element) => element.title!.toLowerCase().contains(
                  enteredText.toLowerCase(),
                ),
          )
          .toList();
    }
    foundUser = result ?? [];

    notifyListeners();
  }

  addProducts() {
    foundUser.addAll(data);
  }

  void checkIsSearching() {
    isSearching = !isSearching;

    notifyListeners();
  }

  void resetList() {
    result?.clear();
    foundUser.addAll(data);
    notifyListeners();
  }

  void unSelectSearch() {
    isSearching = false;
    notifyListeners();
  }

  void checkIsDescending() {
    isDescending = !isDescending;
    foundUser.sort(
      (a, b) => isDescending
          ? (b.price ?? 0).compareTo(a.price ?? 0)
          : (a.price ?? 0).compareTo(b.price ?? 0),
    );
    notifyListeners();
  }
}
