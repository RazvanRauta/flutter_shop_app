import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'src/navigation/navigation.dart';
import 'src/providers/cart.dart';
import 'src/providers/orders.dart';
import 'src/providers/products.dart';
import 'src/providers/auth.dart';
import 'src/theme/theme.dart';
import 'src/screens/auth_screen.dart';
import 'src/screens/products_overview_screen.dart';

Future main() async {
  await DotEnv.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: (_) => ProductsProvider('', []),
          update: (ctx, auth, previousProducts) => ProductsProvider(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          create: (_) => OrdersProvider('', []),
          update: (ctx, auth, previousProducts) => OrdersProvider(
            auth.token,
            previousProducts == null ? [] : previousProducts.orders,
          ),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          theme: themeData,
          routes: routes),
    );
  }
}
