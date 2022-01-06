import 'dart:convert';

import 'package:flutter/cupertino.dart';
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

  void _setFavValue(newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  void toggleFavorite() async {
    var url = Uri.parse(
        "https://shopappflutter-1a36e-default-rtdb.firebaseio.com/products/$id.json");
    var oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      var response = await http.patch(
        url,
        body: json.encode(
          {
            "isFavorite": isFavorite,
          },
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (err) {
      _setFavValue(oldStatus);
    }
  }
}
