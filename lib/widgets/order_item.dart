import 'dart:math';

import 'package:flutter/material.dart';

import '../Provider/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
            ListTile(
              title: Text('\$${widget.order.amount}'),
              subtitle: Text("${widget.order.datetime}"),
              trailing: IconButton(
                icon: _expanded? const Icon(Icons.expand_less):const Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
          if(_expanded)
               Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                  height: min(widget.order.products.length*20.0+10, 400),
                  child: ListView(
                    children: widget.order.products
                        .map(
                          (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(prod.title),
                              Text("${prod.quantity} x${prod.price}"),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                )
        ],
      ),
    );
  }
}
