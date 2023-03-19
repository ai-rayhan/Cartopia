import 'package:provider/provider.dart';

import '../Provider/Products.dart';
import '../widgets/admin_product_item.dart';
import '/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

import 'edit_products_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = 'productsEditscreen';

  const UserProductsScreen({super.key});
  refresh(BuildContext context)async{
   await  Provider.of<Products>(context,listen: false).fachAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => refresh(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                  productsData.items[i].title,
                  productsData.items[i].imageUrl,
                  productsData.items[i].id,
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
