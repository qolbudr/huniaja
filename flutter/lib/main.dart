import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manpro/presentation/screen/login.dart';
import 'package:manpro/config/theme.dart';
import 'package:manpro/presentation/screen/owner/owner_home.dart';
import 'package:provider/provider.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/provider/favorite.dart';
import 'package:manpro/presentation/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthNotifier>(create: (_) => AuthNotifier()),
        ChangeNotifierProvider<FavoriteNotifier>(create: (_) => FavoriteNotifier()),
      ],
      child: HuniAja(),
    )
  );
}

class HuniAja extends StatefulWidget {
  @override
  _HuniAjaState createState() => _HuniAjaState();
}

class _HuniAjaState extends State<HuniAja> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    context.read<AuthNotifier>().getAuthData();
    String data = prefs.getString('UserData');
    setState(() {
      isLogin = data == null ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, data, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "HuniAja",
          home: isLogin ? data.authLogin.user.role == 0 ? Home() : OwnerHome() : Login(),
          theme: themeData
        );
      }
    );
  }
}