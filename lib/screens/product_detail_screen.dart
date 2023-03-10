import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/Products.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context)?.settings.arguments as String; // is the id!
    print(productId);
    final loadedProduct = Provider.of<Products>(context).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(40.0),
                height: 300,
                width: double.infinity,
                child: Image.asset(
                  loadedProduct.imageUrl,
                  fit: BoxFit.fitHeight,
                )),
          ],
        ),
      ),
    );
  }
}
