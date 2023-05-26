import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

import '/models/http_exeception.dart';
import 'package:flutter/cupertino.dart';

import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  var authToken;
  var userId;
  Products(this.authToken, this._items, this.userId);
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

  List<Product> searchProducts(String searchvalue) {
    return _items
        .where((prodItem) =>
            prodItem.title.toLowerCase().contains(searchvalue.toLowerCase()))
        .toList();
  }

  findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fachAndSetProducts([bool filterByUser = false]) async {
    var filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://store-manager-f4301-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      var response = await http.get(Uri.parse(url));
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(response.body);

      url =
          'https://store-manager-f4301-default-rtdb.firebaseio.com/userFavorie/$userId.json?auth=$authToken';
      var favresponse = await http.get(Uri.parse(url));
      var favRsponseData = json.decode(favresponse.body);

      final List<Product> loadedproducts = [];
      extractedData.forEach((prodId, prodata) {
        loadedproducts.add(Product(
            id: prodId,
            title: prodata['title'],
            description: prodata['description'],
            price: prodata['price'],
            imageUrl: prodata['imageUrl'],
            isFavorite: favRsponseData == null
                ? false
                : favRsponseData[prodId] ?? false));
      });
      _items = loadedproducts;
      notifyListeners();
    } catch (e) {}
  }

  // hive
  // final hivebox = Hive.box('hiveBox');

  // Future<void> addProduct2(Product product) async {
  //   var input = jsonEncode({
  //     'title': product.title,
  //     'description': product.description,
  //     'price': product.price,
  //     'imageUrl': product.imageUrl,
  //     'isFavorite': product.isFavorite,
  //     'creatorId': userId
  //   });
  //   hivebox.add(input);
  //   print(hivebox.length);
  //   final newProduct = Product(
  //       title: product.title,
  //       description: product.description,
  //       price: product.price,
  //       imageUrl: product.imageUrl,
  //       id: '');
  //   print(product.title);
  //   // _items.insert(0, newProduct); // at the start of the list
  //   notifyListeners();
  // }

  Future<void> addProduct(Product product) async {
    final url =
        'https://store-manager-f4301-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
            'creatorId': userId
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
            'https://store-manager-f4301-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
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

  Future<void> deleteProduct(String id) async {
    final url =
        'https://store-manager-f4301-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    var existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var exitingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    try {
      var response = await http.delete(Uri.parse(url));
      if (response.statusCode >= 400) {
        _items.insert(existingProductIndex, exitingProduct);
        notifyListeners();
        throw HttpExeception("Could not delete");
      }
    } catch (e) {}
  }
}
