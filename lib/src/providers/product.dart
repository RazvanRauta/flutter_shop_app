import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/http_exception.dart';

class Product with ChangeNotifier, DiagnosticableTreeMixin {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavoriteStatus(String authToken) async {
    if (authToken == '' || authToken == null) {
      return;
    }
    final _params = <String, String>{'auth': authToken};
    final url = Uri.https(env['FIREBASE_URL'], '/products/$id.json', _params);

    isFavorite = !isFavorite;
    notifyListeners();
    final response = await http.patch(
      url,
      body: json.encode(
        {"isFavorite": isFavorite},
      ),
    );
    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw HttpException(message: "Something went wrong");
    }
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '$runtimeType(id: $id,title: $title, description: $description, price: $price, imageUrl: $imageUrl)';
  }
}
