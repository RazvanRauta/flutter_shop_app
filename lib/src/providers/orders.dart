import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

import 'cart.dart';

class OrderModel {
  final String id;
  final double amount;
  final List<CartItemModel> products;
  final DateTime dateTime;

  OrderModel(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class OrdersProvider with ChangeNotifier {
  List<OrderModel> _orders;
  final String authToken;
  OrdersProvider(
    this.authToken,
    this._orders,
  );

  List<OrderModel> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    if (authToken == '' || authToken == null) {
      return;
    }
    final _params = <String, String>{'auth': authToken};
    final url = Uri.https(env['FIREBASE_URL'], '/orders.json', _params);
    List<OrderModel> fetchedOrders = [];
    try {
      final response = await http.get(url);
      final ordersData = json.decode(response.body) as Map<String, dynamic>;
      if (ordersData == null) {
        return;
      }
      ordersData.forEach((orderId, orderData) {
        final productsData = orderData["products"] as List<dynamic>;
        List<CartItemModel> products = productsData
            .map(
              (ci) => new CartItemModel(
                id: ci["id"],
                title: ci["title"],
                quantity: ci["quantity"],
                price: ci["price"],
              ),
            )
            .toList();

        final order = new OrderModel(
          id: orderId,
          amount: orderData['amount'],
          products: products,
          dateTime: DateTime.parse(orderData["dateTime"]),
        );

        fetchedOrders.add(order);
      });
      _orders = fetchedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      print(error);
      print("some error");
    }
  }

  Future<void> addOrder(List<CartItemModel> cartProducts, double total) async {
    if (authToken == '' || authToken == null) {
      return;
    }
    final _params = <String, String>{'auth': authToken};
    final url = Uri.https(env['FIREBASE_URL'], '/orders.json', _params);
    final timestamp = DateTime.now();

    final response = await http.post(url,
        body: json.encode({
          "amount": total,
          "dateTime": timestamp.toIso8601String(),
          'products': cartProducts
              .map((cartProd) => {
                    "id": cartProd.id,
                    "title": cartProd.title,
                    "quantity": cartProd.quantity,
                    "price": cartProd.price,
                  })
              .toList(),
        }));

    if (response.statusCode >= 400) {
      throw HttpException(message: "Failed to place the order");
    }
    _orders.insert(
      0,
      OrderModel(
        id: json.decode(response.body)["name"],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
