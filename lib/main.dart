import 'package:bussiness_manager/Provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/Products.dart';
import 'screens/cart_screen.dart';
import 'screens/home_page.dart';
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
        ChangeNotifierProvider(create:((context) =>Products())),
        ChangeNotifierProvider(create:((context) =>Cart())),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 20)),
        ),
        title: 'Bussines_Manager',
        home:HomeScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
        }
      ),
    );
  }
}