import 'package:amazon/controller/services/users_product_services.dart';
import 'package:amazon/model/ProductModel.dart';
import 'package:flutter/material.dart';

class ProductsBasedOnCategoryProvider extends ChangeNotifier {
  List<ProductModel> products = [];
  bool productsFetched = false;

  fetchProducts({required String category}) async {
    products = [];
    products = await UsersProductService.fetchProductBasedOnCategory(
        category: category);
    productsFetched = true;
    notifyListeners();
  }
}
