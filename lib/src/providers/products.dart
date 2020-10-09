import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  void addProduct(Product product) {
    final newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl);

    _items.add(newProduct);

    notifyListeners();
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
