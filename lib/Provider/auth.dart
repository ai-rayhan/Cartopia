// https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]

// https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]

import 'dart:convert';
import 'dart:async';

import 'package:bussiness_manager/models/http_exeception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const apikey = 'AIzaSyCNc89IfAo0YaLH8KfV4HNZoCTWngfFd2A';

class Auth with ChangeNotifier {
  var token;
  var userId;
  var expiryDate;
  var authtimer;
  bool get isAuth {
    return token != null;
  }

   get getUserId {
    return userId;
  }

  get getToken {
    if (expiryDate != null &&
        expiryDate.isAfter(DateTime.now()) &&
        token != null) {
      return token;
    }
    return null;
  }

  Future<void> authenticate(
      String email, String password, String urlSegment) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$apikey');
    try {
      var response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpExeception(responseData['error']['message']);
      }
      token = responseData['idToken'];
      userId = responseData['localId'];
      expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      print(expiryDate);
      autoLogout();
      notifyListeners();
      print(responseData);
    } catch (error) {
      throw error;
    }
  }

  signup(String email, String password) {
    return authenticate(email, password, 'signUp');
  }

  signin(String email, String password) {
    return authenticate(email, password, 'signInWithPassword');
  }

  logout() {
    token = null;
    userId = '';
    expiryDate = null;
    if (authtimer != null) {
      authtimer.cancel();
      authtimer = null;
    }
    notifyListeners();
  }

  autoLogout() {
    if (authtimer != null) {
      authtimer.cancel();
    }
    final exparytime = expiryDate.difference(DateTime.now()).inSeconds;
    authtimer = Timer(Duration(seconds: exparytime), logout);
  }
}
