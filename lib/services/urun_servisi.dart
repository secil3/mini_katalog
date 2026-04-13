import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/urun.dart';

class UrunServisi {
  static const String _baseUrl = 'https://dummyjson.com';

  static Future<List<Urun>> urunleriGetir() async {
    final kategoriler = [
      'smartphones',
      'laptops',
      'tablets',
      'mobile-accessories',
      'beauty',
      'fragrances',
      'skin-care',
      'furniture',
      'home-decoration',
      'kitchen-accessories',
      'groceries',
      'sports-accessories',
      'mens-watches',
      'womens-watches',
      'womens-jewellery',
      'sunglasses',
    ];

    final futures = kategoriler.map((kat) =>
        http.get(Uri.parse('$_baseUrl/products/category/$kat?limit=6')));

    final responses = await Future.wait(futures);

    final List<Urun> tumUrunler = [];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List urunListesi = data['products'];
        tumUrunler.addAll(urunListesi.map((json) => Urun.fromJson(json)));
      }
    }

    return tumUrunler;
  }
}