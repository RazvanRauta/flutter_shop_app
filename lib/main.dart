import 'package:flutter/material.dart';
import 'package:shop_app/src/navigation/navigation.dart';
import 'package:shop_app/src/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MyShop', theme: themeData, routes: routes);
  }
}
