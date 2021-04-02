import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import '../screens/edit_product_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/products_overview_screen.dart';
import '../screens/user_products_screen.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
  ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
  CartScreen.routeName: (ctx) => CartScreen(),
  OrdersScreen.routeName: (ctx) => OrdersScreen(),
  UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
  EditProductScreen.routeName: (ctx) => EditProductScreen(),
};
