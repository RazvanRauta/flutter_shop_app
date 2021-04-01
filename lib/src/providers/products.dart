import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop_app/src/models/http_exception.dart';

import 'product.dart';

class ProductsProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<Product> _items = [];

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

  Future<void> fetchAndSetProducts() async {
    final url = Uri.https(env['FIREBASE_URL'], '/products.json');
    final List<Product> fetchedProducts = [];
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((prodId, prodData) {
        final prod = new Product(
            id: prodId,
            title: prodData["title"],
            description: prodData["description"],
            price: prodData["price"],
            imageUrl: prodData["imageUrl"],
            isFavorite: prodData["isFavorite"]);
        fetchedProducts.add(prod);
      });
      _items = fetchedProducts;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(env['FIREBASE_URL'], '/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite
        }),
      );

      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);

      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product editedProduct) async {
    final url = Uri.https(env['FIREBASE_URL'], '/products/$id.json');
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      try {
        await http.patch(
          url,
          body: json.encode({
            "title": editedProduct.title,
            "description": editedProduct.description,
            "price": editedProduct.price,
            "imageUrl": editedProduct.imageUrl,
            "isFavorite": editedProduct.isFavorite
          }),
        );
        _items[prodIndex] = editedProduct;
        notifyListeners();
      } catch (error) {
        print(error);
      }
    } else {
      print('Edited product not found');
    }
  }

// Optimistic delete pattern
  Future<void> deleteProduct(String id) async {
    final url = Uri.https(env['FIREBASE_URL'], '/products/$id.json');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException(message: "Error occurred while deleting product.");
    }
    existingProduct = null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('items', items));
  }
}
