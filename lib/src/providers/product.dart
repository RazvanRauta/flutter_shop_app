import '../utility/libraries.dart';
import 'package:http/http.dart' as http;

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

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    if (authToken == '' || authToken == null) {
      return;
    }
    final _params = <String, String>{'auth': authToken};
    final url = Uri.https(
        env['FIREBASE_URL'], '/userFavorites/$userId/$id.json', _params);

    isFavorite = !isFavorite;
    notifyListeners();
    final response = await http.put(
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
