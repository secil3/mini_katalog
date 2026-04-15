import 'package:flutter/material.dart';
import '../models/urun.dart';
import 'ana_sayfa.dart';
import 'sepet_sayfasi.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  int _secilenIndex = 0;
  final List<Urun> sepet = [];

  void sepeteEkle(Urun urun) {
    setState(() {
      sepet.add(urun);
    });
  }

  void sepettenCikar(int index) {
    setState(() {
      sepet.removeAt(index);
    });
  }

  void sepetiTemizle() {
    setState(() {
      sepet.clear();
      _secilenIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sayfalar = [
      AnaSayfa(sepeteEkle: sepeteEkle),
      SepetSayfasi(
        sepet: sepet,
        sepettenCikar: sepettenCikar,
        sepetiTemizle: sepetiTemizle,
      ),
    ];

    return Scaffold(
      body: sayfalar[_secilenIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _secilenIndex,
        onDestinationSelected: (index) {
          setState(() {
            _secilenIndex = index;
          });
        },
        backgroundColor: Colors.white,
        elevation: 8,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: sepet.isNotEmpty,
              label: Text('${sepet.length}'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: sepet.isNotEmpty,
              label: Text('${sepet.length}'),
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Sepet',
          ),
        ],
      ),
    );
  }
}