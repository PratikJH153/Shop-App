import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  final String? authToken;

  Orders(this.authToken, this._orders);

  Future<void> fetchAndSetOrders() async {
    var url = Uri.parse(
        "https://shopappflutter-1a36e-default-rtdb.firebaseio.com/orders.json?auth=$authToken");
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (data == null) {
      return;
    }
    data.forEach((orderID, orderData) {
      final orderItem = OrderItem(
        id: orderID,
        amount: orderData["amount"],
        products: (orderData["products"] as List<dynamic>)
            .map(
              (item) => CartItem(
                id: item["id"],
                title: item["title"],
                quantity: item["quantity"],
                price: item["price"],
              ),
            )
            .toList(),
        dateTime: DateTime.parse(orderData["dateTime"]),
      );
      loadedOrders.add(orderItem);
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    var url = Uri.parse(
        "https://shopappflutter-1a36e-default-rtdb.firebaseio.com/orders.json?auth=$authToken");
    final timestamp = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "amount": total,
            "dateTime": timestamp.toIso8601String(),
            "products": cartProducts
                .map(
                  (e) => {
                    "id": e.id,
                    "title": e.title,
                    "quantity": e.quantity,
                    "price": e.price,
                  },
                )
                .toList(),
          },
        ),
      );
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)["name"],
          amount: total,
          dateTime: timestamp,
          products: cartProducts,
        ),
      );
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
