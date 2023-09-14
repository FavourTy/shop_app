import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key});

  //final String id;
  //final String title;
  // final String imageUrl;

  //const ProductItemWidget(this.id, this.title, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
                onPressed: () {
                  product.toggleFavouriteStatus();
                },
                color: Theme.of(context).canvasColor,
                icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border,
                )),
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Add item to cart!"),
                  duration: Duration(
                    seconds: 2,
                  ),
                  action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        cart.removeStringItem(product.id);
                      }),
                ));
              },
              color: Theme.of(context).canvasColor,
              icon: const Icon(Icons.shopping_cart)),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
