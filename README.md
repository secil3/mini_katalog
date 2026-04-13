# Mini Katalog Uygulaması

## Açıklama
Flutter ile geliştirilmiş, gerçek API entegrasyonlu modern bir e-ticaret katalog uygulaması. Kullanıcılar ürünleri kategorilere göre filtreleyebilir, ürün detaylarını görüntüleyebilir ve sepete ekleyebilir.

## Özellikler
- 🛍️ Gerçek API'den ürün listeleme (DummyJSON)
- 🔍 Ürün arama ve kategori filtreleme
- 📱 Ürün detay sayfası
- 🛒 Sepet sistemi
- 💫 Splash screen animasyonu
- 🎨 Modern UI tasarımı

## Kullanılan Teknolojiler
- Flutter 3.41.6
- Dart 3.11.4
- http paketi (API entegrasyonu)
- DummyJSON API

## Proje Klasör Yapısı
lib/
├── main.dart
├── models/
│   └── urun.dart
├── screens/
│   ├── splash_screen.dart
│   ├── ana_ekran.dart
│   ├── ana_sayfa.dart
│   ├── detay_sayfasi.dart
│   └── sepet_sayfasi.dart
└── services/
└── urun_servisi.dart

## Çalıştırma Adımları

1. Flutter SDK'nın kurulu olduğundan emin olun
2. Repoyu klonlayın:
```bash
   git clone <repo-url>
```
3. Proje klasörüne girin:
```bash
   cd mini_katalog
```
4. Bağımlılıkları yükleyin:
```bash
   flutter pub get
```
5. Uygulamayı çalıştırın:
```bash
   flutter run
```

## Ekran Görüntüleri
_(screenshots klasörüne bakınız)_
