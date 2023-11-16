import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop/models.dart';

class ApiProducts {
  Future<List<ProductsModel>> getAllProducts() async {
    http.Response response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));

    return List<ProductsModel>.from(
        jsonDecode(response.body).map((x) => ProductsModel.fromJson(x)));
  }
}
