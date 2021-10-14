import 'package:flutter/material.dart';
import 'package:manpro/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manpro/model/auth_login.dart';
import 'dart:convert';

class AuthNotifier extends ChangeNotifier {
  AuthLogin authLogin;

  void setAuthData(AuthLogin data) async {
    final db = await SharedPreferences.getInstance();
    String dbAuthLogin = jsonEncode(data.toJson()); 
    db.setString('UserData', dbAuthLogin);
    authLogin = data;
    notifyListeners();
  }

  Future<AuthLogin> getAuthData() async {
    final db = await SharedPreferences.getInstance();
    String data = db.getString('UserData');
    if(data != null) {
      authLogin = AuthLogin.fromJson(jsonDecode(data));
    }
    notifyListeners();
    return authLogin;
  }

  void updateUser(User user) async {
    authLogin.user = user;
    // final db = await SharedPreferences.getInstance();
    // String data = db.getString('UserData');
    // authLogin = AuthLogin.fromJson(jsonDecode(data));
    notifyListeners();
  }

  void logout() async {
    final db = await SharedPreferences.getInstance();
    db.remove('UserData');
  } 
}