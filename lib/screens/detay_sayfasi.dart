import 'package:flutter/material.dart';
import '../models/urun.dart';

class DetaySayfasi extends StatelessWidget {
  final Urun urun;
  final Function(Urun) sepeteEkle;

  const DetaySayfasi(
      {super.key, required this.urun, required this.sepeteEkle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        title: Text(urun.marka,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 260,
            color: Colors.white,
            padding: const EdgeInsets.all(24),
            child: Image.network(
              urun.gorselUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Center(
                    child: CircularProgressIndicator(color: urun.renk));
              },
              errorBuilder: (context, error, stack) => Icon(
                  Icons.image_not_supported_outlined,
                  color: urun.renk,
                  size: 80),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(urun.kategori,
                      style: TextStyle(
                          color: urun.renk,
                          fontSize: 13,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(urun.ad,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold))),
                      Text('₺${urun.fiyat.toStringAsFixed(0)}',
                          style: TextStyle(
                              fontSize: 22,
                              color: urun.renk,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(urun.marka,
                      style: TextStyle(
                          color: Colors.grey.shade500, fontSize: 15)),
                  const SizedBox(height: 20),
                  const Text('Açıklama',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(urun.aciklama,
                      style: const TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: Colors.black87)),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        sepeteEkle(urun);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${urun.ad} sepete eklendi!'),
                            backgroundColor: urun.renk,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                      label: const Text('Sepete Ekle',
                          style: TextStyle(fontSize: 17)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: urun.renk,
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}