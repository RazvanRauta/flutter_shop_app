import 'package:flutter/material.dart';
import 'package:shop_app/src/data/products.dart';
import 'package:shop_app/src/widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyShop',
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (context, i) => ProductItem(
          id: products[i].id,
          title: products[i].title,
          imageUrl: products[i].imageUrl,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
