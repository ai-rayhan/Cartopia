// https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]

// https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]

import 'dart:convert';
import 'dart:async';

import 'package:bussiness_manager/models/http_exeception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
      final prefs = await SharedPreferences.getInstance();
      final authdata = json.encode({
        'token': token,
        'userId': userId,
        'exparyDate': expiryDate.toIso8601String(),
      });
      prefs.setString('authdata', authdata);
      autoLogout();
      notifyListeners();
      trytoLogIn();
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

  Future<bool> trytoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    final getauthdata = prefs.getString('authdata');
    if (!prefs.containsKey('authdata')) {
      return false;
    } else {
      final exetractedata = json.decode(getauthdata!) as Map<String, dynamic>;
      final exparydate = DateTime.parse(exetractedata['exparyDate'].toString());
      if (exparydate.isBefore(DateTime.now())) {
        return false;
      }
      token = exetractedata['token'];
      userId = exetractedata['userId'];
      expiryDate = exparydate;
      print('$expiryDate $userId $token');
      notifyListeners();
      autoLogout();
      return true;
    }
  }

  logout() async{
    token = null;
    userId = '';
    expiryDate = null;
    if (authtimer != null) {
      authtimer.cancel();
      authtimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
      prefs.remove('authdata');
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
