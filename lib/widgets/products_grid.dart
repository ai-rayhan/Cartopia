import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/Products.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
///////////////// instance product provider////////////
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
///////////////////
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider(
        create: (context) => products[i],
        child: const ProductItem(
          // products[i].id,
          // products[i].title,
          // products[i].imageUrl,
        ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
