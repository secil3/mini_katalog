import 'package:flutter/material.dart';
import '../models/urun.dart';

class SepetSayfasi extends StatelessWidget {
  final List<Urun> sepet;
  final Function(int) sepettenCikar;

  const SepetSayfasi(
      {super.key, required this.sepet, required this.sepettenCikar});

  @override
  Widget build(BuildContext context) {
    final toplam = sepet.fold(0.0, (sum, u) => sum + u.fiyat);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        title: const Text('Sepetim',
            style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: sepet.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 90, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Sepetiniz boş',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  Text('Ürün eklemek için ana sayfaya gidin',
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: sepet.length,
                    itemBuilder: (context, index) {
                      final urun = sepet[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8)
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 56,
                              height: 56,
                              color: urun.renk.withOpacity(0.1),
                              child: Image.network(
                                urun.gorselUrl,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => Icon(
                                    Icons.image_not_supported_outlined,
                                    color: urun.renk),
                              ),
                            ),
                          ),
                          title: Text(urun.ad,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          subtitle: Text(urun.marka,
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  '₺${urun.fiyat.toStringAsFixed(0)}',
                                  style: TextStyle(
                                      color: urun.renk,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => sepettenCikar(index),
                                child: const Icon(Icons.delete_outline,
                                    color: Colors.redAccent),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10)
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${sepet.length} ürün',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 14)),
                          Text('₺${toplam.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6C63FF))),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Divider(),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Toplam',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text('₺${toplam.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6C63FF))),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C63FF),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(16)),
                          ),
                          child: const Text('Satın Al',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}