import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'main.dart';

class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List currencies;
  final List<MaterialColor> _colors = [Colors.blue, Colors.red, Colors.green];
  @override
  Widget build(BuildContext context) {
    var debugDefaultTargetPlatform;
    return Scaffold(
      appBar: AppBar(
        title: Text("COINS"),
        elevation: debugDefaultTargetPlatform == TargetPlatform.iOS?0.0:5.0,
        backgroundColor: Colors.pink,
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final Map currency = widget.currencies[index];
                final MaterialColor color = _colors[index % _colors.length];
                return _getListItemUi(currency, color);
              },
            ),
          ),
        ],
      ),
    );
  }

  ListTile _getListItemUi(Map currency, MaterialColor color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(currency['name'][0]),
      ),
      title:
          Text(currency['name'], style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _getsubTitleText(
          currency['price_usd'],
          currency['percent_change_1h'],
          currency['percent_change_24h'],
          currency['percent_change_7d']),
       isThreeLine: true
    );
  }

  Widget _getsubTitleText(String priceUsd, String percentChange1h,
      String percentChange24h, String percentChange7d) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$priceUsd\n", style: TextStyle(color: Colors.black));
    String percenteageChangeText = "1 hour: $percentChange1h%";
    //String percenteageChange24 = "24 hour: $percentChange24h%";
    //String percenteageChange7d = "7d : $percentChange7d%";
    TextSpan percentageChangeTextWidget;
    if (double.parse(percentChange1h) > 0) {
      percentageChangeTextWidget = TextSpan(
          text: percenteageChangeText, style: TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget = TextSpan(
          text: percenteageChangeText, style: TextStyle(color: Colors.red));
    }

    return RichText(
      text: TextSpan(children: [priceTextWidget, percentageChangeTextWidget]),
    );
  }
}
