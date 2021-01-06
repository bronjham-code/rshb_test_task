import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rshb_test_task/models/category.dart';
import 'package:rshb_test_task/models/farmer.dart';
import 'package:rshb_test_task/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatalogProvider with ChangeNotifier {
  static String _categoriesKey = 'categories';
  static String _farmersKey = 'farmers';
  static String _productsKey = 'products';

  var _categories = List<ProductCategory>();
  var _farmers = List<ProductFarmer>();
  var _products = List<Product>();
  var _favorites = List<String>();

  SharedPreferences prefs;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;
  List<ProductCategory> get categories => _categories;

  ProductCategory categoryById(int id) =>
      _categories.firstWhere((element) => element.id == id);
  ProductFarmer farmerById(int id) =>
      _farmers.firstWhere((element) => element.id == id);
  Product productById(int id) =>
      _products.firstWhere((element) => element.id == id);

  Future<List<Product>> products(
      {List<int> filterByCategory, bool sortByPrice = false}) async {
    if (filterByCategory != null && filterByCategory.isNotEmpty) {
      List<Product> productsList;
      await Future.forEach(_products, (product) {
        if (filterByCategory.contains(product.categoryId)) {
          if (productsList == null) productsList = List<Product>();
          productsList.add(product);
        }
      });
      return _sortingProducts(productsList, sortByPrice: sortByPrice);
    }
    return _sortingProducts(_products, sortByPrice: sortByPrice);
  }

  List<Product> _sortingProducts(List<Product> products,
      {bool sortByPrice = false}) {
    if (sortByPrice) {
      products.sort((a, b) => a.price.compareTo(b.price));
    } else {
      products.sort((a, b) => b.totalRating.compareTo(a.totalRating));
    }
    return products;
  }

  void setFavorite(int productId) {
    if (_favorites.contains(productId.toString())) {
      _favorites.remove(productId.toString());
    } else {
      _favorites.add(productId.toString());
    }
    prefs.setStringList('rshb_favorites', _favorites);
    notifyListeners();
  }

  bool isFavorite(int productId) => _favorites.contains(productId.toString());

  Future<void> loadFromAssets(String assetsFilePath) async {
    await Future.delayed(Duration(milliseconds: 500));
    prefs = await SharedPreferences.getInstance();
    _favorites.clear();
    var favoritesFromStorage = prefs.getStringList('rshb_favorites');
    if (favoritesFromStorage != null && favoritesFromStorage.isNotEmpty) {
      _favorites = prefs.getStringList('rshb_favorites');
    }
    Map<String, dynamic> mapData =
        jsonDecode(await PlatformAssetBundle().loadString(assetsFilePath));

    _categories.clear();
    _farmers.clear();
    _products.clear();

    if (mapData != null && mapData.isNotEmpty) {
      if (mapData.containsKey(_categoriesKey)) {
        await Future.forEach(mapData[_categoriesKey],
            (category) => _categories.add(ProductCategory.fromMap(category)));
      }
      if (mapData.containsKey(_farmersKey)) {
        await Future.forEach(mapData[_farmersKey],
            (farmer) => _farmers.add(ProductFarmer.fromMap(farmer)));
      }
      if (mapData.containsKey(_productsKey)) {
        await Future.forEach(mapData[_productsKey],
            (product) async => _products.add(await Product.fromMap(product)));
      }
    }
    _isLoaded = true;
  }
}
