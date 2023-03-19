import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
 Future<void> toggleFavoriteStatus() async{
    var oldstatus = isFavorite;
    isFavorite = !isFavorite;
    var url='https://store-manager-f4301-default-rtdb.firebaseio.com/products/$id.json';
    try{
     await http.patch(Uri.parse(url),body: json.encode({

        'isFavorite':isFavorite

      }));
    }
    catch(e){}
    notifyListeners();
  }
}
