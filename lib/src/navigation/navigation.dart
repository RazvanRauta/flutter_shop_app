import 'package:flutter/material.dart';
import 'package:shop_app/src/screens/cart_screen.dart';
import 'package:shop_app/src/screens/orders_screen.dart';
import 'package:shop_app/src/screens/product_detail_screen.dart';
import 'package:shop_app/src/screens/products_overview_screen.dart';
import 'package:shop_app/src/screens/user_products_screen.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
  ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
  CartScreen.routeName: (ctx) => CartScreen(),
  OrdersScreen.routeName: (ctx) => OrdersScreen(),
  UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
};
