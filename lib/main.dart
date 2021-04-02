import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'src/navigation/navigation.dart';
import 'src/providers/cart.dart';
import 'src/providers/orders.dart';
import 'src/providers/products.dart';
import 'src/theme/theme.dart';
import 'src/screens/auth_screen.dart';

Future main() async {
  await DotEnv.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyShop', home: AuthScreen(), theme: themeData, routes: routes);
  }
}
