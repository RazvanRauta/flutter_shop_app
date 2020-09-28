import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/navigation/navigation.dart';
import 'package:shop_app/src/providers/cart.dart';
import 'package:shop_app/src/providers/products.dart';
import 'package:shop_app/src/theme/theme.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductsProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
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
