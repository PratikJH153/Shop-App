import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBjrwIekr1a4bOXldjSIZogvPcU6n2Qf0o");

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }),
      );

      final responseData = json.decode(response.body);

      if (responseData["error"] != null) {
        throw HttpException(responseData["error"]["message"]);
      }

      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData["expiresIn"])));

      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    //! WE NEED TO RETURN IT BECAUSE IT RETURNS A FUTURE WHICH AWAITS FOR THE PROCESS
    //! IF WE DONT RETURN IT THEN IT WONT AWAIT FOR THE PROCESS
    return authenticate(email, password, "signUp");
  }

  Future<void> signin(String email, String password) async {
    return authenticate(email, password, "signInWithPassword");
  }
}
