import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/Products.dart';
import '../Provider/product.dart';
import 'product_item.dart';

class ProductsGrid extends StatefulWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  List<Product> _products = [];
  var searchController = TextEditingController();
  void _onSearchChanged() {
    setState(() {
      _products = Provider.of<Products>(context, listen: false)
          .searchProducts(searchController.text);
    });
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
///////////////// instance product provider////////////
    final productsData = Provider.of<Products>(context);
    final products = widget.showFavs
        ? productsData.favoriteItems
        : _products.isNotEmpty
            ? _products
            : searchController.text == ''
                ? productsData.items
                : _products;
///////////////////
    return Column(
      children: [
        searchBar(searchController),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: products.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              // create: (context) => products[i],
              value: products[i],
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
          ),
        ),
      ],
    );
  }
}

Container searchBar(TextEditingController searchController) {
  return Container(
    height: 40,
    margin: const EdgeInsets.all(16),
    child: Form(
      child: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
            labelText: "Search Product",
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: const Color.fromARGB(255, 183, 58, 156),
            border: outlineborder(2, Colors.white60),
            focusedBorder: outlineborder(2, const Color.fromARGB(153, 43, 0, 37)),
            errorBorder: outlineborder(2, Colors.red)),
        textInputAction: TextInputAction.done,
      ),
    ),
  );
}

OutlineInputBorder outlineborder(double width, Color color) {
  return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(width: width, color: color));
}
