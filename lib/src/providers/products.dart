import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/src/data/products.dart';
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

  void addProduct() {
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('items', items));
  }
}
