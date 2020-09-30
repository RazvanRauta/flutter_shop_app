import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/src/providers/orders.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;

  const OrderItem({Key key, @required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${order.amount}',
            ),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}