import 'package:bussiness_manager/Provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/Products.dart';
import '../Provider/orders.dart';
import 'screens/cart_screen.dart';
import 'screens/admin_product_screen.dart';
import 'screens/edit_products_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value:Products()),
        ChangeNotifierProvider(create:((context) =>Cart())),
        ChangeNotifierProvider(create:((context) =>Orders())),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Lato',
          ),
        
        title: 'Bussines_Manager',
        home:ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrdersScreen.routename: (ctx) => const OrdersScreen(),
          UserProductsScreen.routeName: (ctx) =>  UserProductsScreen(),
          EditProductScreen.routeName: (ctx) =>  EditProductScreen(),
        }
      ),
    );
  }
}

