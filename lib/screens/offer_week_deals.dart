import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/Products.dart';
import '../Provider/product.dart';
import '../widgets/product_item.dart';

class OfferScreen extends StatefulWidget {
  OfferScreen();
  static const routeName = 'offer';

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  List<Product> _products = [];
  bool showFavs=false;
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
    final products = showFavs
        ? productsData.favoriteItems
        : _products.isNotEmpty
            ? _products
            : searchController.text == ''
                ? productsData.items
                : _products;
///////////////////
    return Scaffold(
       appBar: AppBar(
        title: const Text('Offer'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              searchBar(searchController),
              Text("Feature Products",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              Container(
                height:700,
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
          ),
        ),
      ),
    );
  }

  Padding categoryCard() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color(0xffdddddd),
            )
          ], borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Image.asset(
                'assets/images/light_food.png',
                width: 30,
              ),
              SizedBox(
                  width: 90,
                  child: Text(
                    "Electronics",
                  ))
            ],
          )),
    );
  }
}

Container searchBar(TextEditingController searchController) {
  return Container(
    height: 40,
    margin: const EdgeInsets.only(bottom: 15),
    child: Form(
      child: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
            labelText: "Search Product",
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: const Color.fromARGB(255, 183, 58, 156),
            border: outlineborder(2, Colors.white60),
            focusedBorder:
                outlineborder(2, const Color.fromARGB(153, 43, 0, 37)),
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
