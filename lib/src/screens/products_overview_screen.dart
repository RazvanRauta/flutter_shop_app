import 'package:flutter/material.dart';
import 'package:shop_app/src/widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyShop',
        ),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions value) {
                if (value == FilterOptions.Favorites) {
                  setState(() {
                    _showOnlyFavorites = true;
                  });
                } else {
                  setState(() {
                    _showOnlyFavorites = false;
                  });
                }
              },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only Favorites'),
                      value: FilterOptions.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: FilterOptions.All,
                    )
                  ])
        ],
      ),
      body: ProductsGrid(
        showOnlyFavorites: _showOnlyFavorites,
      ),
    );
  }
}
