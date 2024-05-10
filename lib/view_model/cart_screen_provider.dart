import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce_app/core/constants/app_text.dart';
import 'package:ecommerce_app/model/favorite_items_model.dart';
import 'package:ecommerce_app/model/products_model.dart';
import 'package:ecommerce_app/widget/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class CartScreenProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  bool get loading => isLoading;
  bool isSearching = false;
  String? dropdownValue;
  List<Products> foundUser = [];
  bool isDescending = false;
  List<Products> cartItemsList = <Products>[];
  List favoriteList = <FavoriteItemsModel>[];

  List<Products> data = [];
  List<Products>? result = [];
  final box = Hive.box<FavoriteItemsModel>(AppText.favoriteItemsBox);
  final cartItemsBox = Hive.box<Products>(AppText.cartProductsBox);
  double get totalAmmount => cartItemsList.fold(
        0,
        (sum, item) => sum + (item.price ?? 0),
      );
  Color changeIconColor(Products product) {
    final itemKey = '${product.title}-${product.id.toString()}';
    return box.containsKey(itemKey)
        ? const Color.fromARGB(255, 207, 20, 7)
        : Colors.grey.shade400;
  }

  void addToFavorites(BuildContext context, Products product) {
    final itemKey = '${product.title}-${product.id.toString()}';

    if (!box.containsKey(itemKey)) {
      final item = FavoriteItemsModel(
          image: product.thumbnail,
          price: product.price,
          quantity: product.quantity,
          title: product.title,
          id: product.id.toString());
      box.put(itemKey, item);
      getFavoriteList();
      //SNACKBAR
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: CustomSnackBar(
              title: 'Added to favorite successfully',
              onPressed: () {
                removeFromFavorites(product);

                ScaffoldMessenger.of(context).removeCurrentSnackBar();
              }),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
      notifyListeners();
    } else {
      removeFromFavorites(product);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: CustomSnackBar(
              title: 'Remove from favorite successfully',
              onPressed: () {
                addToFavorites(context, product);
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
              }),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
    }
  }

  void getFavoriteList() {
    favoriteList.clear();
    List<FavoriteItemsModel> allFavoriteItems = box.values.toList();

    if (allFavoriteItems.isNotEmpty) {
      for (FavoriteItemsModel favoriteItem in allFavoriteItems) {
        print('Favorite item found: ${favoriteItem.title}');

        favoriteList.add(favoriteItem);
      }
    } else {
      print('No favorite items found.');
    }
  }

  void removeFromFavorites(Products product) {
    final itemKey = '${product.title}-${product.id.toString()}';

    if (box.containsKey(itemKey)) {
      box.delete(itemKey);
      getFavoriteList();

      notifyListeners();
    }
  }

  void addToCart(BuildContext context, Products product) {
    final itemKey = product.id.toString();
    if (!cartItemsBox.containsKey(itemKey)) {
      final model = Products(
        discountPercentage: product.discountPercentage,
        discountedPrice: product.discountedPrice,
        id: product.id,
        price: product.price,
        quantity: product.quantity,
        thumbnail: product.thumbnail,
        title: product.title,
        total: product.total,
      );

      cartItemsBox.put(itemKey, model);
      getCartItemsList();
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: CustomSnackBar(
              title: 'Added successfully to cart',
              onPressed: () {
                removeFromCart(product);
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
              }),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
      log('${cartItemsBox.values.toList()}');
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: CustomSnackBar(
              title: 'Item already exist in cart',
              isUndoButton: true,
              onPressed: () {}),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
    }
  }

  void getCartItemsList() {
    cartItemsList.clear();
    List<Products> allFCartItems = cartItemsBox.values.toList();

    if (allFCartItems.isNotEmpty) {
      for (Products cartItems in allFCartItems) {
        cartItemsList.add(cartItems);
      }
    } else {
      print('No favorite items found.');
    }
  }

  void removeFromCart(Products product) {
    final itemKey = product.id.toString();

    if (cartItemsBox.containsKey(itemKey)) {
      cartItemsBox.delete(itemKey);
      getCartItemsList();

      notifyListeners();
    }
  }

  Future<List<Products>?> getGetApiResponce() async {
    isLoading = true;
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/carts'),
      );
      print(response.body);
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
    notifyListeners();
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
    data.sort(
      (a, b) => isDescending
          ? (b.price ?? 0).compareTo(a.price ?? 0)
          : (a.price ?? 0).compareTo(b.price ?? 0),
    );
    notifyListeners();
  }
}
