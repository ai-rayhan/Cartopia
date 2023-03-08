import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/Products.dart';
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
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 20)),
        ),
        title: 'Bussines_Manager',
        home:const HomeScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
        }
      ),
    );
  }
}