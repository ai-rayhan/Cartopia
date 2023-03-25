import 'package:bussiness_manager/Provider/auth.dart';
import 'package:bussiness_manager/Provider/cart.dart';
import 'package:bussiness_manager/screens/auth_screen.dart';
import 'package:bussiness_manager/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/Products.dart';
import '../Provider/orders.dart';
import 'screens/cart_screen.dart';
import 'screens/admin_product_screen.dart';
import 'screens/edit_products_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_detail_screen.dart';

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
        ChangeNotifierProvider.value(value: Auth()),
       ChangeNotifierProxyProvider<Auth,Products>(create: ((context) => Products('', [],'')), update: ((context, auth, previousProducts) =>Products(auth.getToken, previousProducts!=null?[]:previousProducts!.items,auth.getUserId))),
        ChangeNotifierProvider(create: ((context) => Cart())),
         ChangeNotifierProxyProvider<Auth,Orders>(create: ((context) => Orders('', [])), update: ((context, auth, previousOrders) =>Orders(auth.getToken, previousOrders!=null?[]:previousOrders!.orders))),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.purple,
              fontFamily: 'Lato',
            ),
            title: 'Bussines_Manager',
            home: auth.isAuth?ProductsOverviewScreen():AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (ctx) =>
                  const ProductDetailScreen(),
              CartScreen.routeName: (ctx) => const CartScreen(),
              OrdersScreen.routename: (ctx) => const OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            }),
      ),
    );
  }
}
