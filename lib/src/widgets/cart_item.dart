import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/src/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final String prodId;
  final int quantity;
  final String title;

  const CartItem(
      {Key key, this.id, this.price, this.title, this.quantity, this.prodId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(price);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => context.read<CartProvider>().removeItem(prodId),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text(
              title,
            ),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text(
              '$quantity x',
            ),
          ),
        ),
      ),
    );
  }
}