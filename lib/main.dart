import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home_page.dart';

void main() async {
  List currencies = await getCurrencies();
  print (currencies);
  runApp(MyApp(currencies));
}

class MyApp extends StatelessWidget {
   final List _currencies;
  MyApp (this._currencies);
  @override
  Widget build(BuildContext context) {
    var debugDefaultTargetPlatform;
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink,
      primaryColor: debugDefaultTargetPlatform  == TargetPlatform.iOS?Colors.grey[50]:null),
      home: HomePage(_currencies),
    );
  }
}

Future<List> getCurrencies() async {
  String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
  http.Response response = await http.get(cryptoUrl);
  return json.decode(response.body);
}
