import 'package:flutter/foundation.dart';

class CartItemModel with DiagnosticableTreeMixin {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItemModel(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '$runtimeType(id: $id,title: $title, quantity: $quantity)';
  }
}

class CartProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, CartItemModel> _items = {};

  Map<String, CartItemModel> get items {
    return {..._items};
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => CartItemModel(
          id: existingItem.id,
          title: existingItem.title,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItemModel(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach(
        (key, cartItem) => total += cartItem.price * cartItem.quantity);
    return total;
  }

  void removeItem(String prodId) {
    _items.remove(prodId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('cartItems', items.toString()));
  }
}
