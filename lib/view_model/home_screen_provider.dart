// import 'dart:convert';
// import 'package:ecommerce_app/model/shoping_data_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class HomeScreenProvider with ChangeNotifier {
//   bool isLoading = false;
//   bool get loading => isLoading;
//   Future<List<Products>?> getGetApiResponce() async {
//     isLoading = true;
//     try {
//       final response = await http.get(
//         Uri.parse('https://dummyjson.com/carts'),
//       );

//       if (response.statusCode == 200) {
//         final cart = jsonDecode(response.body);
//         List cartItems = cart['carts'];

//         for (int i = 0; i < cartItems.length; i++) {
//           for (var product in cartItems[i]['products']) {
//             data.add(
//               Products(
//                 id: product['id'],
//                 thumbnail: product['thumbnail'],
//                 price: product['price'],
//                 title: product['title'],
//                 quantity: product['quantity'],
//                 total: product['total'],
//                 discountPercentage: product['discountPercentage'],
//                 discountedPrice: product['discountedPrice'],
//               ),
//             );
//           }
//           isLoading = false;
//           notifyListeners();
//         }

//         return data;
//       } else {
//         debugPrint(response.statusCode.toString());
//         return null;
//       }
//     } catch (e) {
//       Exception(e.toString());
//       return null;
//     }
//   }
// }
