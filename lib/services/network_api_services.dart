import 'dart:convert';
import 'package:ecommerce_app/services/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getGetApiResponce(String url) async {
    try {
      final responce = await http.get(
        Uri.parse(url),
      );

      apiResponce(responce);
    } catch (e) {
      Exception(e.toString());
    }
  }

  dynamic apiResponce(http.Response responce) {
    switch (responce.statusCode) {
      case 200:
        dynamic responceJson = jsonDecode(responce.body);

        return responceJson;
      case 400:
        throw Exception(
          responce.statusCode.toString(),
        );
      case 404:
        throw Exception(
          responce.statusCode.toString(),
        );
      default:
        throw Exception(
          responce.statusCode.toString(),
        );
    }
  }
}
