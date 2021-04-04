import '../utility/libraries.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
  ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
  CartScreen.routeName: (ctx) => CartScreen(),
  OrdersScreen.routeName: (ctx) => OrdersScreen(),
  UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
  EditProductScreen.routeName: (ctx) => EditProductScreen(),
};
