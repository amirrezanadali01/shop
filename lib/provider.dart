import 'package:flutter/material.dart';
import 'package:shop/api_service.dart';
import 'package:shop/models.dart';

// https://fakestoreapi.com/products/category/electronics?limit=4

class ProductProvider extends ChangeNotifier {
  List<ProductsModel> _products = [];
  List<ProductsModel> get products => _products;
  bool isLoading = false;
  final ApiProducts apiProduct = ApiProducts();

  Future<void> getAllProducts() async {
    isLoading = true;
    notifyListeners();
    _products = await apiProduct.getAllProducts();
    _products.shuffle();
    isLoading = false;
    notifyListeners();
  }
}
