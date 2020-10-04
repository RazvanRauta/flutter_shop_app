import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/providers/products.dart';
import 'package:shop_app/src/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static String routeName = '/userProducts';

  @override
  Widget build(BuildContext context) {
    final productsData = context.watch<ProductsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Products',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                productsData.items[i].title,
                productsData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
