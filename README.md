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
<img width="407" height="719" alt="Screenshot 2026-04-13 at 13 52 42" src="https://github.com/user-attachments/assets/8c752205-f178-4c85-92ef-c8eff9636ea0" />
<img width="407" height="719" alt="Screenshot 2026-04-13 at 13 51 55" src="https://github.com/user-attachments/assets/aa863c64-cc60-411a-9c6b-dd56c78971fc" />
<img width="407" height="719" alt="Screenshot 2026-04-13 at 13 51 33" src="https://github.com/user-attachments/assets/02a06706-af14-46e7-bfaf-b74dcc1abbb1" />
<img width="407" height="719" alt="Screenshot 2026-04-13 at 13 51 27" src="https://github.com/user-attachments/assets/bc445f36-6ca5-409c-b503-93ef66d5c616" />

