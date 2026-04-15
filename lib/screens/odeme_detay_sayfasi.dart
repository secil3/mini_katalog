import 'package:flutter/material.dart';
import '../models/urun.dart';

class OdemeDetaySayfasi extends StatelessWidget {
  final String siparisNo;
  final DateTime siparisTarihi;
  final List<Urun> urunler;
  final double toplamTutar;
  final String teslimatAdresi;
  final String odemeYontemi;

  const OdemeDetaySayfasi({
    super.key,
    required this.siparisNo,
    required this.siparisTarihi,
    required this.urunler,
    required this.toplamTutar,
    required this.teslimatAdresi,
    required this.odemeYontemi,
  });

  String _tarihFormatla(DateTime tarih) {
    return '${tarih.day.toString().padLeft(2, '0')}.'
        '${tarih.month.toString().padLeft(2, '0')}.'
        '${tarih.year}  '
        '${tarih.hour.toString().padLeft(2, '0')}:'
        '${tarih.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text(
          'Ödeme Detayı',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: Color(0xFFECEBFF),
                    child: Icon(
                      Icons.check_rounded,
                      color: Color(0xFF6C63FF),
                      size: 36,
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Ödeme Başarılı',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Siparişiniz başarıyla oluşturuldu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _bilgiKarti(
              children: [
                _satir('Sipariş No', siparisNo),
                _satir('Tarih', _tarihFormatla(siparisTarihi)),
                _satir('Ödeme Yöntemi', odemeYontemi),
                _satir('Toplam Tutar', '₺${toplamTutar.toStringAsFixed(0)}'),
              ],
            ),
            const SizedBox(height: 16),
            _bilgiKarti(
              title: 'Teslimat Adresi',
              children: [
                Text(
                  teslimatAdresi,
                  style: const TextStyle(fontSize: 15, height: 1.5),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _bilgiKarti(
              title: 'Sipariş Edilen Ürünler',
              children: urunler
                  .map(
                    (urun) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              urun.ad,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          Text(
                            '₺${urun.fiyat.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: Color(0xFF6C63FF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  'Ana Sayfaya Dön',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bilgiKarti({
    String? title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
          ],
          ...children,
        ],
      ),
    );
  }

  Widget _satir(String baslik, String deger) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              baslik,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: Text(
              deger,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}