import '../utility/libraries.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final auth = context.watch<AuthProvider>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder:
                  AssetImage('lib/src/assets/images/product-placeholder.png'),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: product.isFavorite
                ? Icon(
                    Icons.favorite,
                  )
                : Icon(Icons.favorite_border),
            onPressed: () async {
              try {
                await context
                    .read<Product>()
                    .toggleFavoriteStatus(auth.token, auth.userId);
              } catch (error) {
                scaffoldMessenger.showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Failed to set favorite",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              context.read<CartProvider>().addItem(
                    product.id,
                    product.price,
                    product.title,
                  );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Item added to cart',
                    textAlign: TextAlign.left,
                  ),
                  duration: Duration(
                    seconds: 2,
                  ),
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () =>
                          context.read<CartProvider>().removeSingleProduct(
                                product.id,
                              )),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
