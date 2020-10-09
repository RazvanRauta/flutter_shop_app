import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersProvider = context.watch<OrdersProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (context, index) => OrderItem(
          order: ordersProvider.orders[index],
        ),
      ),
    );
  }
}
