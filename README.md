# Mini Katalog Uygulaması

## Açıklama
Flutter ile geliştirilmiş, gerçek API entegrasyonlu modern bir e-ticaret katalog uygulaması. Kullanıcılar ürünleri kategorilere göre filtreleyebilir, ürün detaylarını görüntüleyebilir ve sepete ekleyebilir.

## Özellikler
-  Gerçek API'den ürün listeleme (DummyJSON)
-  Ürün arama ve kategori filtreleme
-  Ürün detay sayfası
-  Sepet sistemi
-  Splash screen animasyonu
-  Modern UI tasarımı

## Kullanılan Teknolojiler
- Flutter 3.41.6
- Dart 3.11.4
- http paketi (API entegrasyonu)
- DummyJSON API

## Proje Klasör Yapısı
| Dosya | Açıklama |
|-------|----------|
| `lib/main.dart` | Uygulamanın giriş noktası |
| `lib/models/urun.dart` | Ürün veri modeli ve fromJson |
| `lib/screens/splash_screen.dart` | Açılış animasyon ekranı |
| `lib/screens/ana_ekran.dart` | Alt navigasyon bar yönetimi |
| `lib/screens/ana_sayfa.dart` | Ürün listesi ve kategori filtreleme |
| `lib/screens/detay_sayfasi.dart` | Ürün detay ekranı |
| `lib/screens/sepet_sayfasi.dart` | Sepet ve ödeme ekranı |
| `lib/services/urun_servisi.dart` | DummyJSON API entegrasyonu |

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
<img width="407" height="719" alt="Screenshot 2026-04-15 at 14 31 41" src="https://github.com/user-attachments/assets/5f9cb44b-2f59-4220-9fc7-e0c27dee4398" />
<img width="407" height="719" alt="Screenshot 2026-04-15 at 14 31 24" src="https://github.com/user-attachments/assets/6b1db315-dd51-4fb1-b20a-49dc3e0b22a1" />
