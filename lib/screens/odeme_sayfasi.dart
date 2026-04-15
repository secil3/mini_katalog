import 'package:flutter/material.dart';
import '../models/urun.dart';
import 'odeme_detay_sayfasi.dart';

class OdemeSayfasi extends StatefulWidget {
  final List<Urun> sepet;
  final VoidCallback sepetiTemizle;

  const OdemeSayfasi({
    super.key,
    required this.sepet,
    required this.sepetiTemizle,
  });

  @override
  State<OdemeSayfasi> createState() => _OdemeSayfasiState();
}

class _OdemeSayfasiState extends State<OdemeSayfasi> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _adSoyadController = TextEditingController();
  final TextEditingController _kartNoController = TextEditingController();
  final TextEditingController _sonKullanmaController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _adresController = TextEditingController();

  bool _odemeIsleniyor = false;

  double get toplamTutar =>
      widget.sepet.fold(0.0, (sum, urun) => sum + urun.fiyat);

  @override
  void dispose() {
    _adSoyadController.dispose();
    _kartNoController.dispose();
    _sonKullanmaController.dispose();
    _cvvController.dispose();
    _adresController.dispose();
    super.dispose();
  }

  String _kartNumarasiFormatla(String value) {
    final temiz = value.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < temiz.length; i++) {
      buffer.write(temiz[i]);
      if ((i + 1) % 4 == 0 && i != temiz.length - 1) {
        buffer.write(' ');
      }
    }

    return buffer.toString();
  }

  Future<void> _odemeyiTamamla() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _odemeIsleniyor = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    final siparisNo =
        'MK${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    final odemeYontemi =
        '**** **** **** ${_kartNoController.text.replaceAll(' ', '').substring(_kartNoController.text.replaceAll(' ', '').length - 4)}';

    widget.sepetiTemizle();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OdemeDetaySayfasi(
          siparisNo: siparisNo,
          siparisTarihi: DateTime.now(),
          urunler: widget.sepet,
          toplamTutar: toplamTutar,
          teslimatAdresi: _adresController.text.trim(),
          odemeYontemi: odemeYontemi,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text(
          'Ödeme',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildOzetKart(),
              const SizedBox(height: 16),
              _buildKartBilgileriKart(),
              const SizedBox(height: 16),
              _buildTeslimatKart(),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _odemeIsleniyor ? null : _odemeyiTamamla,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: _odemeIsleniyor
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Ödemeyi Tamamla • ₺${toplamTutar.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOzetKart() {
    return Container(
      padding: const EdgeInsets.all(16),
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
        children: [
          const Row(
            children: [
              Icon(Icons.receipt_long_rounded, color: Color(0xFF6C63FF)),
              SizedBox(width: 8),
              Text(
                'Sipariş Özeti',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...widget.sepet.map(
            (urun) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      urun.ad,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '₺${urun.fiyat.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6C63FF),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.sepet.length} ürün',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              Text(
                '₺${toplamTutar.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C63FF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKartBilgileriKart() {
    return Container(
      padding: const EdgeInsets.all(16),
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
        children: [
          const Row(
            children: [
              Icon(Icons.credit_card_rounded, color: Color(0xFF6C63FF)),
              SizedBox(width: 8),
              Text(
                'Kart Bilgileri',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _adSoyadController,
            decoration: _inputDecoration('Kart Üzerindeki Ad Soyad'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Ad soyad giriniz';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _kartNoController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration('Kart Numarası'),
            onChanged: (value) {
              final formatli = _kartNumarasiFormatla(
                value.replaceAll(RegExp(r'[^0-9]'), ''),
              );
              if (formatli != value) {
                _kartNoController.value = TextEditingValue(
                  text: formatli,
                  selection: TextSelection.collapsed(offset: formatli.length),
                );
              }
            },
            validator: (value) {
              final temiz = (value ?? '').replaceAll(' ', '');
              if (temiz.length != 16) {
                return 'Geçerli bir kart numarası giriniz';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _sonKullanmaController,
                  keyboardType: TextInputType.datetime,
                  decoration: _inputDecoration('AA/YY'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Son kullanma giriniz';
                    }
                    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                      return 'AA/YY formatı kullanın';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _cvvController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: _inputDecoration('CVV'),
                  validator: (value) {
                    if (value == null || value.length != 3) {
                      return '3 haneli CVV';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeslimatKart() {
    return Container(
      padding: const EdgeInsets.all(16),
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
        children: [
          const Row(
            children: [
              Icon(Icons.location_on_outlined, color: Color(0xFF6C63FF)),
              SizedBox(width: 8),
              Text(
                'Teslimat Bilgisi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _adresController,
            maxLines: 3,
            decoration: _inputDecoration('Teslimat Adresi'),
            validator: (value) {
              if (value == null || value.trim().length < 10) {
                return 'Daha detaylı bir adres giriniz';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF8F8FC),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 1.3),
      ),
    );
  }
}