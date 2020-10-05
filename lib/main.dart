import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/navigation/navigation.dart';
import 'src/providers/cart.dart';
import 'src/providers/orders.dart';
import 'src/providers/products.dart';
import 'src/theme/theme.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductsProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => OrdersProvider()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MyShop', theme: themeData, routes: routes);
  }
}
