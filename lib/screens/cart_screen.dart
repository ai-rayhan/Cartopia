import 'package:bussiness_manager/Provider/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/cart.dart' show Cart;
import '../widgets/cart_item.dart' as ui;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmaount.toStringAsFixed(2)}',
                      style: const TextStyle(
                          // color: Theme.of(context).primaryColor,
                          ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    child: const Text('ORDER NOW'),
                    onPressed: () { 
                      Provider.of<Orders>(context,listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmaount,
                      );
                      cart.clear();
                    },
                    // textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => ui.CartItem(
                      cart.items.values.toList()[i].id,
                      cart.items.keys.toList()[i],
                      cart.items.values.toList()[i].price,
                      cart.items.values.toList()[i].quantity,
                      cart.items.values.toList()[i].title,
                    )),
          )
        ],
      ),
    );
  }
}
