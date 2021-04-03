import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/src/models/http_exception.dart';

class AuthProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(String email, String password, Uri url) async {
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw HttpException(message: responseData["error"]["message"]);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(env['FIREBASE_SIGN_UP_URL']);
    await _authenticate(email, password, url);
  }

  Future<void> signin(String email, String password) async {
    final url = Uri.parse(env['FIREBASE_SIGN_IN_URL']);
    await _authenticate(email, password, url);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '$runtimeType(token: $_token,expiryDate: $_expiryDate, useId: $_userId)';
  }
}
