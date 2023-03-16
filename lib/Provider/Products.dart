import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //     id: 'p1',
    //     title: 'Red Shirt',
    //     description: 'A red shirt - it is pretty red!',
    //     price: 29.99,
    //     imageUrl: 'assets/images/5.jpg'
    //     // 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     ),
    // Product(
    //     id: 'p2',
    //     title: 'Trousers',
    //     description: 'A nice pair of trousers.',
    //     price: 59.99,
    //     imageUrl: 'assets/images/2.jpg'
    //     // 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //     ),
    // Product(
    //     id: 'p3',
    //     title: 'Yellow Scarf',
    //     description: 'Warm and cozy - exactly what you need for the winter.',
    //     price: 19.99,
    //     imageUrl: 'assets/images/2.jpg'
    //     // 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //     ),
    // Product(
    //     id: 'p4',
    //     title: 'A Pan',
    //     description: 'Prepare any meal you want.',
    //     price: 49.99,
    //     imageUrl: 'assets/images/5.jpg'
    //     // 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //     ),
  ];
  bool isFavorite = false;
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fachAndSetProducts() async {
    var url =
        'https://store-manager-f4301-default-rtdb.firebaseio.com/products.json';
    try {
      var response = await http.get(Uri.parse(url));
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedproducts = [];
      extractedData.forEach((prodId, prodata) {
        loadedproducts.add(Product(
          id: prodId,
          title: prodata['title'],
          description: prodata['description'],
          price: prodata['price'],
          imageUrl: prodata['imageUrl'],
        ));
      });
      _items = loadedproducts;
      notifyListeners();
    } catch (e) {}
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://store-manager-f4301-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite
          }));

      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: jsonDecode(response.body)['name'],
      );
      _items.add(newProduct);
    } catch (error) {
      print(error);
      throw error;
    }

    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      try {
        var url =
            'https://store-manager-f4301-default-rtdb.firebaseio.com/products/$id.json';
        await http.patch(Uri.parse(url),
            body: json.encode({
              'title': newProduct.title,
              'price': newProduct.price,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl
            }));
      } catch (e) {
        print(e);
      }
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
