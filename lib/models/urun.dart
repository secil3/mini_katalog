import 'package:flutter/material.dart';

class Urun {
  final String ad;
  final String marka;
  final double fiyat;
  final String gorselUrl;
  final String aciklama;
  final Color renk;
  final String kategori;
  final String kategoriSlug;

  Urun({
    required this.ad,
    required this.marka,
    required this.fiyat,
    required this.gorselUrl,
    required this.aciklama,
    required this.renk,
    required this.kategori,
    required this.kategoriSlug,
  });

  factory Urun.fromJson(Map<String, dynamic> json) {
    final slug = json['category'] ?? '';
    return Urun(
      ad: json['title'] ?? '',
      marka: json['brand'] ?? _slugTurkce(slug),
      fiyat: (json['price'] as num).toDouble() * 35,
      gorselUrl: json['thumbnail'] ?? '',
      aciklama: json['description'] ?? '',
      renk: _kategoriRenk(slug),
      kategori: _slugTurkce(slug),
      kategoriSlug: slug,
    );
  }

  static Color _kategoriRenk(String slug) {
    switch (slug) {
      case 'smartphones': return const Color(0xFF5856D6);
      case 'laptops': return const Color(0xFF34AADC);
      case 'tablets': return const Color(0xFF3A86FF);
      case 'mobile-accessories': return const Color(0xFF6C63FF);
      case 'beauty':
      case 'skin-care': return const Color(0xFFFF2D55);
      case 'fragrances': return const Color(0xFFFF6B9D);
      case 'furniture':
      case 'home-decoration':
      case 'kitchen-accessories': return const Color(0xFFAF52DE);
      case 'groceries': return const Color(0xFF4CD964);
      case 'sports-accessories': return const Color(0xFFFF9500);
      case 'mens-shirts':
      case 'mens-shoes':
      case 'tops':
      case 'womens-dresses':
      case 'womens-bags':
      case 'womens-shoes': return const Color(0xFFFF6B35);
      case 'mens-watches':
      case 'womens-watches':
      case 'sunglasses':
      case 'womens-jewellery': return const Color(0xFFFFCC00);
      case 'motorcycle':
      case 'vehicle': return const Color(0xFF636366);
      default: return const Color(0xFF6C63FF);
    }
  }

  static String _slugTurkce(String slug) {
    switch (slug) {
      case 'smartphones': return 'Telefon';
      case 'laptops': return 'Bilgisayar';
      case 'tablets': return 'Tablet';
      case 'mobile-accessories': return 'Aksesuar';
      case 'beauty': return 'Güzellik';
      case 'skin-care': return 'Cilt Bakım';
      case 'fragrances': return 'Parfüm';
      case 'furniture': return 'Mobilya';
      case 'home-decoration': return 'Ev Dekor';
      case 'kitchen-accessories': return 'Mutfak';
      case 'groceries': return 'Market';
      case 'sports-accessories': return 'Spor';
      case 'mens-shirts': return 'Erkek Giyim';
      case 'mens-shoes': return 'Erkek Ayakkabı';
      case 'mens-watches': return 'Erkek Saat';
      case 'tops': return 'Kadın Üst';
      case 'womens-dresses': return 'Kadın Elbise';
      case 'womens-bags': return 'Kadın Çanta';
      case 'womens-shoes': return 'Kadın Ayakkabı';
      case 'womens-watches': return 'Kadın Saat';
      case 'womens-jewellery': return 'Mücevher';
      case 'sunglasses': return 'Gözlük';
      case 'motorcycle': return 'Motosiklet';
      case 'vehicle': return 'Araç';
      default: return 'Diğer';
    }
  }
}