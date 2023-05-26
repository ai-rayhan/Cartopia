import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/Products.dart';
import '../Provider/product.dart';
import '../screens/offer_week_deals.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              searchBar(searchController),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(children: [
              //     // ListView.builder(itemBuilder: (ctx,i)=>
              //     categoryCard(),
              //     SizedBox(width: 10,),
              //     categoryCard(),
              //     SizedBox(width: 10,),
              //     categoryCard(),
              //   ],),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Weekly Deals",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  IconButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>  OfferScreen(),
                      ),
                    );
                  
                  }, icon: Icon(Icons.arrow_forward))
                ],
              ),
              // Expanded(
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     padding: const EdgeInsets.all(10.0),
              //     itemCount: products.length,
              //     itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              //       // create: (context) => products[i],
              //       value: products[i],
              //       child: const ProductItem(
              //           // products[i].id,
              //           // products[i].title,
              //           // products[i].imageUrl,
              //           ),
              //     ),
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 2,
              //   childAspectRatio: 3 / 2,
              //   crossAxisSpacing: 10,
              //   mainAxisSpacing: 10,
              // ),
              //   ),
              // ),
              Text("Offer",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              SingleChildScrollView(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                        height: 225,
                        child: Row(
                          children: [
                            Expanded(
                                child: Image.asset(
                                    'assets/images/banner-side.png',
                                    fit: BoxFit.cover,
                                    height: 225)),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Image.asset('assets/images/home-banner3.jpg',
                                      fit: BoxFit.cover, height: 110),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Image.asset(
                                    'assets/images/home-banner2.jpg',
                                    fit: BoxFit.cover,
                                    height: 110,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>  OfferScreen(),
                      ),
                    );
                  },
                ),
              ),
              Text("New arrivel",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              Container(
                height:500,
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
