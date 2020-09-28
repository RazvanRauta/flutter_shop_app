import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/src/data/products.dart';
import 'package:shop_app/src/models/product.dart';

class ProductsProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<Product> _items = products;

  List<Product> get items {
    return [..._items];
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('items', items));
  }
}
