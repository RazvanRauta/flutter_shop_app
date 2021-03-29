import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../data/products.dart';
import 'product.dart';

class ProductsProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<Product> _items = products;

  var _showFavoritesOnly = false;

  List<Product> get items {
    if (_showFavoritesOnly) {
      return _items.where((element) => element.isFavorite).toList();
    }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) =>
      _items.firstWhere((element) => element.id == id);

  Future<void> addProduct(Product product) {
    final url = Uri.https(env['FIREBASE_URL'], '/products.json');

    return http
        .post(
      url,
      body: json.encode({
        "title": product.title,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite
      }),
    )
        .then((response) {
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);

      _items.add(newProduct);

      notifyListeners();
    });
  }

  void updateProduct(String id, Product editedProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = editedProduct;
      notifyListeners();
    } else {
      print('Edited product not found');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('items', items));
  }
}
