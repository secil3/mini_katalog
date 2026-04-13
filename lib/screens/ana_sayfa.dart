import 'package:flutter/material.dart';
import '../models/urun.dart';
import '../services/urun_servisi.dart';
import 'detay_sayfasi.dart';

class AnaSayfa extends StatefulWidget {
  final Function(Urun) sepeteEkle;
  const AnaSayfa({super.key, required this.sepeteEkle});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<Urun> tumUrunler = [];
  List<Urun> filtreliUrunler = [];
  final TextEditingController aramaController = TextEditingController();
  bool yukleniyor = true;
  String? hata;
  String secilenKategori = 'Tümü';

final List<Map<String, dynamic>> kategoriler = [
  {'ad': 'Tümü', 'ikon': Icons.apps_rounded, 'renk': const Color(0xFF6C63FF)},
  {'ad': 'Telefon', 'ikon': Icons.phone_iphone, 'renk': const Color(0xFF5856D6)},
  {'ad': 'Bilgisayar', 'ikon': Icons.laptop, 'renk': const Color(0xFF34AADC)},
  {'ad': 'Tablet', 'ikon': Icons.tablet, 'renk': const Color(0xFF3A86FF)},
  {'ad': 'Aksesuar', 'ikon': Icons.headphones, 'renk': const Color(0xFF6C63FF)},
  {'ad': 'Güzellik', 'ikon': Icons.face, 'renk': const Color(0xFFFF2D55)},
  {'ad': 'Cilt Bakım', 'ikon': Icons.spa, 'renk': const Color(0xFFFF6B9D)},
  {'ad': 'Parfüm', 'ikon': Icons.local_florist, 'renk': const Color(0xFFFF6B9D)},
  {'ad': 'Mobilya', 'ikon': Icons.chair, 'renk': const Color(0xFFAF52DE)},
  {'ad': 'Ev Dekor', 'ikon': Icons.home, 'renk': const Color(0xFFAF52DE)},
  {'ad': 'Mutfak', 'ikon': Icons.kitchen, 'renk': const Color(0xFFAF52DE)},
  {'ad': 'Market', 'ikon': Icons.local_grocery_store, 'renk': const Color(0xFF4CD964)},
  {'ad': 'Spor', 'ikon': Icons.sports_basketball, 'renk': const Color(0xFFFF9500)},
];

  @override
  void initState() {
    super.initState();
    _urunleriYukle();
  }

  Future<void> _urunleriYukle() async {
    try {
      setState(() { yukleniyor = true; hata = null; });
      final urunler = await UrunServisi.urunleriGetir();
      setState(() {
        tumUrunler = urunler;
        filtreliUrunler = urunler;
        yukleniyor = false;
      });
    } catch (e) {
      setState(() {
        hata = 'Ürünler yüklenemedi. İnternet bağlantınızı kontrol edin.';
        yukleniyor = false;
      });
    }
  }

void _filtrele({String? arama, String? kategori}) {
  final aramaMetni = arama ?? aramaController.text;
  final secilenKat = kategori ?? secilenKategori;

  setState(() {
    if (kategori != null) secilenKategori = kategori;
    filtreliUrunler = tumUrunler.where((u) {
      final aramaUygun = u.ad.toLowerCase().contains(aramaMetni.toLowerCase());
      final kategoriUygun = secilenKat == 'Tümü' || u.kategori == secilenKat;
      return aramaUygun && kategoriUygun;
    }).toList();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: yukleniyor
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFF6C63FF)),
                  SizedBox(height: 16),
                  Text('Ürünler yükleniyor...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : hata != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(hata!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _urunleriYukle,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Tekrar Dene'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    // ── HERO APPBAR ──────────────────────────
                   SliverAppBar(
  expandedHeight: 160,
  floating: false,
  pinned: true,
  backgroundColor: const Color(0xFF6C63FF),
  foregroundColor: Colors.white,
  flexibleSpace: FlexibleSpaceBar(
    collapseMode: CollapseMode.pin,
    background: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6C63FF), Color(0xFF3A86FF)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 4),
              const Text('Mini Katalog',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10)
                  ],
                ),
                child: TextField(
                  controller: aramaController,
                  onChanged: (v) => _filtrele(arama: v),
                  decoration: const InputDecoration(
                    hintText: 'Ürün ara...',
                    prefixIcon:
                        Icon(Icons.search, color: Color(0xFF6C63FF)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
),
                    // ── KATEGORİ FİLTRELERİ ──────────────────
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 0, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Kategoriler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 90,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: kategoriler.length,
                                itemBuilder: (context, index) {
                                  final kat = kategoriler[index];
                                  final secili = secilenKategori == kat['ad'];
                                  return GestureDetector(
                                    onTap: () => _filtrele(kategori: kat['ad']),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      margin: const EdgeInsets.only(right: 12),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: secili ? kat['renk'] : Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: secili
                                                ? (kat['renk'] as Color).withValues(alpha: 0.4)
                                                : Colors.black.withValues(alpha: 0.06),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(kat['ikon'] as IconData,
                                              color: secili ? Colors.white : kat['renk'],
                                              size: 28),
                                          const SizedBox(height: 6),
                                          Text(kat['ad'],
                                              style: TextStyle(
                                                  color: secili ? Colors.white : Colors.black87,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ── ÜRÜN SAYISI ───────────────────────────
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Ürünler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text('${filtreliUrunler.length} ürün',
                                style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),

                    // ── ÜRÜN GRİDİ ───────────────────────────
                    filtreliUrunler.isEmpty
                        ? SliverToBoxAdapter(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(40),
                                child: Column(
                                  children: [
                                    const Icon(Icons.search_off, size: 64, color: Colors.grey),
                                    const SizedBox(height: 16),
                                    Text('Bu kategoride ürün bulunamadı',
                                        style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SliverPadding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            sliver: SliverGrid(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.72,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final urun = filtreliUrunler[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (_) => DetaySayfasi(urun: urun, sepeteEkle: widget.sepeteEkle)));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withValues(alpha: 0.06),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4))
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(14),
                                              child: Container(
                                                width: double.infinity,
                                                height: 110,
                                                color: urun.renk.withValues(alpha: 0.08),
                                                child: Image.network(
                                                  urun.gorselUrl,
                                                  fit: BoxFit.contain,
                                                  loadingBuilder: (context, child, progress) {
                                                    if (progress == null) return child;
                                                    return Center(child: CircularProgressIndicator(color: urun.renk, strokeWidth: 2));
                                                  },
                                                  errorBuilder: (context, error, stack) =>
                                                      Icon(Icons.image_not_supported_outlined, color: urun.renk, size: 40),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(urun.kategori,
                                                style: TextStyle(color: urun.renk, fontSize: 11, fontWeight: FontWeight.w600)),
                                            const SizedBox(height: 2),
                                            Text(urun.ad,
                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis),
                                            const SizedBox(height: 2),
                                            Text(urun.marka,
                                                style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('₺${urun.fiyat.toStringAsFixed(0)}',
                                                    style: TextStyle(color: urun.renk, fontWeight: FontWeight.bold, fontSize: 14)),
                                                GestureDetector(
                                                  onTap: () => widget.sepeteEkle(urun),
                                                  child: Container(
                                                    padding: const EdgeInsets.all(6),
                                                    decoration: BoxDecoration(color: urun.renk, borderRadius: BorderRadius.circular(8)),
                                                    child: const Icon(Icons.add, color: Colors.white, size: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                childCount: filtreliUrunler.length,
                              ),
                            ),
                          ),
                  ],
                ),
    );
  }
}