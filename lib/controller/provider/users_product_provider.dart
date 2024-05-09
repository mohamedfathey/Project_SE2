import 'package:amazon/controller/services/users_product_services.dart';
import 'package:amazon/model/ProductModel.dart';
import 'package:flutter/material.dart';

class UsersProductProvider extends ChangeNotifier {
  List<ProductModel> searchedProducts = [];

  bool productsFetched = false;

  emptySearchedProductsList() {
    searchedProducts = [];
    productsFetched = false;
    notifyListeners();
  }

  getSearchedProducts({required String productName}) async {
    searchedProducts = await UsersProductService.getProducts(productName);
    productsFetched = true;
    notifyListeners();
  }
}
